alcazar-solver
==============

A solver for Alcazar puzzles using Clingo.

Puzzles should be described as in the example in testpuzzle.lp,
and executed using the command clingo puzzle.lp alcazar.lp

puzzle construction:

declare the number of rows and columns using 
col(1..a).
row(1..b).

generate the grid with

b { block(X,Y) : row(Y) } b :- col(X).
a { block(X,Y) : col(X) } a :- row(Y).

declare locations of walls with

wall(x1,y1,x2,y2).

where block(x1,y1) and block(x2,y2) are separated by walls,
and declare locations of exits using

exit(x,y).
