%Dropout

	%f_domain ie. determines the domain for every feature

	
		
		% tuition_fees_up_to_date: 2 (Binary)
			f_domain(tuition_fees_up_to_date, 0). 
			f_domain(tuition_fees_up_to_date, 1). 

			%f_domain(tuition_fees_up_to_date, not_0). 
			


		% curricular_units_2nd_sem_approved: Only use 2 for ease of debugging
			f_domain(curricular_units_2nd_sem_approved, 6).
			f_domain(curricular_units_2nd_sem_approved, 7). 
			

			%f_domain(curricular_units_2nd_sem_approved, 8).
			%f_domain(curricular_units_2nd_sem_approved, 9). 

			%f_domain(curricular_units_2nd_sem_approved, not_6).
			%f_domain(curricular_units_2nd_sem_approved, 0).
			%f_domain(curricular_units_2nd_sem_approved, 1). 
			%f_domain(curricular_units_2nd_sem_approved, 2). 
			%f_domain(curricular_units_2nd_sem_approved, 3). 
			%f_domain(curricular_units_2nd_sem_approved, 4). 
			%f_domain(curricular_units_2nd_sem_approved, 5).
			%f_domain(curricular_units_2nd_sem_approved, 10). 
			%f_domain(curricular_units_2nd_sem_approved, 11).

			%f_domain(curricular_units_2nd_sem_approved, 12). 
			%f_domain(curricular_units_2nd_sem_approved, 13). 
			%f_domain(curricular_units_2nd_sem_approved, 14).

			%f_domain(curricular_units_2nd_sem_approved, 15). 
			%f_domain(curricular_units_2nd_sem_approved, 16). 
			%f_domain(curricular_units_2nd_sem_approved, 17).

			%f_domain(curricular_units_2nd_sem_approved, 18). 
			%f_domain(curricular_units_2nd_sem_approved, 19). 
			%f_domain(curricular_units_2nd_sem_approved, 20).


		% course: Only use 2 for ease of debugging
			f_domain(course, 171). 
			f_domain(course, 33). 
			%f_domain(course, 8014).
			%f_domain(course, 9003). 
			%f_domain(course, not_171).
			


			%f_domain(course, 9070). 
			%f_domain(course, 9085).
			%f_domain(course, 9119). 
			%f_domain(course, 9130). 
			%f_domain(course, 9147).
			%f_domain(course, 9238). 
			%f_domain(course, 9254). 
			%f_domain(course, 9500).
			%f_domain(course, 9556). 
			%f_domain(course, 9670). 
			%f_domain(course, 9773).
			%f_domain(course, 9853). 
			%f_domain(course, 9991). 


		% application_order: Only use 2 for ease of debugging
			f_domain(application_order, 3). 
			f_domain(application_order, 5). 
			f_domain(application_order, 2).
			f_domain(application_order, 9). 
			%f_domain(application_order, not_3). 


			%f_domain(application_order, 0).
			%f_domain(application_order, 1). 
			%f_domain(application_order, 4). 
			%f_domain(application_order, 5).
			%f_domain(application_order, 6). 
			


% tuition_fees_up_to_date
	%before_int_tuition_fees_up_to_date: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		%#show before_int_tuition_fees_up_to_date/1, not before_int_tuition_fees_up_to_date/1.
		%#show before_int_tuition_fees_up_to_date/1.
		not_before_int_tuition_fees_up_to_date(X):- f_domain(tuition_fees_up_to_date, Y), before_int_tuition_fees_up_to_date(Y), Y \= X. 
		before_int_tuition_fees_up_to_date(X):- not not_before_int_tuition_fees_up_to_date(X).

	%after_int_tuition_fees_up_to_date: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
	%what we want is to create a before intervention world and an after intervention world
		
		%#show after_int_tuition_fees_up_to_date/1, not after_int_tuition_fees_up_to_date/1.
		%#show after_int_tuition_fees_up_to_date/1.
		not_after_int_tuition_fees_up_to_date(X):- f_domain(tuition_fees_up_to_date, Y), after_int_tuition_fees_up_to_date(Y), Y \= X. 
		after_int_tuition_fees_up_to_date(X):- not not_after_int_tuition_fees_up_to_date(X).

% curricular_units_2nd_sem_approved
	%before_int_curricular_units_2nd_sem_approved: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		%#show before_int_curricular_units_2nd_sem_approved/1, not before_int_curricular_units_2nd_sem_approved/1.
		%#show before_int_curricular_units_2nd_sem_approved/1.
		not_before_int_curricular_units_2nd_sem_approved(X):- f_domain(curricular_units_2nd_sem_approved, Y), before_int_curricular_units_2nd_sem_approved(Y), Y \= X. 
		before_int_curricular_units_2nd_sem_approved(X):- not not_before_int_curricular_units_2nd_sem_approved(X).

	%after_int_curricular_units_2nd_sem_approved: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
	%what we want is to create a before intervention world and an after intervention world
		
		%#show after_int_curricular_units_2nd_sem_approved/1, not after_int_curricular_units_2nd_sem_approved/1.
		%#show after_int_curricular_units_2nd_sem_approved/1.
		not_after_int_curricular_units_2nd_sem_approved(X):- f_domain(curricular_units_2nd_sem_approved, Y), after_int_curricular_units_2nd_sem_approved(Y), Y \= X. 
		after_int_curricular_units_2nd_sem_approved(X):- not not_after_int_curricular_units_2nd_sem_approved(X).

% course
	%before_int_course: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		%#show before_int_course/1, not before_int_course/1.
		%#show before_int_course/1.
		not_before_int_course(X):- f_domain(course, Y), before_int_course(Y), Y \= X. 
		before_int_course(X):- not not_before_int_course(X).

	%after_int_course: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
	%what we want is to create a before intervention world and an after intervention world
		
		%#show after_int_course/1, not after_int_course/1.
		%#show after_int_course/1.
		not_after_int_course(X):- f_domain(course, Y), after_int_course(Y), Y \= X. 
		after_int_course(X):- not not_after_int_course(X).

