%odor

	% Domain % almond=a,anise=l,creosote=c,fishy=y,foul=f, musty=m,none=n,pungent=p,spicy=s

		f_domain(odor, f).
		f_domain(odor, p).
		f_domain(odor, c).

		f_domain(odor, a).
		f_domain(odor, l).
		


		%f_domain(odor, y).
		
		%f_domain(odor, m). 
		%f_domain(odor, n).
		%f_domain(odor, s). 


 	% Objects
	

		%before_int_odor: 
		
		not_before_int_odor(X):- f_domain(odor, Y), before_int_odor(Y), Y \= X. 
		before_int_odor(X):- not not_before_int_odor(X).

		%after_int_odor: 
	
		not_after_int_odor(X):- f_domain(odor, Y), after_int_odor(Y), Y \= X. 
		after_int_odor(X):- not not_after_int_odor(X).
			%f_domain(buying, not_vhigh) 
			  

%gill_size

	% Domain % broad=b,narrow=n

		f_domain(gill_size, b).
		f_domain(gill_size, n).
		



 	% Objects
	

		%before_int_gill_size:  
		
		not_before_int_gill_size(X):- f_domain(gill_size, Y), before_int_gill_size(Y), Y \= X. 
		before_int_gill_size(X):- not not_before_int_gill_size(X).

		%after_int_gill_size: 
	
		not_after_int_gill_size(X):- f_domain(gill_size, Y), after_int_gill_size(Y), Y \= X. 
		after_int_gill_size(X):- not not_after_int_gill_size(X).


%spore_print_color

	% Domain % black=k,brown=n,buff=b,chocolate=h,green=r, orange=o,purple=u,white=w,yellow=y

		f_domain(spore_print_color, r).
		f_domain(spore_print_color, w).

		%f_domain(spore_print_color, k).
		%f_domain(spore_print_color, n).
		%f_domain(spore_print_color, b). 


		%f_domain(spore_print_color, h).
		%f_domain(spore_print_color, o). 
		%f_domain(spore_print_color, u).
		%f_domain(spore_print_color, y). 
			



 	% Objects
	

		%before_int_spore_print_color:  
		
		not_before_int_spore_print_color(X):- f_domain(spore_print_color, Y), before_int_spore_print_color(Y), Y \= X. 
		before_int_spore_print_color(X):- not not_before_int_spore_print_color(X).

		%after_int_spore_print_color: 
	
		not_after_int_spore_print_color(X):- f_domain(spore_print_color, Y), after_int_spore_print_color(Y), Y \= X. 
		after_int_spore_print_color(X):- not not_after_int_spore_print_color(X).


%gill_spacing 

	% Domain % close=c,crowded=w,distant=d

		f_domain(gill_spacing, c).
		f_domain(gill_spacing, w).
		%f_domain(gill_spacing, d). 
			



 	% Objects
	

		%before_int_gill_spacing:  
		
		not_before_int_gill_spacing(X):- f_domain(gill_spacing, Y), before_int_gill_spacing(Y), Y \= X. 
		before_int_gill_spacing(X):- not not_before_int_gill_spacing(X).

		%after_int_gill_spacing: 
	
		not_after_int_gill_spacing(X):- f_domain(gill_spacing, Y), after_int_gill_spacing(Y), Y \= X. 
		after_int_gill_spacing(X):- not not_after_int_gill_spacing(X).


%gill_color 


	% Domain % black=k,brown=n,buff=b,chocolate=h,gray=g, green=r,orange=o,pink=p,purple=u,red=e, white=w,yellow=y

		f_domain(gill_color, b). 


		f_domain(gill_color, k).
		%f_domain(gill_color, n).
		%f_domain(gill_color, h).
		%f_domain(gill_color, g).
		
		%f_domain(gill_color, r). 
		%f_domain(gill_color, o).
		%f_domain(gill_color, p).
		
		%f_domain(gill_color, u). 
		%f_domain(gill_color, e).
		%f_domain(gill_color, w).
		%f_domain(gill_color, y). 
			
			



 	% Objects
	

		%before_int_gill_color:  
		
		not_before_int_gill_color(X):- f_domain(gill_color, Y), before_int_gill_color(Y), Y \= X. 
		before_int_gill_color(X):- not not_before_int_gill_color(X).

		%after_int_gill_color: 
	
		not_after_int_gill_color(X):- f_domain(gill_color, Y), after_int_gill_color(Y), Y \= X. 
		after_int_gill_color(X):- not not_after_int_gill_color(X).


