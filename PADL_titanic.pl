

	%f_domain ie. determines the domain for every feature


		
			
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

		
		%#show before_int_pclass/1, not before_int_pclass/1.
		%#show before_int_pclass/1.
		not_before_int_pclass(X):- f_domain(pclass, Y), before_int_pclass(Y), Y \= X. 
		before_int_pclass(X):- not not_before_int_pclass(X).

	%after_int_pclass: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
	%what we want is to create a before intervention world and an after intervention world
		
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
	% 0: perishes
	% 1: survives
	

	% Human Intuitive FOLD-SE RULE
		
		%survived(X,'0') :- not sex(X,'female').
		%survived(X,'0') :- class(X,'3'), sex(X,'female'), fare(X,N1), not(N1=<24.15).
		
	% SCASP Rules:
		perish(X,Y,Z) :- pclass(X), sex(Y), fare(Z), Y\= female.
		perish(X,Y,Z) :- pclass(X), sex(Y), fare(Z), X = 3, Y = female, Z #>24.15.
		


% Decision rule to claaify if a person perishes
#show lite_perish/3, not lite_perish/3.


lite_perish(_,B,_):- B \= female. 
lite_perish(A,B,C):- A = 3, B = female, C #>24.15.



% Debug hence new rules (Msade up)

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


	% Used to measure the total cost of intervention: 0 for no intervention (impossible);
	% 1 for intervention on 1 feature, 6 for intervention on 6 features
		measure(Z1,Z2,Z3,X):- f_domain(control,Z1)
									, f_domain(control,Z2)
								   	, f_domain(control_N,Z3)
									, Q3 #= Z3*Z3
									, X #= Z1+Z2+Q3.


% Control Rules
		%Comments
			% 0: Features Remain Unchanged
			% 1: Features will be changed
			% Category: 1- New CF feauture WILL take a different value
			% Numbers: +1- New CF feature will be greater than original
			% Numbers: -1- New CF feature will be less than original
		
		compare_C(X,X,0).
		compare_C(X,Y,1):- X\=Y.

		compare_N(X,X,0).
		compare_N(X,Y,1):- X#<Y.
		compare_N(X,Y,-1):- X#>Y.


% Craig Interpolant: Highlighting what all features 
	%Comment
		% need to be intervened on to resolve the inconsistency. 
		% pre-intervention world (prefix: before_int): Agrees with the decision '<=50K'
		% post-intervention world(prefix: after_int): Disagrees with the decision '<=50K'
		% The pre and post intervention world are inconsistent. 

	% Z1, Z2, Z3 are the control variables which may indicate the inconsistency
		% 1/-1: Feature is intervened on which may contribute to resolving inconsistency
		% 0: Feature is not intervened on
		% Note just because a Z1-Z6 may have 1 or -1 does not mean that feature is inconsistent. 
		% it merely indicates that the variable was intervened on to move into the post intervention world.



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