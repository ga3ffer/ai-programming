;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 NOV 04
;;;; Course: ICS361                   Assignment: Assignment 4
;;;; File name: ID3-credit-data-orig.lisp

;;;      LISP ID3 Supervised Learning Algorithm: Credit Example
;;; This is one of the example programs from the textbook:
;;;
;;; Artificial Intelligence: 
;;; Structures and strategies for complex problem solving
;;;
;;; by George F. Luger and William A. Stubblefield
;;; 
;;; These programs are copyrighted by Benjamin/Cummings Publishers.
;;;
;;; We offer them for use, free of charge, for educational purposes only.
;;;
;;; Disclaimer: These programs are provided with no warranty whatsoever as to
;;; their correctness, reliability, or any other property.  We have written 
;;; them for specific educational purposes, and have made no effort
;;; to produce commercial quality computer programs.  Please do not expect 
;;; more of them then we have intended.

;;;
;;; To run the credit assessment example, evaluate the contnts of this file, 
;;; then, build a tree and bind it to the variable *tree* by evaluating:
;;;
;;; (setq *tree* (build-tree credit-examples))
;;;
;;; using this tree, you can classify instances.  E.g.
;;;
;;; (classify '((history . good) (debt . low) (collateral . none) (income . 15k-to-35k)) 
;;;            *tree*)
;;;


;;; Functions defining a test example from the credit approval domain.

(setq examples 
      '(((risk . high) (history . bad) (debt . high) 
	 (collateral . none) (income . 0-to-15k))
        ((risk . high) (history . unknown) (debt . high) 
	 (collateral . none) (income . 15k-to-35k))
        ((risk . moderate)(history . unknown) (debt . low) 
	 (collateral . none) (income . 15k-to-35k))
        ((risk . high)(history . unknown) (debt . low) 
	 (collateral . none) (income . 0-to-15k))
        ((risk . low)(history . unknown) (debt . low) 
	 (collateral . none) (income . over-35k))
        ((risk . low)(history . unknown) (debt . low) 
	 (collateral . adequate) (income . over-35k))
        ((risk . high)(history . bad) (debt . low) 
	 (collateral . none) (income . 0-to-15k))
        ((risk . moderate)(history . bad) (debt . low) 
	 (collateral . adequate) (income . over-35k))
        ((risk . low)(history . good) (debt . low) 
	 (collateral . none) (income . over-35k))
        ((risk . low)(history . good) (debt . high) 
	 (collateral . adequate) (income . over-35k))
        ((risk . high)(history . good) (debt . high) 
	 (collateral . none) (income . 0-to-15k))
        ((risk . moderate)(history . good) (debt . high) 
	 (collateral . none) (income . 15k-to-35k))
        ((risk . low)(history . good) (debt . high) 
	 (collateral . none) (income . over-35k))
        ((risk . high)(history . bad) (debt . high) 
	 (collateral . none) (income . 15k-to-35k))))

(defun history (obj)
  (cdr (assoc 'history obj :test #'equal)))

(defun debt (obj)
  (cdr (assoc 'debt obj :test #'equal)))

(defun collateral (obj)
  (cdr (assoc 'collateral obj :test #'equal)))

(defun income (obj)
  (cdr (assoc 'income obj :test #'equal)))

(defun risk (obj)
  (cdr (assoc 'risk obj :test #'equal)))

(setq test-set
      (list
       (make-property 
        :name 'history
        :test #'history
        :values '(good bad unknown))
       (make-property 
        :name 'debt
        :test #'debt
        :values '(high low))
       (make-property 
        :name 'collateral
        :test #'collateral
        :values '(none adequate))
       (make-property 
        :name 'income
        :test #'income
        :values '(0-to-15k 15k-to-35k over-35k))))

(setq classifier 
      (make-property 
       :name 'risk
       :test #'risk
       :values '(high moderate low)))

;;; this is the example frame for this test problem:

(setq credit-examples 
      (make-example-frame 
       :instances examples 
       :properties test-set
       :classifier classifier
       :size (list-length examples)
       :information (compute-information examples classifier)))