% FOLD SE Decision to check if one makes =<$50K ie. working class
	% poisonous
	% edible
	

	% Human Intuitive FOLD-SE RULE
		
		%label(X,'p') :- odor(X,'f').
		%label(X,'p') :- not gill_size(X,'b'), not ab2(X,'True').
		%label(X,'p') :- spore_print_color(X,'r').
		%ab1(X,'True') :- spore_print_color(X,'w'), gill_spacing(X,'c').
		%ab2(X,'True') :- not gill_color(X,'b'), not odor(X,'p'), not odor(X,'c'), not ab1(X,'True').
		
	% SCASP Rules :5 features 
	% Decision rule to claaify 

		lite_poisonous(A,_,_,_,_):- A = f.
		lite_poisonous(A,B,C,D,E):- B \= b, not lite_ab2(A,B,C,D,E).
		lite_poisonous(_,_,C,_,_):- C = r.

		# show lite_ab1/5.
		# show not lite_ab1/5.
		lite_ab1(_,_,C,D,_):- C = w, D = c.
		# show lite_ab2/5.
		# show not lite_ab2/5.
		lite_ab2(A,B,C,D,E):- E\=b, A\=p, A \=c, not lite_ab1(A,B,C,D,E).


		poisonous(A,B,C,D,E):- f_domain(odor,A)
							, f_domain(gill_size,B)
							, f_domain(spore_print_color,C)
							, f_domain(gill_spacing, D)
							, f_domain(gill_color,E)
					
						, before_int_odor(A)
						, before_int_gill_size(B)
						, before_int_spore_print_color(C)
						, before_int_gill_spacing(D)
						, before_int_gill_color(E)
					
					, lite_poisonous(A,B,C,D,E).

%?-poisonous(A,B,C,D,E).
%?- lite_ab2(A,B,C,D,E).		

?-poisonous(A,B,C,D,E).



% Counterfactual

		cf_poisonous(A1,B1,C1,D1,E1):- f_domain(odor,A1)
							, f_domain(gill_size,B1)
							, f_domain(spore_print_color,C1)
							, f_domain(gill_spacing, D1)
							, f_domain(gill_color,E1)
					
						, after_int_odor(A1)
						, after_int_gill_size(B1)
						, after_int_spore_print_color(C1)
						, after_int_gill_spacing(D1)
						, after_int_gill_color(E1)
					
					, not lite_poisonous(A1,B1,C1,D1,E1).

?- cf_poisonous(A1,B1,C1,D1,E1).



% Measure
	f_domain(control,0).
	f_domain(control,1).



	% Used to measure the total cost of intervention: 0 for no intervention (impossible);
	% 1 for intervention on 1 feature, 6 for intervention on 6 features
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


% Craig



	craig(A,B,C,D,E,Z1,Z2,Z3,Z4,Z5,A1,B1,C1,D1,E1,X):-  f_domain(odor,A)
							, f_domain(gill_size,B)
							, f_domain(spore_print_color,C)
							, f_domain(gill_spacing, D)
							, f_domain(gill_color,E)
					
						, before_int_odor(A)
						, before_int_gill_size(B)
						, before_int_spore_print_color(C)
						, before_int_gill_spacing(D)
						, before_int_gill_color(E)
					
					


							, f_domain(odor,A1)
							, f_domain(gill_size,B1)
							, f_domain(spore_print_color,C1)
							, f_domain(gill_spacing, D1)
							, f_domain(gill_color,E1)
					
						, after_int_odor(A1)
						, after_int_gill_size(B1)
						, after_int_spore_print_color(C1)
						, after_int_gill_spacing(D1)
						, after_int_gill_color(E1)


					, compare_C(A,A1,Z1)
					, compare_C(B,B1,Z2)
					, compare_C(C,C1,Z3)
					, compare_C(D,D1,Z4)
					, compare_C(E,E1,Z5)
	
					, measure(Z1,Z2,Z3,Z4,Z5,X)


					, lite_poisonous(A,B,C,D,E)			
					, not lite_poisonous(A1,B1,C1,D1,E1).

?-craig(A,B,C,D,E,Z1,Z2,Z3,Z4,Z5,A1,B1,C1,D1,E1,X).


%?-craig(A,B,C,D,E,Z1,Z2,Z3,Z4,Z5,A1,B1,C1,D1,E1,1).