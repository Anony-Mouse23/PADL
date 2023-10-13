f_domain(marital_status, married_civ_spouse).
f_domain(marital_status, divorced).

f_domain(relationship, husband).
f_domain(relationship, wife). 
f_domain(relationship, unmarried).

f_domain(sex, male).
f_domain(sex, female).


% Pre-intervention world
not_before_int_marital_status(X) :- f_domain(marital_status, Y),
before_int_marital_status(Y), Y \= X.
before_int_marital_status(X):- not not_before_int_marital_status(X).

% Post-Intervention world
not_after_int_marital_status(X) :- f_domain(marital_status, Y),
after_int_marital_status(Y), Y \= X.
after_int_marital_status(X):- not not_after_int_marital_status(X).



% Pre-intervention world
not_before_int_relationship(X) :- f_domain(relationship, Y),
before_int_relationship(Y), Y \= X.
before_int_relationship(X):- not not_before_int_relationship(X).

% Post-Intervention world
not_after_int_relationship(X) :- f_domain(relationship, Y),
after_int_relationship(Y), Y \= X.
after_int_relationship(X):- not not_after_int_relationship(X).



% Pre-intervention world
not_before_int_sex(X) :- f_domain(sex, Y),
before_int_sex(Y), Y \= X.
before_int_sex(X):- not not_before_int_sex(X).

% Post-Intervention world
not_after_int_sex(X) :- f_domain(sex, Y),
after_int_sex(Y), Y \= X.
after_int_sex(X):- not not_after_int_sex(X).



% capital_gain
capital_gain(X):- X #>= 0, X #=< 99999.
% education_num
education_num(X):- X #>= 1, X #=< 16.
% age
age(X):- X #>= 17, X #=< 90.



% Decision rule to classify if a person makes ’<=50K/yr’
lite_le_50K(X,Y,_) :- X \= married_civ_spouse, Y #=< 6849.0.
lite_le_50K(X,Y,Z) :- X = married_civ_spouse, Y #=< 5013.0, Z #=< 12.0.

less_equal_50K(A,B,C):- f_domain(marital_status, A),before_int_marital_status(A), capital_gain(B),education_num(C), lite_le_50K(A,B,C).



?- less_equal_50K(A,B,C).


% Constraint rules identify causal relationships amongst features.
% They restrict the values taken for relationship(Y) and age(Z)
constraint_ms_reln_age(married_civ_spouse,Y,Z):- Y = husband.
constraint_ms_reln_age(married_civ_spouse,Y,Z):- Y = wife.
constraint_ms_reln_age(never_married,Y,Z):- Y \= husband, Y\= wife, Z #=<29.
% Add the rule to catch all other cases
constraint_ms_reln_age(X,Y,Z):- X\= married_civ_spouse, X\= never_married, Y \= husband, Y\= wife.






% Constraint rules that restrict age and sex for relationship
% Husbands cannot be Females above 27 years of age.
constraint_reln_sex_age(husband,Y,Z):- Y\= female, Z#>27.
% There is no rule for wife, so we put a rule to allow the same
constraint_reln_sex_age(wife,Y,Z):- Y= female.
% Add the rule to catch all other cases
constraint_reln_sex_age(X,Y,Z):- X \= husband, X \= wife.



% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
cf_less_equal_50K(A,B,C):- f_domain(marital_status, A),
after_int_marital_status(A), capital_gain(B),
education_num(C), not lite_le_50K(A,B,C).
%% QUERY
%# show lite_le_50K/3, not lite_le_50K/3.
?- cf_less_equal_50K(A,B,C).



% Control Features:
compare_C(X,X,0).
compare_C(X,Y,1):- X \= Y.

compare_N(X,X,0).
compare_N(X,Y,1):- X #< Y.
compare_N(X,Y,-1):- X #> Y.


% Measure
f_domain(control,0).
f_domain(control,1).
f_domain(control_N,0).
f_domain(control_N,1).
f_domain(control_N,-1).
measure(Z1,Z2,Z3,Z4,Z5,Z6,X):- f_domain(control,Z1), f_domain(control_N,Z2),f_domain(control_N,Z3), f_domain(control,Z4),f_domain(control,Z5),f_domain(control_N,Z6), Q2 #= Z2*Z2, Q3 #= Z3*Z3,Q6 #= Z6*Z6,X #= Z1+Q2+Q3+Z4+Z5+Q6.

% By default, all the proven goals will be shown. However for ease of understanding
% We show lite_le_50K/3, not lite_le_50K/3 to highlight the pre and post worlds
# show lite_le_50K/3, not lite_le_50K/3.
craig(A,B,C,D,E,F,Z1,Z2,Z3,Z4,Z5,Z6,A1,B1,C1,D1,E1,F1,X):-f_domain(marital_status, A),f_domain(relationship, D),f_domain(sex,E), before_int_marital_status(A),capital_gain(B), education_num(C),before_int_relationship(D), before_int_sex(E), age(F),constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F),f_domain(marital_status, A1),f_domain(relationship, D1),f_domain(sex,E1), after_int_marital_status(A1),capital_gain(B1), education_num(C1),after_int_relationship(D1), after_int_sex(E1), age(F1) ,constraint_ms_reln_age(A1,D1,F1),constraint_reln_sex_age(D1,E1,F1),compare_C(A,A1,Z1), compare_N(B,B1,Z2), compare_N(C,C1,Z3),compare_C(D,D1,Z4), compare_C(E,E1,Z5), compare_N(F,F1,Z6),measure(Z1,Z2,Z3,Z4,Z5,Z6,X),lite_le_50K(A,B,C), not lite_le_50K(A1,B1,C1).


?-craig(A, B, C, D, E, F, Z1,Z2, Z3, Z4, Z5, Z6, A1, B1, C1, D1, E1, F1, X).

?-craig(married_civ_spouse, 5000, 6, husband, male, 28, Z1,Z2, Z3, Z4, Z5, Z6, A1, B1, C1, D1, E1, F1, X).

?-craig(married_civ_spouse, 5000, 6, husband, male, F, 1,Z2, Z3, Z4, Z5, Z6, A1, B1, C1, D1, E1, F1, X).