;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga             Date: 2014 Aug 25
;;;; Course: ICS361                   Assignment: Assignment 1   
;;;; File name: kbarroga1.lisp

(in-package :User) ; optional - this is also in the top line above

;;; This is a program from the Land of Lisp text book by Conrad Barski,
;;; code was taken from the ICS361 website.
;;; This program  simulates a simple guess game between a player and the computer
;;; the only feedback the player can give is if the guess is larger of smaller.

;;; variables for the upper and lower limit of numbers
(defparameter *small* 1)  ; assign '1' to variable '*small*'
(defparameter *big* 100)  ; assign '100' to variable '*big*'

;;; this function calculates a guess of the players number within the defined
;;; upper and lower limits. It uses the average of the two limits to guess the player's number.
(defun guess-my-number ()
     (ash (+ *small* *big*) -1))

;;; this function is called when the previous guess was larger
;;; the 'setf' function changes variable '*big*' to one less the previous guess
;;; then it calls 'guess-my-number' function for a new number
(defun smaller ()
     (setf *big* (1- (guess-my-number)))
     (guess-my-number))

;;; this function is called when the previous guess was smaller
;;; the 'setf' function changes variable '*small*' to one greater than the previous guess
;;; then it calls 'guess-my-number' function for a new number
(defun bigger ()
     (setf *small* (1+ (guess-my-number)))
     (guess-my-number))

;;; function to reset upper and lower limits
(defun start-over ()
   (defparameter *small* 1)  ;assign '1' to variable '*small*'
   (defparameter *big* 100)  ;assign '100' to variable '*big*'
   (guess-my-number))


