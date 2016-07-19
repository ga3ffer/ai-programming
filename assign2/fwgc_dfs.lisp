;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 10
;;;; Course: ICS361                   Assignment: Assignment 2  
;;;; File name: fwgc_dfs.lisp

;;; The code was taken from the ICS361 laulima resources.

;;; This file contains the depth-first-search algorithm
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
;;; Corrections by Christopher E. Davis (chris2d@cs.unm.edu)
;;; 
;;; 
;;; These programs are copyrighted by Benjamin/Cummings Publishers.
;;;

;;; This file contains the depth first search algorithm from chapter 7.
;;; This version of depth first search does not use open and closed lists
;;; to keep track of states.  Instead, it uses recursion to manage the search.
;;; It takes as arguments a start state, a goal state, and a list of
;;; move functions.

;;; For example, to run depth first search with the farmer, wolf, 
;;; goat, etc. problem, evaluate the definitions found in the file 
;;; farmer_wolf_etc_rules_only, and evaluate:
;
;     (run-depth-first '(e e e e) '(w w w w)
;   '(farmer-takes-self farmer-takes-wolf 
;     farmer-takes-goat farmer-takes-cabbage))
;


(defun depth-first-search (start goal been-list moves)
  (print "open = ") (print been-list)
  (cond ((equal start goal) 
         (reverse (cons start been-list)))
        (t (try-moves start goal been-list moves moves))))

; Try-moves scans down the list of moves in moves-to-try, 
; attempting to generate a child state.  If it produces 
; this state, it calls depth-first-search to complete the search.

(defun try-moves (start goal been-list moves-to-try moves)
  (cond ((null moves-to-try) nil)
        ((member start been-list :test #'equal) nil)
        (t (let ((child (funcall (car moves-to-try) start)))
             (if child 
               (or (depth-first-search (funcall (car moves-to-try) start)
                                       goal
                                       (cons start been-list)
                                       moves)
                   (try-moves start goal been-list (cdr moves-to-try) moves))
               (try-moves start goal been-list (cdr moves-to-try) moves))))))

; run-depth-first calls depth-first-search, initializing the been-list to ().
(defun run-depth (start goal moves)
  (depth-first-search start goal () moves))