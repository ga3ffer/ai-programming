;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 15
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: 8_puzzle.lisp

;;; This program defines the rules of the classic 8 Puzzle, 
;;; 3x3 grid of sliding blocks. The blocks are numbered 1 through 8 with a blank tile.
;;; The objective of the game is to place the blocks in the order determined by *goal* state,
;;; by moving one block at a time into an adjacent empty space.

;;; The grid is stored and manipulated as a list of integers.  The
;;; symbol b is the blank. 

;;; The list (1 2 3 4 5 6 8 b) is represented as a grid:

;;;                         1 2 3
;;;                         4 5 6
;;;                         7 8 b

;;; These functions define legal moves in the state space.  They take
;;; a state as argument, and return the state produced by that operation.

;;; Move the 'b' on the 3x3 grid one space to the right.  If there
;;; is no space to the right, return NIL.
(defun right (grid)
  (let ((hole (coords (hole grid))))
    (if (= 2 (col hole))
  nil
  (swap (index hole)
        (index (cons (1+ (col hole)) (row hole)))
        grid))))

;;; Move the 'b' on the 3x3 grid one space to the left.  If there
;;; is no space to the left, return NIL.
(defun left (grid)
  (let ((hole (coords (hole grid))))
    (if (zerop (col hole))
  nil
  (swap (index hole)
        (index (cons (1- (col hole)) (row hole)))
        grid))))

;;; Move the 'b' on the 3x3 grid one space up.  If there is no space
;;; up, return NIL.
(defun up (grid)
  (let ((hole (coords (hole grid))))
    (if (zerop (row hole))
  nil
  (swap (index (cons (col hole) (1- (row hole))))
        (index hole)
        grid))))

;;;  "Move the 'b' on the 3x3 grid one space down.  If there is no
;;; space down, return NIL.
(defun down (grid)
  (let ((hole (coords (hole grid))))
    (if (= 2 (row hole))
  nil
  (swap (index (cons (col hole) (1+ (row hole))))
        (index hole)
        grid))))

;;; The functions below define states of the world and access states
;;; Return the index of the 'b'(blank) from grid.
(defun hole (grid)
  (position 'b grid))

(defun col (pair)
  (car pair))

(defun row (pair)
  (cdr pair))

;;; Transform integer index from the list, into an (X . Y)
;;; coordinate pair for a 3x3 grid.
(defun coords (index)
  (cons (second (multiple-value-list (floor index 3)))
  (floor index 3)))

;;; Transform an (X . Y) coordinate pair for a 3x3 grid, into
;;; an integer index.
(defun index (coords)
  (+ (col coords)
     (* 3 (row coords))))

;;; Return a new list with the items at indexes A and B swapped.
(defun swap (a b list)
  (let ((new (copy-seq list)))
    (setf (nth a new)
    (nth b list))
    (setf (nth b new)
    (nth a list))
    new))

;;; Return a list of new grids consisting of all possible moves from grid.
(defun successors (grid)
  (delete nil (list (up grid)
        (down grid)
        (left grid)
        (right grid))))

;;; Return T(True) if grid is in the *goal* state otherwise return NIL.
(defun finished? (grid)
  (equal grid *goal*))

;;; Global variables that represent start, and goal state.
;;; Start state *start*
(setq *start* '(2 8 3 1 6 4 7 b 5))
;;; Goal state *goal*
(setq *goal* '(1 2 3 8 b 4 7 6 5))