;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 12
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: wj_dfs.lisp

;;; Modification of code from http://lazytoad.com/lti/ai/hw1-1.html (1994)
;;; (Accessed 2014 Sep 11)

;;; This program solves the water jug problem using depth-first-search algorithm.

;;; Depth first search with state limit
(defun dfs (state depth limit)
    (setq *nodes* 0)
    (setq *expanded* 0)
    (setq *branches* 0)
    (setq *limit* limit)
    (setq *result* (dfs-expand-node state depth))
    (print (list "nodes ="  *nodes* "expanded = " *expanded* 
      "branches = " *branches*))
    *result*
)

;;; dfs-expand-node expands a node and calls dfs-children to recurse on it
(defun dfs-expand-node (state depth)
    (setq *nodes* (+ 1 *nodes*))
    (cond
  ((goalp state) (list state))
  ((zerop depth) nil)
  ((> *nodes* *limit*) nil)
  ((let ((children (new-states state)))
       (setq *expanded* (+ 1 *expanded*))
       (setq *branches* (+ (length children) *branches*))
       (print "open = ") (print children)
       (let ((result (dfs-children children (- depth 1))))
     (and result (cons state result))))))) ; backtrack if goal state is not found

;;; dfs-children expands each node recursively and calls dfs-expand-node to process
(defun dfs-children (states depth)
    (cond
  ((null states) nil)
  ((dfs-expand-node (car states) depth))
  ((dfs-children (cdr states) depth))))