% application_order
	%before_int_application_order: Extended with NAF, where at a given time, the marital status can only have 1 UNIQUE value 
	%ie. If I am divorced, I cannot be married as well.
		
		%#show before_int_application_order/1, not before_int_application_order/1.
		%#show before_int_application_order/1.
		not_before_int_application_order(X):- f_domain(application_order, Y), before_int_application_order(Y), Y \= X. 
		before_int_application_order(X):- not not_before_int_application_order(X).

	%after_int_application_order: 
	%After intervention, marital status can 1) Stay the same as before OR 2) Be different
	%what we want is to create a before intervention world and an after intervention world
		
		%#show after_int_application_order/1, not after_int_application_order/1.
		%#show after_int_application_order/1.
		not_after_int_application_order(X):- f_domain(application_order, Y), after_int_application_order(Y), Y \= X. 
		after_int_application_order(X):- not not_after_int_application_order(X).


% curricular_units_2nd_sem_grade
	%#show curricular_units_2nd_sem_grade/1, not curricular_units_2nd_sem_grade/1.
	curricular_units_2nd_sem_grade(X):- X #>= 0, X#=<18.5714285714286.


% admission_grade
	%#show admission_grade/1, not admission_grade/1.
	admission_grade(X):- X #>= 95, X#=< 190.






% SOPAM
% Removing NAF 
%#show lite_dropout/6, not lite_dropout/6.
lite_dropout(A,B,C,D,E,F) :- E #=<10.333, not lite_ab1(A,B,C,D,E,F).
lite_dropout(A,B,_,_,_,_) :- A = 0, B\=6.
#show lite_ab1/6, not lite_ab1/6.
lite_ab1(A,_,C,D,_,F):- C = 171, A\=0, D\=3, F#>136.0.



dropout(A,B,C,D,E,F):- f_domain(tuition_fees_up_to_date, A)
					, f_domain(curricular_units_2nd_sem_approved, B)
					, f_domain(course, C)
					, f_domain(application_order, D)
					, before_int_tuition_fees_up_to_date(A)
					, before_int_curricular_units_2nd_sem_approved(B)
					, before_int_course(C)
					, before_int_application_order(D)
					, curricular_units_2nd_sem_grade(E)
					, admission_grade(F)
					, lite_dropout(A,B,C,D,E,F).

%?- dropout(A,B,C,D,E,F).



% Counterfactual rule 

cf_dropout(A1,B1,C1,D1,E1,F1):- f_domain(tuition_fees_up_to_date, A1)
					, f_domain(curricular_units_2nd_sem_approved, B1)
					, f_domain(course, C1)
					, f_domain(application_order, D1)
					, after_int_tuition_fees_up_to_date(A1)
					, after_int_curricular_units_2nd_sem_approved(B1)
					, after_int_course(C1)
					, after_int_application_order(D1)
					, curricular_units_2nd_sem_grade(E1)
					, admission_grade(F1)
					, not lite_dropout(A1,B1,C1,D1,E1,F1).


%?- cf_dropout(A,B,C,D,E,F).




% Measure
	f_domain(control,0).
	f_domain(control,1).

	f_domain(control_N,0).
	f_domain(control_N,1).
	f_domain(control_N,-1).


	% Used to measure the total cost of intervention: 0 for no intervention (impossible);
	% 1 for intervention on 1 feature, 6 for intervention on 6 features
		measure(Z1,Z2,Z3,Z4,Z5,Z6,X):- f_domain(control,Z1)
									, f_domain(control,Z2)
									, f_domain(control,Z3)
									, f_domain(control,Z4)
								   	, f_domain(control_N,Z5)
								   	, f_domain(control_N,Z6)

									, Q5 #= Z5*Z5
									, Q6 #= Z6*Z6
									, X #= Z1+Z2+Z3+Z4+Q5+Q6.



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




craig(A,B,C,D,E,F,Z1,Z2,Z3,Z4,Z5,Z6,A1,B1,C1,D1,E1,F1,X):-  f_domain(tuition_fees_up_to_date, A)
					, f_domain(curricular_units_2nd_sem_approved, B)
					, f_domain(course, C)
					, f_domain(application_order, D)
					, before_int_tuition_fees_up_to_date(A)
					, before_int_curricular_units_2nd_sem_approved(B)
					, before_int_course(C)
					, before_int_application_order(D)
					, curricular_units_2nd_sem_grade(E)
					, admission_grade(F)

					, f_domain(tuition_fees_up_to_date, A1)
					, f_domain(curricular_units_2nd_sem_approved, B1)
					, f_domain(course, C1)
					, f_domain(application_order, D1)
					, after_int_tuition_fees_up_to_date(A1)
					, after_int_curricular_units_2nd_sem_approved(B1)
					, after_int_course(C1)
					, after_int_application_order(D1)
					, curricular_units_2nd_sem_grade(E1)
					, admission_grade(F1)

		, compare_C(A,A1,Z1)
		, compare_C(B,B1,Z2)
		, compare_C(C,C1,Z3)
		, compare_C(D,D1,Z4)
		, compare_N(E,E1,Z5)
		, compare_N(F,F1,Z6)

		, measure(Z1,Z2,Z3,Z4,Z5,Z6,X)
		, lite_dropout(A,B,C,D,E,F)
		, not lite_dropout(A1,B1,C1,D1,E1,F1).



?-craig(A,B,C,D,E,F,Z1,Z2,Z3,Z4,0,0,A1,B1,C1,D1,E1,F1,X).