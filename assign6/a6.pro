% -*- mode: Prolog;   -*-
% Kevin Barroga, 2014 11 24
% ICS 313, Assignment #6
% File: a6.pro

% information to create this knowledge-base was taken from:
% http://hbs.bishopmuseum.org/waipio/Critter%20pages/awaous.html
% http://en.wikipedia.org/wiki/List_of_fish_of_Hawaii

% This program classifies native Hawaiian fish species after asking the 
% user several yes/no questions. 

% Here is a modified Prolog version of the animal identification game (simple expert 
% system) presented in a Lisp program in Chapter 6 of Winston and Horn (1985).
% It was modified to identify Hawaiian fish species.

% To run the program, load the file and pose the query ?- go. 
% The program uses its identification rules to determine the animal 
% that you have chosen.

% Hawaiian fish identification rules
% To run, type      go.

go :- hypothesize(Fish), 
       write('I guess that the fish is a: '), 
       write(Fish), nl, undo.

 /* hypotheses to be tested */ 
hypothesize(goby) :- goby,  !. 
hypothesize(freshwater_goby) :- freshwater_goby, !.
hypothesize(rockclimbing_goby) :- rockclimbing_goby, !.
hypothesize(hawaiian_goby) :- hawaiian_goby, !.
hypothesize(sleeper_goby) :- sleeper_goby, !.
hypothesize(strange_tail_flagtail) :- strange_tail_flagtail, !.
hypothesize(mullet) :- mullet, !.
hypothesize(masked_angelfish) :- masked_angelfish, !.
hypothesize(blackfin_barracuda) :- blackfin_barracuda, !.
hypothesize(hawaiian_bigeye) :- hawaiian_bigeye, !.
hypothesize(giant_trevally) :- giant_trevally, !.
hypothesize(hawaiian_squirrelfish) :- hawaiian_squirrelfish, !.
hypothesize(unknown). /* no diagnosis */ 

/* Fish identification rules */ 
goby :- freshwater, brackish, saltwater,
    verify(has_hawaiian-name_oopu_nakea),
    verify(has_disc-shaped_sucker),
    verify(climb_waterfalls),
    verify(is_largest_native_Hawaiian_stream_fish).
freshwater_goby :- freshwater, brackish, saltwater,
    verify(has_hawaiian-name_oopu_alamoo),
    verify(has_disc-shaped_sucker),
    verify(climb_waterfalls),
    verify(has_salmon-like_lifestyle).          
rockclimbing_goby :- freshwater, brackish, saltwater,
    verify(has_hawaiian-name_oopu_nopili),
    verify(has_disc-shaped_sucker),
    verify(climb_waterfalls),
    verify(is_endemic_to_Hawaiian_islands),
    verify(is_amphidromous).
hawaiian_goby :- freshwater, brackish, saltwater,
    verify(has_hawaiian-name_oopu_naniha),
    verify(has_disc-shaped_sucker),
    verify(does_not_climb_waterfalls),
    verify(is_endemic_to_Hawaiian_islands).            
sleeper_goby :- freshwater, brackish, saltwater,
    verify(has_hawaiian-name_oau),
    verify(is_used_as_bait),
    verify(does_not_climb_waterfalls),
    verify(is_endemic_to_Hawaiian_islands).
strange_tail_flagtail :- freshwater, brackish, saltwater,
    verify(has_large_eye),
    verify(has_straight_dorsal_head),
    verify(has_olive-bronze_color_on_back),
    verify(is_endemic_to_Hawaiian_islands).
mullet :- freshwater,
    verify(has_olive-green_color_on_back), 
    verify(has_silvery_and_white_sides),
    verify(has_thin_lips),
    verify(has_distinct_lateral_horizontal_lines).
masked_angelfish :- saltwater,
    verify(found_near_coral_reefs),
    verify(has_small_mouth),
    verify(has_black_head_and_tail),
    verify(has_silver_body).
blackfin_barracuda :- saltwater,
    verify(has_hawaiian-name_kaku),
    verify(is_large_and_fearsome),
    verify(has_long_body),
    verify(has_black_fin),
    verify(has_small_smooth_scales).
hawaiian_bigeye :- saltwater,
    verify(has_hawaiian-name_aweoweo),
    verify(has_large_eye),
    verify(has_bright_red_color),
    verify(is_carnivorous),
    verify(is_nocturnal).
giant_trevally :- saltwater,
    verify(has_hawaiian-name_ulua),
    verify(has_thick_lips),
    verify(has_silver_body),
    verify(is_fast_swimming),
    verify(is_predatory).
hawaiian_squirrelfish :- saltwater,                         
    verify(has_hawaiian-name_aliaihi),
    verify(has_red_color_and_white_stripes),
    verify(has_sharp_gill_spines),
    verify(has_rough_scales),
    verify(is_nocturnal). 

/* fish classification rules */ 
freshwater :- verify(found_in_freshwater), !.
brackish :- verify(found_in_brackish), !.
saltwater :- verify(found_in_saltwater), !.

/* how to ask questions */ 
ask(Question) :- 
        write('Does the fish have the following attribute: '), 
        write(Question), write('? '), 
         read(Response), nl, 
         ( (Response == yes ; Response == y) 
         -> assert(yes(Question)) ; 
         assert(no(Question)), fail). 
:- dynamic yes/1,no/1. 
/* How to verify something */ 
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))). 
/* undo all yes/no assertions */ 
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail. 
undo. 