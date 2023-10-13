
% physician_fee_freeze
	f_domain(physician_fee_freeze, no).
	f_domain(physician_fee_freeze, yes).



% physician_fee_freeze
	%before_int_physician_fee_freeze: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		not_before_int_physician_fee_freeze(X):- f_domain(physician_fee_freeze, Y), before_int_physician_fee_freeze(Y), Y \= X. 
		before_int_physician_fee_freeze(X):- not not_before_int_physician_fee_freeze(X).

	%after_int_physician_fee_freeze: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
		
		not_after_int_physician_fee_freeze(X):- f_domain(physician_fee_freeze, Y), after_int_physician_fee_freeze(Y), Y \= X. 
		after_int_physician_fee_freeze(X):- not not_after_int_physician_fee_freeze(X).



% budget_resolution
	f_domain(budget_resolution, no).
	f_domain(budget_resolution, yes).



% budget_resolution
	%before_int_budget_resolution: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		not_before_int_budget_resolution(X):- f_domain(budget_resolution, Y), before_int_budget_resolution(Y), Y \= X. 
		before_int_budget_resolution(X):- not not_before_int_budget_resolution(X).

	%after_int_budget_resolution: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
		
		not_after_int_budget_resolution(X):- f_domain(budget_resolution, Y), after_int_budget_resolution(Y), Y \= X. 
		after_int_budget_resolution(X):- not not_after_int_budget_resolution(X).


% anti_satellite_test_ban
	f_domain(anti_satellite_test_ban, no).
	f_domain(anti_satellite_test_ban, yes).



% anti_satellite_test_ban
	%before_int_anti_satellite_test_ban: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		not_before_int_anti_satellite_test_ban(X):- f_domain(anti_satellite_test_ban, Y), before_int_anti_satellite_test_ban(Y), Y \= X. 
		before_int_anti_satellite_test_ban(X):- not not_before_int_anti_satellite_test_ban(X).

	%after_int_anti_satellite_test_ban: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
		
		not_after_int_anti_satellite_test_ban(X):- f_domain(anti_satellite_test_ban, Y), after_int_anti_satellite_test_ban(Y), Y \= X. 
		after_int_anti_satellite_test_ban(X):- not not_after_int_anti_satellite_test_ban(X).


% mx_missile
	f_domain(mx_missile, no).
	f_domain(mx_missile, yes).



% mx_missile
	%before_int_mx_missile: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		not_before_int_mx_missile(X):- f_domain(mx_missile, Y), before_int_mx_missile(Y), Y \= X. 
		before_int_mx_missile(X):- not not_before_int_mx_missile(X).

	%after_int_mx_missile: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
		
		not_after_int_mx_missile(X):- f_domain(mx_missile, Y), after_int_mx_missile(Y), Y \= X. 
		after_int_mx_missile(X):- not not_after_int_mx_missile(X).



% education_spending
	f_domain(education_spending, no). % no
	f_domain(education_spending, yes).  % yes
	f_domain(education_spending, missing). %missing



% education_spending
	%before_int_education_spending: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		not_before_int_education_spending(X):- f_domain(education_spending, Y), before_int_education_spending(Y), Y \= X. 
		before_int_education_spending(X):- not not_before_int_education_spending(X).

	%after_int_education_spending: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
		
		not_after_int_education_spending(X):- f_domain(education_spending, Y), after_int_education_spending(Y), Y \= X. 
		after_int_education_spending(X):- not not_after_int_education_spending(X).








% FOLD SE Rules

	% republican
	% deemocrat
	

	% Human Intuitive FOLD-SE RULE
		
		
		%label(X,'democrat') :- not physician_fee_freeze(X,'y'), not ab1(X,'True').
		%label(X,'democrat') :- not budget_resolution(X,'n'), not anti_satellite_test_ban(X,'y'), mx_missile(X,'y').
		%ab1(X,'True') :- not budget_resolution(X,'y'), education_spending(X,'?').
		
	% SCASP Rules :
		% A = physician_fee_freeze
		% B = budget_resolution
		% C = anti_satellite_test_ban
		% D = mx_missile
		% E = education_spending


			%A gives 1, B gives 1, E gives 2 (yes and no), C and D give 2
		lite_democrat(A,B,C,D,E):- A\= yes, not lite_ab1(A,B,C,D,E).
			%bindings B gives 2 and E gives 3 so toal of 6
		lite_democrat(A,B,C,D,E):- B \= no, C \= yes, D = yes.
		lite_ab1(_,B,_,_,E):- B \= yes, E = missing. 

