;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 10
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: fwgc.lisp

;;; The code was taken from the ICS361 laulima resources.

;;; This file contains the move rules for the farmer-wolf-goat-cabbage problem
;;; discussed in chapter 7. These functions can be used with the 
;;; general search algorithms found in the resources section of
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

;;; These functions define legal moves in the state space.  They take
;;; a state as argument, and return the state produced by that operation.

(defun farmer-takes-self (state)
   (safe (make-state (opposite (farmer-side state))
        (wolf-side state)
        (goat-side state)
        (cabbage-side state))))


(defun farmer-takes-wolf (state)
   (cond ((equal (farmer-side state) (wolf-side state))
                     (safe (make-state (opposite (farmer-side state))
                                            (opposite (wolf-side state))
                                            (goat-side state)
                                            (cabbage-side state))))
        (t nil)))

(defun farmer-takes-goat (state)
   (cond ((equal (farmer-side state) (goat-side state))
                  (safe (make-state (opposite (farmer-side state))
                                         (wolf-side state)
                                         (opposite (goat-side state))
                                         (cabbage-side state)))) 
        (t nil)))

(defun farmer-takes-cabbage (state)
   (cond ((equal (farmer-side state) (cabbage-side state))
                    (safe (make-state (opposite (farmer-side state))
                                           (wolf-side state)
                                           (goat-side state)
                                           (opposite (cabbage-side state)))))   
       (t nil)))



;;; These functions define states of the world and access states
;;; as an abstract data type. These functions return the side
;;; of the river that each character is on.
;;; 'E' represents 'East' and 'W' represents 'West'

(defun make-state (f w g c) (list f w g c))

(defun farmer-side ( state )
   (nth 0 state))  ; or (car state)

(defun wolf-side ( state )
   (nth 1 state))  ; or (cadr state)

(defun goat-side ( state )
   (nth 2 state))  ; or (caddr state)

(defun cabbage-side ( state )
   (nth 3 state))  ; or (cadddr state)

;;; The function "opposite" takes a side and returns the opposite
;;; side of the river.

(defun opposite (side)
   (cond ((equal side 'e) 'w)
             ((equal side 'w) 'e)))

;;; Safe returns nil if a state is not safe; it returns the state unchanged
;;; if it is safe.

(defun safe (state)
   (cond ((and (equal (goat-side state) (wolf-side state))
                 (not (equal (farmer-side state) (wolf-side state))))  nil)
            ((and (equal (goat-side state) (cabbage-side state))
                 (not (equal (farmer-side state) (goat-side state)))) nil)
       (t state)))

;;; Global variables that represent start, goal, and list of possible moves

;;; Start state *start*
(setq *start* (make-state 'e 'e 'e 'e))
;;; Goal state *goal*
(setq *goal* (make-state 'w 'w 'w 'w))
;;; Possible moves *moves*
(setq *moves* 
     '(farmer-takes-self farmer-takes-wolf 
      farmer-takes-goat farmer-takes-cabbage))

