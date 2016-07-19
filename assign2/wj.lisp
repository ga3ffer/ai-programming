;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 12
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: wj.lisp

;;; Modification of code from http://lazytoad.com/lti/ai/hw1-1.html (1994)
;;; (Accessed 2014 Sep 11)

;;; This program defines the rules for the water jug problem.
;;; The goal is to produce 4 gallons of water in the larger jug using only
;;; two water jugs, one holding 5 gallons and the other holding 3 gallons.
;;; The jugs can be filled, emptied, and poured into one another.

;;; These functions define legal moves in the state space.  The take
;;; a state as argument, and return the state produced by that operation.

;;; returns the state when first jug is poured into second jug
(defun pour-first-second (state)
    (let (   (f (first-jug state))
       (s (second-jug state)))
  (cond
      ((zerop f) nil)   ; Cant pour nothing
      ((= s 3) nil)   ; Second full
      ((<= (+ f s) 3)   ; Empty first into second
    (make-state 0 (+ f s)))
      (t        ; Fill second from first
    (make-state (- (+ f s) 3) 3)))))

;;; returns the state when second jug is poured into first jug
(defun pour-second-first (state)
    (let (   (f (first-jug state))
       (s (second-jug state)))
  (cond
      ((zerop s) nil)   ; Cant pour nothing
      ((= f 5) nil)   ; First full      
      ((<= (+ f s) 5)   ; Empty second into first
    (make-state (+ f s) 0))     
      (t        ; Fill first from second
    (make-state 5 (- (+ f s) 5))))))

;;; return the state when the first jug is filled (first jug can hold 5)
(defun fill-first (state)
    (cond
  ((< (first-jug state) 5) (make-state 5 (second-jug state)))))

;;; returns the state when the second jug is filled (second jug can hold 3)
(defun fill-second (state)
    (cond
  ((< (second-jug state) 3) (make-state (first-jug state) 3))))

;;; returns the state when first jug is emptied
(defun empty-first (state)
    (cond
  ((> (first-jug state) 0) (make-state 0 (second-jug state)))))

;;; returns the state when second jug is emptied
(defun empty-second (state)
    (cond
  ((> (second-jug state) 0) (make-state (first-jug state) 0))))

;;; The functions below define the creation and access states

;;; Initialize first and second water jugs
(defun make-state (f s) (list f s))

;;; Functions to return state of first and second water jugs
(defun first-jug (state)
  (nth 0 state))  ;or (car state)

(defun second-jug (state)
  (nth 1 state))  ; or (cadr state)

;;; returns all possible states that can be derived from given state
(defun new-states (state)
    (remove-null
  (list
      (fill-first state)
      (fill-second state)
      (pour-first-second state)
      (pour-second-first state)
      (empty-first state)
      (empty-second state))))

;;; remove all null states
(defun remove-null (x)
    (cond
  ((null x) nil)
  ((null (car x)) (remove-null (cdr x)))
  ((cons (car x) (remove-null (cdr x))))))


;;; Global variables and goal state
(setq *start* '(0 0))

;;; checks whether the first jug has reach goal state
(defun goalp (state)
    (eq (first-jug state) 4))