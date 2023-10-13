
%Cars

	
			
		% Safetyof the car

			f_domain(safety, low).
			f_domain(safety, med).
			f_domain(safety, high). 
			
			%f_domain(safety, not_low). 


		% Capacity of the car: persons
	
			f_domain(persons, 2).
			f_domain(persons, 4). 
			f_domain(persons, more). 
			
			%f_domain(persons, not_2). 



		% Maintence cost of cost: maint

			f_domain(maint, vhigh).
			f_domain(maint, high). 
			f_domain(maint, med).
			f_domain(maint, low). 
			
			%f_domain(maint, not_vhigh). 


		% Buying: buying

			f_domain(buying, vhigh).
			f_domain(buying, high). 
			f_domain(buying, med).
			f_domain(buying, low). 
			
			%f_domain(buying, not_vhigh) 
			  


% safety
		
		%#show before_int_safety/1, not before_int_safety/1.
		%#show before_int_safety/1.
		not_before_int_safety(X):- f_domain(safety, Y), before_int_safety(Y), Y \= X. 
		before_int_safety(X):- not not_before_int_safety(X).

		
		%#show after_int_safety/1, not after_int_safety/1.
		%#show after_int_safety/1.
		not_after_int_safety(X):- f_domain(safety, Y), after_int_safety(Y), Y \= X. 
		after_int_safety(X):- not not_after_int_safety(X).

% persons
		
		%#show before_int_persons/1, not before_int_persons/1.
		%#show before_int_persons/1.
		not_before_int_persons(X):- f_domain(persons, Y), before_int_persons(Y), Y \= X. 
		before_int_persons(X):- not not_before_int_persons(X).

		
		%#show after_int_persons/1, not after_int_persons/1.
		%#show after_int_persons/1.
		not_after_int_persons(X):- f_domain(persons, Y), after_int_persons(Y), Y \= X. 
		after_int_persons(X):- not not_after_int_persons(X).

% maint
		
		%#show before_int_maint/1, not before_int_maint/1.
		%#show before_int_maint/1.
		not_before_int_maint(X):- f_domain(maint, Y), before_int_maint(Y), Y \= X. 
		before_int_maint(X):- not not_before_int_maint(X).

		
		%#show after_int_maint/1, not after_int_maint/1.
		%#show after_int_maint/1.
		not_after_int_maint(X):- f_domain(maint, Y), after_int_maint(Y), Y \= X. 
		after_int_maint(X):- not not_after_int_maint(X).

% buying
		
		%#show before_int_buying/1, not before_int_buying/1.
		%#show before_int_buying/1.
		not_before_int_buying(X):- f_domain(buying, Y), before_int_buying(Y), Y \= X. 
		before_int_buying(X):- not not_before_int_buying(X).

		
		%#show after_int_buying/1, not after_int_buying/1.
		%#show after_int_buying/1.
		not_after_int_buying(X):- f_domain(buying, Y), after_int_buying(Y), Y \= X. 
		after_int_buying(X):- not not_after_int_buying(X).






% FOLD SE 

		


% Decision rule to claaify if a car is bought
#show lite_not_buy/4, not lite_not_buy/4.

lite_not_buy(A,_,_,_) :- A = low.
lite_not_buy(_,B,_,_) :- B = 2.
lite_not_buy(_,_,C,D) :- C = high, D = vhigh.
lite_not_buy(_,_,C,D) :- C = vhigh, D = high.
lite_not_buy(_,_,C,D) :- C = vhigh, D = vhigh.


not_buy(A,B,C,D):- f_domain(safety, A), f_domain(persons, B), f_domain(maint, C), f_domain(buying, D)
		, before_int_safety(A)
		, before_int_persons(B)
		, before_int_maint(C)
		, before_int_buying(D)
		, lite_not_buy(A,B,C,D).

		
%?-not_buy(A,B,C,D).



% Counterfactual rule to claaify if a person will buy
cf_not_buy(A1,B1,C1,D1):- f_domain(safety, A1), f_domain(persons, B1), f_domain(maint, C1), f_domain(buying, D1)
		, after_int_safety(A1)
		, after_int_persons(B1)
		, after_int_maint(C1)
		, after_int_buying(D1)
		, not lite_not_buy(A1,B1,C1,D1).

%?-cf_not_buy(A,B,C,D).

%?-not_buy(A,B,C,D).
%?-cf_not_buy(A,B,C,D).

% Measure
	f_domain(control,0).
	f_domain(control,1).



		measure(Z1,Z2,Z3,Z4,X):- f_domain(control,Z1)
									, f_domain(control,Z2)
								   	, f_domain(control,Z3)
								   	, f_domain(control,Z4)
									, X #= Z1+Z2+Z3+Z4.



% Control Rules
		%Comments
			% 0: Features Remain Unchanged
			% 1: Features will be changed
			% Category: 1- New CF feauture WILL take a different value
		compare_C(X,X,0).
		compare_C(X,Y,1):- X\=Y.



% Craig Interpolant: Highlighting what all features 
	
	craig(A,B,C,D,Z1,Z2,Z3,Z4,A1,B1,C1,D1,X):-  f_domain(safety, A), f_domain(persons, B), f_domain(maint, C), f_domain(buying, D)
		, before_int_safety(A)
		, before_int_persons(B)
		, before_int_maint(C)
		, before_int_buying(D)
		
		, f_domain(safety, A1), f_domain(persons, B1), f_domain(maint, C1), f_domain(buying, D1)
		, after_int_safety(A1)
		, after_int_persons(B1)
		, after_int_maint(C1)
		, after_int_buying(D1)
		
		, compare_C(A,A1,Z1)
		, compare_C(B,B1,Z2)
		, compare_C(C,C1,Z3)
		, compare_C(D,D1,Z4)
	
		, measure(Z1,Z2,Z3,Z4,X)
		, lite_not_buy(A,B,C,D)
		, not lite_not_buy(A1,B1,C1,D1).

?-craig(A,B,C,D,Z1,Z2,Z3,Z4,A1,B1,C1,D1,X).