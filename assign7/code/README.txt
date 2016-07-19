;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 Dec 10
;;;; Course: ICS361                   Assignment: Assignment 7   
;;;; File name: README.txt

Code was taken from: http://aima.cs.berkeley.edu/lisp/
For this assignment I modified files in the 'agents' and 'utilities' folders.
The remaining folders I removed.

List of files modified:

code\aima.lisp
code\agents\agents\vacuum.lisp
code\agents\environments\grid-env.lisp
code\agents\environments\vacuum.lisp

To run:

from root of code folder run: 

    (load "c:/Users/kbarroga/Downloads/code/aima.lisp")

This should load all files from the 'agents' and 'utilities' folder.

To test an agent in the environment run: 

    (run-environment (make-vacuum-world :aspec '(reactive-vacuum-agent)))

the program will output the state of the environment at each step

To run program without displaying output only results: 

    (run-environment (make-vacuum-world :stream nil 
                                        :aspec '(reactive-vacuum-agent)))

-------------------------------------------------------------------------------

The robot agent in this program is a very 'stupid' agent. I did not create
a new intelligent vacuum agent. I modified the existing reactive vacuum agent
which only reacts when it bumps into an obstacle (wall or recycle bin). After 
it senses that it hit an obstacle, it randomly chooses one of the moving 
actions such as turn (left or right), forward, up, down, left, or right. If it 
detects dirt which in this case is a can/bottle it sucks or picks it up.
The moving actions up, down, left, and right does not depend on the 
orientation of the head. The forward and turn actions do so.
The robot can terminate or shut-off only at home base, the starting location, 
cell (1,1). This means that the robot can terminate at the start of the run,
meaning that it will not pick up any cans/bottles. Or it will never terminate
in larger environments.
As observed in the 5x5 grid environment, I had to run the agent several times,
because it would shut-off even without moving one cell in any direction.
Likewise in the larger 9x9, and 15x15 environment, there was some runs in 
which it did not get back to home base to shut-off, therefore the program ran
endlessly. There were other times where the robot would clean up half of the environment and leave the other half dirty because it made its way back to home base and shut-off.
There are many modifications that can be implemented to make this vacuum agent more intelligent. Due to time constraints and other priorities, I had to leave it as is... a very simple and stupid vacuum agent.

-------------------------------------------------------------------------------

I only completed 5 of 8 requirements:

1. Represent the robot in the environment with a "R" | Robot always starts in location (11)

The default start location of the robot agent is found in grid-env.lisp
The location is defined in the grid-environment structure: 

    (start (@ 1 1))

By default an agent is represented by an integer depending on how many agents is initialized in the environment. To represent the robot with a capital "R" I added the name parameter with value "R" to the agent-body defstruct as shown below.

    (defstruct (agent-body (:include object (alive? t) (name "R")))
      "An agent body is an object; some bodies have a hand that can hold 1 thing."
      (holding nil))

2. - Describe all actions the robot needs to complete its task

Percepts:

bump - perceive an obstacle(wall, bin, homebase, recycle bin)
dirt - perceive dirt/can/bottle to suck or pickup
home - perceive homebase, starting location
bin  - perceive recycle bin/trash receptacle

Actions implemented:

suck     - suck in dirt or cans/bottles
forward  - move forward on cell
turn     - turn 90 degrees(left or right) to change heading position
shut-off - power off
up       - move up one cell (not dependent on head position)
down     - move down one cell (not dependent on head position)
left     - move left one cell (not dependent on head position)
right    - move right one cell (not dependent on head position)

Additional actions (not implemented):

empty/dump - clean out dirt/cans/bottle in robot, sense when holder is almost full
charge     - if robot is cordless, have a low charge threshold, sense when charge is low

3. - Create the cans/bottles

Creating the cans/bottles was used with the cspec option in the grid-environment. By default it used a dirt-factor specification which randomly created dirt in all free locations by the dirt-factor parameter. I have modified the cspec option to create 'i' cans/bottles in 'i' random locations.
cspec option:

    ((* i dirt) )) 

4. - Create the recycling bin "B" in the specified location in environment

I created a new obstacle object to represent the recycling bin as "B" in grid-env.lisp.
I added it as a bspec option in vacuum-world structure in vacuum.lisp. It takes two integers (X, Y) for the specified location in the environment.

    '(at (X Y) bin)
    
    (defstruct (obstacle (:include object (name "B"))))
    (defstruct (bin (:include obstacle)))

5. - Enhance the robot's ability to move in all 4 directions - up down left right

This macro allows the robot to move four directions independent of head orientation. It behaves the same was as the forward action not dependent on which way the head is facing.

Directions: R^: (0 1)
            RV: (0 -1)
            R<: (-1 0)
            R>: (1 0)

    (defmacro direction-generator (name direction)
      `(defmethod ,name ((env vacuum-world) agent-body)
         (setf (object-heading agent-body)
         ,direction)
         (forward env agent-body)))
    
    (progn
      (direction-generator up '(0 1))
      (direction-generator down '(0 -1))
      (direction-generator left '(-1 0))
      (direction-generator right '(1 0)))