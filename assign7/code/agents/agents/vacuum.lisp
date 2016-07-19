;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Dec 10
;;;; Course: ICS361                   Assignment: Assignment 7   
;;;; File name: vacuum.lisp

;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*- Author: Peter Norvig

;;;; Some simple agents for the vacuum world

(defstructure (random-vacuum-agent 
   (:include agent
    (program 
     #'(lambda (percept)
	 (declare (ignore percept))
	 (random-element 
	  '(suck forward (turn right) (turn left) shut-off))))))
  "A very stupid agent: ignore percept and choose a random action.")

(defstructure (reactive-vacuum-agent 
   (:include agent
    (program 
     #'(lambda (percept)
	 (destructuring-bind (bump dirt home) percept
	   (cond (dirt 'suck)
		 (home (random-element '(shut-off forward (turn right))))
		 (bump (random-element '((turn right) (turn left) up down left right)))
		 (t (random-element '(forward forward forward up down left right
					      (turn right) (turn left))))))))))
  "When you bump, turn randomly; otherwise mostly go forward, but
  occasionally turn.  Always suck when there is dirt.")


