;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 OCT 16
;;;; Course: ICS361                   Assignment: Assignment 3
;;;; File name: dfid.lisp

;;;; MODIFIED CODED FROM
;;;; Artificial Intelligence, Second Edition
;;;; Elaine Rich and Kevin Knight
;;;; McGraw Hill, 1991
;;;; This code may be freely copied and used for educational or research purposes.
;;;; All software written by Kevin Knight.
;;;; https://www-users.cs.umn.edu/~gini/aiprog/

#|----------------------------------------------------------------------------
      ITERATIVE-DEEPENING SEARCH
              "dfid.lisp"
----------------------------------------------------------------------------|#

;; -------------------------------------------------------------------------
;; Function DFID does a depth-first iterative deepening search.  When it 
;; reaches the goal state, it returns a solution path.  DFID calls 
;; DFS-WITH-CUTOFF each time with greater depth, which performs a depth 
;; limited, depth-first search avoiding loops along a single path.

(defun dfid (start &optional verbose)
   (do ((success nil) 
        (depth 1 (1+ depth)))
       (success success)
     (when verbose (format t "Beginning iteration number ~d~%" depth))
     (let ((result (dfs-with-cutoff start depth verbose)))
        (when (not (and (stringp result)
            (string-equal result "No solution.")))
     (setq success result)))))


(defun dfs-with-cutoff (start depth-cutoff &optional verbose)
  (let* ((parents nil)
         (result (dfs-avoid-loops-1 start parents depth-cutoff verbose)))
    (if (null result) "No solution." result)))


(defun dfs-avoid-loops-1 (start parents depth-cutoff verbose)
  (when verbose (format t "Expanding node ~d~%" start))
  (cond ((goal-state? start) (list start))
  ((= depth-cutoff 0) nil)  ; decrease depth-cutoff until it is 0
  (t  (let ((all-succs (expand start)))
         (do ((succs (remove-ida-parents all-succs parents)
         (cdr succs))
        (solution-found nil))
       ((or solution-found (null succs))
        (if solution-found (cons start solution-found) nil))
     (setq solution-found (dfs-avoid-loops-1 (car succs)  
                 (cons start parents)
               (1- depth-cutoff)
                       verbose)))))))


;; -------------------------------------------------------------------------
;; Function IDA-STAR performs a heuristic depth-first iterative deepening 
;; search.  It explores the search space deeper and deeper on each iteration;
;; during each iteration, it expands all nodes whose g+h values are less
;; than some threshold.  
;;
;; The threshold is initialized to *infinity* before we call IDA-STAR-DFS
;; during an iteration, and is augmented by the minumum amount it was exceeded 
;; during that iteration.

(defvar *amount-exceeded* 0)

(defun ida-star (start &optional verbose)
   (do ((solution-found nil) 
  (iteration 1 (1+ iteration))
  (threshold (heuristic start)))
       (solution-found solution-found)
     (when verbose (format t "Beginning iteration number ~d, threshold = ~d~%"
         iteration threshold))
     (setq *amount-exceeded* *infinity*)
     (let ((parents nil)
     (depth 0))
        (setq solution-found 
    (ida-star-dfs start parents threshold depth verbose)))
     (setq threshold (+ threshold *amount-exceeded*))))


;; Function IDA-STAR-DFS performs heuristic threshold-limited depth-first 
;; search avoiding loops along a single path.

(defun ida-star-dfs (start parents threshold cost-so-far verbose)
  (cond ((goal-state? start) (list start))
  ((> (+ cost-so-far (heuristic start)) threshold)
   (setq *amount-exceeded* (min *amount-exceeded*
              (- (+ cost-so-far (heuristic start))
           threshold)))
   nil)
  (t 
   (when verbose (format t "Expanding node ~d~%" start))
   (let ((all-succs (expand start)))
     (do ((succs (remove-ida-parents all-succs parents)
           (cdr succs))
          (solution-found nil))
         ((or solution-found (null succs))
          (if solution-found (cons start solution-found) nil))
       (setq solution-found (ida-star-dfs (car succs)  
                  (cons start parents)
            threshold
            (+ cost-so-far
               (cost-of-move start 
                 (car succs)))
                  verbose)))))))

(defun remove-ida-parents (all-succs parents)
  (mapcan #'(lambda (succ)
    (if (member succ parents :test #'eq-states)
        nil
        (list succ)))
    all-succs))
