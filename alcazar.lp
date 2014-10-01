%paths can exist between any adjacent blocks
path(X,Y,X+1,Y) :- block(X,Y), block(X+1,Y),
                   not npath(X+1,Y,X,Y), not path(X+1,Y,X,Y).
path(X,Y,X-1,Y) :- block(X,Y), block(X-1,Y),
                   not npath(X-1,Y,X,Y), not path(X-1,Y,X,Y).
path(X,Y,X,Y+1) :- block(X,Y), block(X,Y+1),
                   not npath(X,Y+1,X,Y), not path(X,Y+1,X,Y).
path(X,Y,X,Y-1) :- block(X,Y), block(X,Y-1),
                   not npath(X,Y-1,X,Y), not path(X,Y-1,X,Y).

%paths can exist to and from exits
path(X,Y,X+1,Y) :- exit(X,Y), block(X+1,Y),
                   not path(X+1,Y,X,Y), not npath(X,Y,X+1,Y).
path(X,Y,X-1,Y) :- exit(X,Y), block(X-1,Y),
                   not path(X-1,Y,X,Y), not npath(X,Y,X-1,Y).
path(X,Y,X,Y+1) :- exit(X,Y), block(X,Y+1), 
                   not path(X,Y+1,X,Y), not npath(X,Y,X,Y+1).
path(X,Y,X,Y-1) :- exit(X,Y), block(X,Y-1),
                   not path(X,Y-1,X,Y), not npath(X,Y,X,Y-1).

path(X,Y,X+1,Y) :- block(X,Y), exit(X+1,Y),
                   not path(X+1,Y,X,Y), not npath(X,Y,X+1,Y).
path(X,Y,X-1,Y) :- block(X,Y), exit(X-1,Y),
                   not path(X-1,Y,X,Y), not npath(X,Y,X-1,Y).
path(X,Y,X,Y+1) :- block(X,Y), exit(X,Y+1),
                   not path(X,Y+1,X,Y), not npath(X,Y,X,Y+1).
path(X,Y,X,Y-1) :- block(X,Y), exit(X,Y-1),
                   not path(X,Y-1,X,Y), not npath(X,Y,X,Y-1).

%if there is no path in one direction, there is no path in the opposite
%direction as well
npath(X1,Y1,X2,Y2) :- npath(X2,Y2,X1,Y1).

%no path exists if there is not a path in either direction
npath(X1,Y1,X2,Y2) :- block(X1,Y1), block(X2,Y2),
                      not path(X1,Y1,X2,Y2), not path(X2,Y2,X1,Y1).
npath(X1,Y1,X2,Y2) :- block(X1,Y1), exit(X2,Y2),
                      not path(X1,Y1,X2,Y2), not path(X2,Y2,X1,Y1).
npath(X1,Y1,X2,Y2) :- exit(X1,Y1), block(X2,Y2),
                      not path(X1,Y1,X2,Y2), not path(X2,Y2,X1,Y1).

%there is no path from block A to block B if there is a wall between them
npath(X1,Y1,X2,Y2) :- wall(X1,Y1,X2,Y2).

%exactly one path can exist into and out of any given block
pathin(X,Y) :- 1 { path(X2,Y2,X,Y) } 1, block(X,Y).
pathout(X,Y) :- 1 { path(X,Y,X2,Y2) } 1, block(X,Y).

twopaths(X,Y) :- row(Y), col(X), 1 { pathin(X,Y) } 1, 1 { pathout(X,Y) } 1.

:- not twopaths(X,Y), block(X,Y).

%exactly one exit should be used in either direction
exitin(X,Y) :- path(X,Y,X2,Y2), exit(X,Y), not path(X2,Y2,X,Y).
exitout(X,Y) :- path(X2,Y2,X,Y), exit(X,Y), not path(X,Y,X2,Y2).

twoexits :- 1 { exitin(X,Y) } 1, 1 { exitout(X,Y) } 1.

:- not twoexits.

%the solution cannot contain a path from a block to itself (i.e. a loop)
route(X1,Y1,X2,Y2) :- path(X1,Y1,X2,Y2).
route(X1,Y1,X3,Y3) :- route(X1,Y1,X2,Y2), path(X2,Y2,X3,Y3).

:- route(X,Y,X,Y).

#hide col(X).
#hide row(Y).
#hide block(X,Y).
#hide npath(X1,Y1,X2,Y2).
#hide twopaths(X,Y).
#hide twoexits.
#hide exit(X,Y).
#hide wall(X1,Y1,X2,Y2).
#hide exitin(X,Y).
#hide exitout(X,Y).
#hide pathin(X,Y).
#hide pathout(X,Y).
#hide route(X1,Y1,X2,Y2).
