% use_module(library(clpq)).  

% {A = B * C, B = 5}. % wil not give exact values

% {A = 20, B = 5, C = X}.

% {A = B * C, B = 5}, {A = 20, B = 5, C = X}.

% {A = B / 3, B = 12}.

:- use_module(library(clpq)).  

mult(A, B, C) :- {A = B * C}.

% Ex:
% ?- mult(A, 5, C).
% ?- mult(20, B, 4).

div(A, B, C) :- {A = B / C}.

% Ex:
% ?- div(A, 12, 3).
% ?- div(4, B, C).

% -------------------------------------------------------------------------------------------
%:- use_module(library(clpq)).  

%% linear equation and linear inequality

% use_module(library(clpq)). 
% {X + 2*Y = 5, Y >= 1}.

% finds general solution, does not give values to X or Y because Y can vary as long as it is greater than or equal to 1.

lin_eq(X, Y) :- {X + 2*Y = 5, Y >= 1}.

% Ex:
% ?- lin_eq(X, Y).
% ?- lin_eq(1, Y).

% --------------------------------------------

%% Use both libraries

%:- use_module(library(clpq)).  % rational (exact)
%:- use_module(library(clpr)).  % real (floating point)

%clpr:{Ar+Br=10}, Ar=Br, clpq:{Aq+Bq=10}, Aq=Bq.

% Ex:
% ?- clpq:{X = 1/3}.
% ?- clpr:{X = 1/3}.
% --------------------------------------------

%% Entailed

% use_module(library(clpq)).
% {A=<4}, entailed(A=\=5).
% {A=<4}, entailed(A=\=3).

%:- use_module(library(clpq)).  

check_entailed(A) :- 
    {A =< 4}, 
    entailed(A =\= 5).

% Ex:
% ?- check_entailed(A).
% ?- {A =< 4}, entailed(A =\= 3).
%  A=4,3,2,1, entailed->verifica se A nunca pode ser 3, o que é false

% --------------------------------------------

%% Supremum -  retorna o max da função objetivo, mas não atribui valores às variáveis

% use_module(library(clpq)). 
% { 2*X+Y =< 16, X+2*Y =< 11, X+3*Y =< 15, Z = 30*X+50*Y}, sup(Z, Sup).

%  introduces auxiliary variables

%:- use_module(library(clpq)).  

supremum(X, Y, Z, Sup) :- 
    { 2*X+Y =< 16, 
      X+2*Y =< 11, 
      X+3*Y =< 15, 
      Z = 30*X+50*Y}, 
    sup(Z, Sup).

% Ex
% ?- supremum(X, Y, Z, Sup).

%% vs Maximize ---------------------------------------------------------

% { 2*X+Y =< 16, X+2*Y =< 11, X+3*Y =< 15, Z = 30*X+50*Y}, maximize(Z).

% returns X and Y values as well as Z

%:- use_module(library(clpq)).  

find_max(X, Y, Z) :- 
    { 2*X+Y =< 16, 
      X+2*Y =< 11, 
      X+3*Y =< 15, 
      Z = 30*X+50*Y}, 
      maximize(Z).

% Exemplo interativo:
% ?- find_max(X, Y, Z).


% --------------------------------------------

%:- use_module(library(clpq)).

%% infimum - retorna o min da função objetivo, mas não atribui valores às variáveis

infimum(X, Y, Z, Inf) :- 
    {X + Y >= 3, 
     X >= 0, 
     Y >= 0, 
     Z = 3*X + 5*Y},
     inf(Z, Inf).

% ?- infimum(X, Y, Z, Inf).

%% Vs Minimize -------------------------------

%:- use_module(library(clpq)). 

find_min(X) :-  
     { X + 3 >= 10 },  % X must be at least 7  
     minimize(X).      % Finds the smallest possible X

% ?-  find_min(X).

% --------------------------------------------

%% Mortgage

% imprecise library clpr; replace clpr with clpq to get exact results.
%use_module(library(clpr)).

mg(P,T,I,B,MP):-
    { T = 1,
      B + MP = P * (1 + I)
    }.
mg(P,T,I,B,MP):-
    { T > 1,
      P1 = P * (1 + I) - MP,
      T1 = T - 1
    },
    mg(P1, T1, I, B, MP).

% compute the balance if we get an interest of 5% over a period of 30 years
% mg(1000, 30, 5/100, B, 0).

% compute the linear relation between the initial balance, the final balance and the withdrawal
% mg(B0, 30, 5/100, B, MP).

% --------------------------------------------

%% Meta-programming
%:-use_module(library(clpq)).

%?- {X + Y >= 3, X >= 0, Y >= 0, Z = 3*X + 5*Y}, bb_inf([X,Y], Z, Inf).
%inf quando as variáveis podem assumir valores fracionários e você deseja uma solução rápida.
%bb_inf quando as variáveis devem ser inteiras ou quando o problema é discreto.

% {2*A+B+C=10,C-D=E,A<10}, dump([A,B,C,D,E],[a,b,c,d,e],Constraints).