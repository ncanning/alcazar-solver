%dimensions of the board
%row(1..3).
%col(1..3).

%create all blocks
%3 { block(X,Y) : col(X) } 3 :- row(Y).
%3 { block(X,Y) : row(Y) } 3 :- col(X).

%create exits
%exit(3,0).
%exit(1,4).

%create walls
%wall(2,1,2,2).

%paths can exist between any orthogonally adjacent squares
path(X,Y,X+1,Y) :- block(X,Y), block(X+1,Y), not npath(X,Y,X+1,Y).
npath(X,Y,X+1,Y) :- block(X,Y), block(X+1,Y), not path(X,Y,X+1,Y).

path(X,Y,X-1,Y) :- block(X,Y), block(X-1,Y), not npath(X,Y,X-1,Y).
npath(X,Y,X-1,Y) :- block(X,Y), block(X-1,Y), not path(X,Y,X-1,Y).

path(X,Y,X,Y+1) :- block(X,Y), block(X,Y+1), not npath(X,Y,X,Y+1).
npath(X,Y,X,Y+1) :- block(X,Y), block(X,Y+1), not path(X,Y,X,Y+1).

path(X,Y,X,Y-1) :- block(X,Y), block(X,Y-1), not npath(X,Y,X,Y-1).
npath(X,Y,X,Y-1) :- block(X,Y), block(X,Y-1), not path(X,Y,X,Y-1).

%paths can exist between an exit and a block as well
path(X,Y,X+1,Y) :- block(X,Y), exit(X+1,Y), not npath(X,Y,X+1,Y).
npath(X,Y,X+1,Y) :- block(X,Y), exit(X+1,Y), not path(X,Y,X+1,Y).

path(X,Y,X-1,Y) :- block(X,Y), exit(X-1,Y), not npath(X,Y,X-1,Y).
npath(X,Y,X-1,Y) :- block(X,Y), exit(X-1,Y), not path(X,Y,X-1,Y).

path(X,Y,X,Y+1) :- block(X,Y), exit(X,Y+1), not npath(X,Y,X,Y+1).
npath(X,Y,X,Y+1) :- block(X,Y), exit(X,Y+1), not path(X,Y,X,Y+1).

path(X,Y,X,Y-1) :- block(X,Y), exit(X,Y-1), not npath(X,Y,X,Y-1).
npath(X,Y,X,Y-1) :- block(X,Y), exit(X,Y-1), not path(X,Y,X,Y-1).

%a path is bidirectional, as is no path
path(X1,Y1,X2,Y2) :- path(X2,Y2,X1,Y1).
npath(X1,Y1,X2,Y2) :- npath(X2,Y2,X1,Y1).

%paths cannot exist through a wall
npath(X1,Y1,X2,Y2) :- wall(X1,Y1,X2,Y2).

%exactly two paths can exist from each block
twopaths(X,Y) :- col(X), row(Y),
                2 { path(X,Y,X2,Y2) } 2.

%exactly two exits used
twoexits :- 2 { path(X,Y,X2,Y2) : exit(X,Y) } 2.

%remove options where there aren't exactly two paths from each block.
:- not twopaths(X,Y), row(Y), col(X).

%remove options where there aren't exactly two exits.
:- not twoexits.


#hide col(X).
#hide row(Y).
#hide block(X,Y).
#hide npath(X1,Y1,X2,Y2).
#hide twopaths(X,Y).
#hide twoexits.
#hide exit(X,Y).
#hide wall(X1,Y1,X2,Y2).
