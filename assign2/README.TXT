;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Sep 16
;;;; Course: ICS361                   Assignment: Assignment 2   
;;;; File name: README.TXT

- FARMER-WOLF-GOAT-CABBAGE
  
  - CODE FILES: fwgc.lisp | fwgc_bfs.lisp | fwgc_dfs.lisp

  - TRANSCRIPT FILE: kbarroga2OUTA.txt

  - REPORT: The strategies used to find a solution to the Farmer-Wolf-Goat-Cabbage problem is best-first-search and depth-first-search. Breadth-first-search maintains the *open* list using a queue, first-in-first-out (FIFO) data structure. The *open* list is evaluated, if it is NIL it returns NIL, else first element of *open* is looked at. If it equals the goal, then success, else the generate-descendants function is called to find the children of the current state, then appends it to the *open* list. run-breadth is used to initialize the global variables *open*, *closed*, and *goal*.

  The depth-first-search strategy does not use open and closed lists to keep track of states. Instead, it uses recursion to manage the search. It takes as arguments a start state, a goal state, and a list of move functions.

  - NUMBER OF DIFFERENT STATES: The theoretical number of states for breadth-first-search calculated by b^d, b - max branching factor, d - depth of the least cost solution, would be 4^7 which yields 16384 different states. However since many of the states are not valid because they violate the rules there are only two valid paths to the goal yielding 10 valid different states.

  For the depth-first-search the number of states calculated by b*m, b - max branching factor, m - max depth of the state-space, 4*7 = 28 different states. Although like breadth-first-search, there are only two valid paths in the search space, with only 10 valid states. 


- WATER JUGS

  - CODE FILES: wj.lisp | wj_dfs.lisp

  - TRANSCRIPT FILE: kbarroga2OUTB.txt

  - REPORT: Depth-first-search is the strategy that is being used to solve the water jug problem because it gets quickly into deep search space. This strategy is best for solution with known long paths, because it will not waste time searching the shallow states of the tree. On the other hand Depth-first-search can get deep down the levels and get lost. So a compromise is Depth-first iterative deepening. With this search the depth can be specified to prevent the algorithm from getting lost too deep in the depths.

  - NUMBER OF DIFFERENT STATES: Depth-first search is much more efficient for search spaces with many branches because it does not have to keep all the nodes at a given level on the open list. The space usage of depth-first search is a linear function of the length of the path. At each level, the algorithm retains only the children of a single state. Since the depth-first-search algorithm depends on a depth limit the number of different states possible is b*l, b - max branching factor, l - depth cutoff. 

  I have sample output of testing the algorithm with different depths in the transcript file provided (kbarroga2OUTB.txt). As can be seen from the sample output, if the open *nodes* is less then the *limit* defined, the function will return NIL. This is to limit the search space to prevent the algorithm getting lost deep in the search space. The minimal depth that depth-first-search has to traverse to find a solution is 6 levels.

  *** I include the open list on the first three runs only. The open list are omitted for test runs after that.

- 8 PUZZLE

  - CODE FILES: 8_puzzle.lisp | 8_puzzle_bfs.lisp

  - TRANSCRIPT FILE: kbarroga2OUTC.txt

  - REPORT: Breadth-first-search search strategy. The breadth-first-search strategy was used instead of depth-first-search to limit the depth of the searches and for better time complexity restraints. For a problem with many long paths this strategy is best because it will not waste time searching the shallow states of the tree. However depth-first-search can travel deep down the levels and get 'lost'.

   *** I include the open list for the solution. The open list are omitted for test runs after that.

  - NUMBER OF DIFFERENT STATES: Assuming that the puzzle has a valid starting position to reach the goal state. The number of different states comes to 9!/2 = 362880/2 = 181440. The factorial of n number of permutations is divided in half to exclude the unsolvable states. 

  - 15 PUZZLE
  
    - NUMBER OF DIFFERENT STATES: Similar to the 8 puzzle problem, assuming that the puzzle starts in a valid configuration. The factorial of n number of permutations is divided in half to exclude the unsolvable states. There is 16!/2 different states. 16!/2 = 2.092278989×10^13 = 1.046139494×10^13