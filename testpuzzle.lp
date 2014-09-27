%describe the dimensions of the puzzle
row(1..3).
col(1..3).

%generate the squares on the board
3 { block(X,Y) : row(Y) } 3 :- col(X).
3 { block(X,Y) : col(X) } 3 :- row(Y).

%define any exits
exit(3,0).
exit(1,4).

%define any walls
wall(2,1,2,2).
