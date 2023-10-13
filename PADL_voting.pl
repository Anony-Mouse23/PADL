
% physician_fee_freeze
	f_domain(physician_fee_freeze, no).
	f_domain(physician_fee_freeze, yes).



% physician_fee_freeze
		
		not_before_int_physician_fee_freeze(X):- f_domain(physician_fee_freeze, Y), before_int_physician_fee_freeze(Y), Y \= X. 
		before_int_physician_fee_freeze(X):- not not_before_int_physician_fee_freeze(X).

		
		not_after_int_physician_fee_freeze(X):- f_domain(physician_fee_freeze, Y), after_int_physician_fee_freeze(Y), Y \= X. 
		after_int_physician_fee_freeze(X):- not not_after_int_physician_fee_freeze(X).



% budget_resolution
	f_domain(budget_resolution, no).
	f_domain(budget_resolution, yes).



% budget_resolution
		
		not_before_int_budget_resolution(X):- f_domain(budget_resolution, Y), before_int_budget_resolution(Y), Y \= X. 
		before_int_budget_resolution(X):- not not_before_int_budget_resolution(X).

		
		not_after_int_budget_resolution(X):- f_domain(budget_resolution, Y), after_int_budget_resolution(Y), Y \= X. 
		after_int_budget_resolution(X):- not not_after_int_budget_resolution(X).


% anti_satellite_test_ban
	f_domain(anti_satellite_test_ban, no).
	f_domain(anti_satellite_test_ban, yes).



% anti_satellite_test_ban
		
		not_before_int_anti_satellite_test_ban(X):- f_domain(anti_satellite_test_ban, Y), before_int_anti_satellite_test_ban(Y), Y \= X. 
		before_int_anti_satellite_test_ban(X):- not not_before_int_anti_satellite_test_ban(X).

		
		not_after_int_anti_satellite_test_ban(X):- f_domain(anti_satellite_test_ban, Y), after_int_anti_satellite_test_ban(Y), Y \= X. 
		after_int_anti_satellite_test_ban(X):- not not_after_int_anti_satellite_test_ban(X).


% mx_missile
	f_domain(mx_missile, no).
	f_domain(mx_missile, yes).



% mx_missile
		
		not_before_int_mx_missile(X):- f_domain(mx_missile, Y), before_int_mx_missile(Y), Y \= X. 
		before_int_mx_missile(X):- not not_before_int_mx_missile(X).

		
		not_after_int_mx_missile(X):- f_domain(mx_missile, Y), after_int_mx_missile(Y), Y \= X. 
		after_int_mx_missile(X):- not not_after_int_mx_missile(X).



% education_spending
	f_domain(education_spending, no). % no
	f_domain(education_spending, yes).  % yes
	f_domain(education_spending, missing). %missing



% education_spending
		
		not_before_int_education_spending(X):- f_domain(education_spending, Y), before_int_education_spending(Y), Y \= X. 
		before_int_education_spending(X):- not not_before_int_education_spending(X).

		
		not_after_int_education_spending(X):- f_domain(education_spending, Y), after_int_education_spending(Y), Y \= X. 
		after_int_education_spending(X):- not not_after_int_education_spending(X).








% FOLD SE Rules

	

		lite_democrat(A,B,C,D,E):- A\= yes, not lite_ab1(A,B,C,D,E).
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
		
		compare_C(X,X,0).
		compare_C(X,Y,1):- X\=Y.



% Craig Interpolant: Highlighting what all features 
	
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