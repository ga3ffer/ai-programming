;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 NOV 04
;;;; Course: ICS361                   Assignment: Assignment 4
;;;; File name: cobweb-engine-data.lisp

;;; Additional sample animal data for COBWEB

(setf *feature-names* '(stroke cylinders layout cubic-centimetre-range rpm hp torque))

(setf *domains* 
      '((two four diesel other) (one two three four five six eight other)
        (single straight v boxer parallel wankel rotary turbine electric)
        (50-125 250-500 600-750 800-1000 990 1200+) (low medium high)
        (low medium high) (low medium high))) 

(setf *raw-examples*
      '(
  (Single-Cylinder  (four      one   single   50-125   low    low    medium))
  (In-Line-Parallel (four      two   parallel 250-500  medium medium medium))
  (In-Line-Triple   (four      three straight 600-750  high   high   high))
  (In-Line-Four     (four      four  straight 800-1000 high   high   high))
  (In-Line-Six      (four      six   straight 1200+    high   high   medium))
  (V-Twin           (four      two   v        800-1000 low    medium high))
  (V-Twin-Four      (four      four  v        800-1000 medium medium high))
  (Boxer-Two        (four      two   boxer    1200+    high   medium high))
  (Boxer-Four       (four      four  boxer    800-1000 high   high   high))
  (Boxer-Six        (two       six   boxer    1200+    high   high   medium))
  (2S-Single        (two       one   single   50-125   high   medium high))
  (2S-Parallel-Twin (two       two   parallel 250-500  high   high   high))
  (RC211V           (four      five  v        990      high   high   high))
  (V8               (four      eight v        600-750  high   high   high))
  (Wankel           (other     five  wankel   600-750  medium low  medium))
  (Rotary           (other     other rotary   250-500  low    low    low))
  (Turbine          (other     other turbine  1200+    high   high   high))
  (Diesel           (diesel    three straight 800-1000 medium medium high))
       ))

