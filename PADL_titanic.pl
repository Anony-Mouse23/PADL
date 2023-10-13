



		
			
		% pclass 

			f_domain(pclass, 3).
			f_domain(pclass, 1).
			f_domain(pclass, 2).
			 
			
			%f_domain(pclass, not_3). 


		% sex 

			f_domain(sex, female).
			f_domain(sex, male).		 
			
			%f_domain(sex, not_female). 


			  


% pclass

		
		not_before_int_pclass(X):- f_domain(pclass, Y), before_int_pclass(Y), Y \= X. 
		before_int_pclass(X):- not not_before_int_pclass(X).

		
		%#show after_int_pclass/1, not after_int_pclass/1.
		%#show after_int_pclass/1.
		not_after_int_pclass(X):- f_domain(pclass, Y), after_int_pclass(Y), Y \= X. 
		after_int_pclass(X):- not not_after_int_pclass(X).

% sex
		
		%#show before_int_sex/1, not before_int_sex/1.
		%#show before_int_sex/1.
		not_before_int_sex(X):- f_domain(sex, Y), before_int_sex(Y), Y \= X. 
		before_int_sex(X):- not not_before_int_sex(X).


		
		%#show after_int_sex/1, not after_int_sex/1.
		%#show after_int_sex/1.
		not_after_int_sex(X):- f_domain(sex, Y), after_int_sex(Y), Y \= X. 
		after_int_sex(X):- not not_after_int_sex(X).

% fare
	%#show fare/1, not fare/1.
	#show fare/1.
	fare(X):- X #>= 0, X#=<512.3292.



% FOLD SE Decision to check if one perishes

		
	% SCASP Rules:
		perish(X,Y,Z) :- pclass(X), sex(Y), fare(Z), Y\= female.
		perish(X,Y,Z) :- pclass(X), sex(Y), fare(Z), X = 3, Y = female, Z #>24.15.
		


% Decision rule to claaify if a person perishes
#show lite_perish/3, not lite_perish/3.


lite_perish(_,B,_):- B \= female. 
lite_perish(A,B,C):- A = 3, B = female, C #>24.15.




perish(A,B,C):- f_domain(pclass, A), f_domain(sex, B)
		, before_int_pclass(A)
		, before_int_sex(B)
		, fare(C)
		, lite_perish(A,B,C).

		
%?-perish(A,B,C).



% Counterfactual rule to claaify if a person will NOT perish


cf_perish(A,B,C):- f_domain(pclass, A), f_domain(sex, B)
		, after_int_pclass(A)
		, after_int_sex(B)
		, fare(C)
		, not lite_perish(A,B,C).

		
%?-cf_perish(A,B,C).


% Measure
	f_domain(control,0).
	f_domain(control,1).

	f_domain(control_N,0).
	f_domain(control_N,1).
	f_domain(control_N,-1).


		measure(Z1,Z2,Z3,X):- f_domain(control,Z1)
									, f_domain(control,Z2)
								   	, f_domain(control_N,Z3)
									, Q3 #= Z3*Z3
									, X #= Z1+Z2+Q3.


% Control Rules
		
		compare_C(X,X,0).
		compare_C(X,Y,1):- X\=Y.

		compare_N(X,X,0).
		compare_N(X,Y,1):- X#<Y.
		compare_N(X,Y,-1):- X#>Y.


% Craig Interpolant: Highlighting what all features 
	


	craig(A,B,C,Z1,Z2,Z3,A1,B1,C1,X):-  f_domain(pclass, A), f_domain(sex, B)
		, before_int_pclass(A)
		, before_int_sex(B)
		, fare(C)
		
		, f_domain(pclass, A1), f_domain(sex, B1)
		, after_int_pclass(A1)
		, after_int_sex(B1)
		, fare(C1)
		
		, compare_C(A,A1,Z1)
		, compare_C(B,B1,Z2)
		, compare_C(C,C1,Z3)
	
		, measure(Z1,Z2,Z3,X)

		, lite_perish(A,B,C)
		, not lite_perish(A1,B1,C1).

?-craig(A,B,C,Z1,Z2,Z3,A1,B1,C1,X).