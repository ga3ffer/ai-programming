;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 10
;;;; Course: ICS361                   Assignment: Assignment 2  
;;;; File name: fwgc_bfs.lisp

;;; The code was taken from the ICS361 laulima resources.

;;; This file contains the breadth-first-search algorithm
;;; discussed in chapter 7. This functions can be used with the 
;;; farmer-wolf-goat-cabbage problem found in the resources section of
;;; ICS361 laulima resources

;;; This is one of the example programs from the textbook:
;;;
;;; Artificial Intelligence: 
;;; Structures and strategies for complex problem solving
;;;
;;; by George F. Luger and William A. Stubblefield
;;; 
;;; These programs are copyrighted by Benjamin/Cummings Publishers.
;;;

;;; This program defines a more sophisticated version of breadth first search.
;;; on finding a solution, it uses a record of each state's parents to print 
;;; the path to the goal.  It is discussed in chapter 7 of the text.
;;;
;;; For example, to run it on the farmer, wolf, goat, etc. problem,
;;; evaluate the definitions of move rules found in the file:
;;;      farmer_wolf-etc-rules-only.lisp
;;;
;;; and then evaluate
;;;
;;; (run-breadth '(e e e e) '(w w w w)
;;;             '(farmer-takes-self farmer-takes-wolf
;;;              farmer-takes-goat farmer-takes-cabbage))


(defun run-breadth (start goal moves)
  (declare (special *open*))
  (declare (special *closed*))
  (declare (special *goal*))
  (setq *open* (list (build-record start nil 0)))
  (setq *closed* nil)
  (setq *goal* goal)
  (breadth-first moves))

;;; These functions handle the creation and access of (state parent) 
;;; pairs.

(defun build-record (state parent depth) (list state parent depth))

(defun get-state (state-tuple) (nth 0 state-tuple))

(defun get-parent (state-tuple) (nth 1 state-tuple))

(defun get-depth (state-tuple) (nth 2 state-tuple))

(defun retrieve-by-state (state list)
  (cond ((null list) nil)
        ((equal state (get-state (car list))) (car list))
        (t (retrieve-by-state state (cdr list)))))



(defun breadth-first (moves)
  (declare (special *open*))
  (declare (special *closed*))
  (declare (special *goal*))
  (print "open = ") (print *open*)
  (print "closed = ") (print *closed*)
  (cond ((null *open*) nil)
        (t (let ((state (car *open*)))
             (setq *closed* (cons state *closed*))
             (cond 
        ;;; found solution: print path to it
            ((equal (get-state state) *goal*) (reverse (build-solution *goal*)))
             
            ;;; try next child state
                (t (setq *open* 
                            (append (cdr *open*)
                                    (generate-descendants (get-state state)(1+ (get-depth state))
                                                          moves)))
                      (breadth-first moves)))))))

(defun generate-descendants (state depth moves)
  (declare (special *open*))
  (declare (special *closed*))
  (cond ((null moves) nil)
        (t (let ((child (funcall (car moves) state))
                 (rest (generate-descendants state depth (cdr moves))))
             (cond ((null child) rest)
                   ((retrieve-by-state child rest) rest)
                   ((retrieve-by-state child *open*) rest)
                   ((retrieve-by-state child *closed*) rest)
                   (t (cons (build-record child state depth) rest)))))))


(defun build-solution (state)
  (declare (special *closed*))
  (cond ((null state) nil)
        (t (cons state (build-solution 
                        (get-parent 
                         (retrieve-by-state state *closed*)))))))