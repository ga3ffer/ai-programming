;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 15
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: 8_puzzle_bfs.lisp

;;; Breadth-first-search search strategy
;;; The breadth-first-search strategy was used instead of depth-first-search
;;; to limit the depth of the searches and for better time complexity restraints.

(defun breadth-first-search (start)
  (let ((open (list start)) ; the list of nodes to be examined
  (closed (list)) ; the list of nodes already examined
  (steps 0) ; number of iterations
  (expanded 0) ; total number of nodes expanded
  (stored 0)) ; max number of nodes stored at any one time
    (loop while open do
      (print "open") (print open)
    (let ((x (pop open))) 
      (when (finished? x)
        (return (format nil "Found ~a in ~a steps.
          Expanded ~a nodes, stored a maximum of ~a nodes." x steps expanded stored)))
      (incf steps)
      (pushnew x closed :test #'equal)
      (let ((successors (successors x)))
        (incf expanded (length successors))
        (setq successors
        (delete-if (lambda (a)
         (or (find a open :test #'equal)
             (find a closed :test #'equal)))
             successors))
        (setq open (append open successors))
        (setq stored (max stored (length open))))))))

