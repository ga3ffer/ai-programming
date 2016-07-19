;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 NOV 04
;;;; Course: ICS361                   Assignment: Assignment 4
;;;; File name: ml-utilities.lisp

;;;; A file of general machine learning utility functions. Always load first.

;;; Variables defining a data set.  See any -DATA file for an example
(defvar *domains*       nil "An ordered list specifying the domain of each feature")
(defvar *feature-names* nil "An ordered list of the names for each feature")
(defvar *categories*    nil "List of categories in a data set")
(defvar *raw-examples*  nil "List of examples in a data file")

;;;;=================================================================================================
;;;; General Utilities
;;;;=================================================================================================


(defmacro trace-print (test-var &rest format-form)
  ;; Print using the format string only if test-var (usually a trace-* variable)is nonNIl
  `(if ,test-var
     (format t ,@format-form)))

(defun seconds-since (time)
   ;;; Return seconds elapsed since given time (initially set by get-internal-run-time)
  (/ (- (get-internal-run-time) time)
     internal-time-units-per-second))

(defun mix-up (list)
  "Randomize the order of elements in this list."
  (mapcar #'(lambda (pair) (rest pair))
	  (sort (mapcar #'(lambda (item) (cons (random 1.0) item)) list)
		#'(lambda (a b) (> (first a) (first b))))))

(defun pick-one (list)
  "Pick an item randomly from the list"
  (nth (random (length list)) list))

(defun append-symbols (&rest symbols)
  "Appends to symbol names and return resulting symbol"
  (intern (format nil "~{~A~}" symbols)))

;;;;=================================================================================================
;;;; Experimental Utilities
;;;;=================================================================================================


(defun train-and-test (systems num-train &optional num-test (examples *raw-examples*)
		       (mix-up? t) print-detailed-test-results)
  "For each system, perform standard train and test on the examples by using the first num-train 
   examples to train and the remaining to test. Randomize order of examples if mix-up? set. Assumes
   functions of the form system-TRAIN and system-TEST"
  
  (if mix-up? (setf examples (mix-up examples)))
  (if (symbolp systems) (setf systems (list systems)))
  (dolist (system systems)
    (let* ((train-function (append-symbols 'train- system))
	   (training-examples (subseq examples 0 num-train))
	   (testing-examples  (if num-test
				  (subseq examples (- (length examples) num-test))
			       (subseq examples num-train)))
	   (start-time (get-internal-run-time))
	   (training-result (funcall train-function training-examples)))
     (format t "~%~%~A train time: ~,2Fs" system (seconds-since start-time))
     (test-system system training-result testing-examples print-detailed-test-results))))


(defun test-system (system training-result test-examples &optional print-detailed-results)
  "Test the system on the given data and print % correct.  If PRINT-DETAILED-RESULTS
   set then print info about each example"
  
  (let ((test-function (append-symbols 'test- system))
	(num-examples (length test-examples))
	(num-correct 0)
	answer)
    (dolist (example test-examples)
      (setf answer (funcall test-function example training-result))
      (when (eq answer (first example)) (incf num-correct))
      (trace-print print-detailed-results "~%Real category: ~A; Classified as: ~A   ~A"
		   (first example) answer (if (eq answer (first example)) "" "**WRONG**")))
    (format t "~%~%~A classified ~,2F% of the ~D test cases correctly."
	    test-function (* 100 (/ num-correct num-examples)) num-examples)))

(defun train-and-test-noise (systems feature-noise-level category-noise-level
				     num-train &optional num-test (examples *raw-examples*)
				     (mix-up? t) print-detailed-test-results)
  "Train and test with artifically adding noise at the given levels (each between 0 and 1)"
  (train-and-test systems num-train num-test (add-feature-and-category-noise examples
						    feature-noise-level category-noise-level)
		  mix-up? print-detailed-test-results))

(defun add-feature-and-category-noise (examples feature-noise-level category-noise-level)
 "Add both feature and category noise to the examples at the given levels.
 That is, with the given probability replace a value with a random value."
  (setf examples (copy-tree examples))
  (dolist (example examples examples)
    (if (>  category-noise-level (random 1.0))
	(setf (first example) (pick-one *categories*)))
    (add-feature-noise-to-instance (second example) feature-noise-level)))


(defun add-feature-noise (examples probability)
 "Add just feature noise to the examples"
  (setf examples (copy-tree examples))
  (dolist (example examples examples)
    (add-feature-noise-to-instance (second example) probability)))


(defun add-feature-noise-to-instance (instance probability)
  "Add feature noise to the instance by replacing each feature with random
   value from domain with the given probability."
      (dotimes (i (length instance) instance)
	(if (>  probability (random 1.0))
	    (setf (nth i instance)
		  (pick-one (nth i *domains*))))))


