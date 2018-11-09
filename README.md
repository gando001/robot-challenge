# robot-challenge

[![Build Status](https://travis-ci.com/gando001/robot-challenge.svg?branch=master)](https://travis-ci.com/gando001/robot-challenge)

Simple console app that mimics a robots movements on a grid

## Description

* The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
* There are no other obstructions on the table surface.
* The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
that would result in the robot falling from the table must be prevented, however further valid movement commands must still
be allowed.

Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
BLOCK X,Y
```

* PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
* The origin (0,0) can be considered to be the SOUTH WEST most corner.
* The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
* MOVE will move the toy robot one unit forward in the direction it is currently facing.
* LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
* REPORT will announce the X,Y and orientation of the robot.
* BLOCK will add an obstacle n position X,Y
* A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.
* Provide test data to exercise the application.

## Constraints:

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.
The robot cannot move or be placed in a position that has an obstacle. An obstacle cannot be placed where the robot is currently positioned.

Example Input and Output:

```
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

## Setup

* Install Ruby 2.5.1
* Install bundler
```
gem install bundler
```
* Clone this repo:
```
https://github.com/gando001/robot-challenge
```
* Change directory:
```
cd robot_challenge
```
* Run install gems
```
bundle install
```

### Running the Robot Challenge

```
cd robot_challenge
ruby lib\robot_challenge.rb
```

Optionally specify the number of rows and columns for the grid (defaults to a 5x5 grid)
```
ruby lib\robot_challenge.rb 10 10
```

### Running the Robot Challenge Tests

```
cd robot_challenge
rake
```

Further test scenarios are available in test_data/test_scenarios.txt