#show lite_democrat/5, not lite_democrat/5.
#show not lite_ab1/5.
democrat(A,B,C,D,E):- f_domain(physician_fee_freeze, A), f_domain(budget_resolution, B), f_domain(anti_satellite_test_ban, C)
					, f_domain(mx_missile, D), f_domain(education_spending, E)
		, before_int_physician_fee_freeze(A)
		, before_int_budget_resolution(B)
		, before_int_anti_satellite_test_ban(C)
		, before_int_mx_missile(D)
		, before_int_education_spending(E)
		, lite_democrat(A,B,C,D,E).

%#show before_int_budget_resolution/1.%, not before_int_budget_resolution/1.
%#show before_int_education_spending/1.%, not before_int_education_spending/1.
%?-democrat(A,B,C,D,E).



% Counterfactual cf_democrate
cf_democrat(A1,B1,C1,D1,E1):- f_domain(physician_fee_freeze, A1), f_domain(budget_resolution, B1), f_domain(anti_satellite_test_ban, C1)
					, f_domain(mx_missile, D1), f_domain(education_spending, E1)
		, after_int_physician_fee_freeze(A1)
		, after_int_budget_resolution(B1)
		, after_int_anti_satellite_test_ban(C1)
		, after_int_mx_missile(D1)
		, after_int_education_spending(E1)
		, not lite_democrat(A1,B1,C1,D1,E1).
%#show lite_ab1/5.
?-cf_democrat(A1,B1,C1,D1,E1).

%?-cf_democrat(yes,no,no,D1,E1).



% Measure
	f_domain(control,0).
	f_domain(control,1).



	% Used to measure the total cost of intervention: 0 for no intervention (impossible);
	% 1 for intervention on 1 feature, 5 for intervention on 5 features

		measure(Z1,Z2,Z3,Z4,Z5,X):- f_domain(control,Z1)
									, f_domain(control,Z2)
								   	, f_domain(control,Z3)
								   	, f_domain(control,Z4)
								   	, f_domain(control,Z5)
									, X #= Z1+Z2+Z3+Z4+Z5.



% Control Rules
		%Comments
			% 0: Features Remain Unchanged
			% 1: Features will be changed
			% Category: 1- New CF feauture WILL take a different value
		compare_C(X,X,0).
		compare_C(X,Y,1):- X\=Y.



% Craig Interpolant: Highlighting what all features 
	%Comment
		% need to be intervened on to resolve the inconsistency. 
		% pre-intervention world (prefix: before_int): Agrees with the decision '<=50K'
		% post-intervention world(prefix: after_int): Disagrees with the decision '<=50K'
		% The pre and post intervention world are inconsistent. 

	% Z1, Z2, Z3, Z4, Z5 are the control variables which may indicate the inconsistency
		% 1/-1: Feature is intervened on which may contribute to resolving inconsistency
		% 0: Feature is not intervened on
		% Note just because a Z1-Z5 may have 1  does not mean that feature is inconsistent. 
		% it merely indicates that the variable was intervened on to move into the post intervention world.

	craig(A,B,C,D,E,Z1,Z2,Z3,Z4,Z5,A1,B1,C1,D1,E1,X):-  f_domain(physician_fee_freeze, A), f_domain(budget_resolution, B), f_domain(anti_satellite_test_ban, C)
					, f_domain(mx_missile, D), f_domain(education_spending, E)
		, before_int_physician_fee_freeze(A)
		, before_int_budget_resolution(B)
		, before_int_anti_satellite_test_ban(C)
		, before_int_mx_missile(D)
		, before_int_education_spending(E)
		
					, f_domain(physician_fee_freeze, A1), f_domain(budget_resolution, B1), f_domain(anti_satellite_test_ban, C1)
					, f_domain(mx_missile, D1), f_domain(education_spending, E1)
		, after_int_physician_fee_freeze(A1)
		, after_int_budget_resolution(B1)
		, after_int_anti_satellite_test_ban(C1)
		, after_int_mx_missile(D1)
		, after_int_education_spending(E1)
		
		, compare_C(A,A1,Z1)
		, compare_C(B,B1,Z2)
		, compare_C(C,C1,Z3)
		, compare_C(D,D1,Z4)
		, compare_C(E,E1,Z5)
	
		, measure(Z1,Z2,Z3,Z4,Z5,X)
		, lite_democrat(A,B,C,D,E)
		, not lite_democrat(A1,B1,C1,D1,E1).

?-craig(A,B,C,D,E,Z1,Z2,Z3,Z4,Z5,A1,B1,C1,D1,E1,X).


%?-democrat(no,no,no,no,yes).