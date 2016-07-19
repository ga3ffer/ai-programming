%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A Prolog Expert System (APES)
% http://apes.sourceforge.net/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rules for use with engine from 
% Bratko, Prolog Progr. for AI, 2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define operators, making this an internal, Prolog-based domain-specific language (DSL)
:- op(100, xfx, [has, isa, does]).
:- op(900,fx,not).
:- op(900, xfx, ::).
:- op(800, xfx, was).
:- op(870, fx, if).
:- op(880, xfx, then).
:- op(550, xfy, or).
:- op(540, xfy, and).
:- op(300, fx, 'derived by').
:- op(600, xfx, from).
:- op(600, xfx, by).

askable(_ has _, 'Var_animal' has 'Something').
askable(_ does _, 'Var_animal' does 'Something').

% Note that this is only a small sample knowledge base, 
% the actualy KB is to be build by the user for the particular domain.

% each rule is represented by one predicate, using operators defined above:
rule0::if   Var_animal has 'a nervous system'
            or
            Var_animal has blood
        then
            Var_animal isa animal.
            
rule1::if   Var_animal isa animal and 
            Var_animal has hair
            or
            Var_animal does 'give milk'
        then
            Var_animal isa mammal.

rule2::if
            Var_animal isa animal and 
            Var_animal has feathers
            or
            Var_animal does fly and
            Var_animal does 'lay eggs'
        then
            Var_animal isa bird.
            
rule3::if
            Var_animal isa mammal and
            (Var_animal does 'eat meat'
                or
                Var_animal has 'pointed teeth' and
                Var_animal has claws and
                Var_animal has 'forward pointing eyes')
        then
            Var_animal isa carnivore.

rule4::if   
            Var_animal isa carnivore and
            Var_animal has 'tawny colour' and
            Var_animal has 'dark spots'
        then
            Var_animal isa cheetah.
            
rule5::if   
            Var_animal isa carnivore and
            Var_animal has 'tawny colour' and
            Var_animal has 'black stripes'
        then
            Var_animal isa tiger.
            
rule6::if
            Var_animal isa animal and
            Var_animal isa bird and
            Var_animal does 'not fly' and
            Var_animal does swim
        then
            Var_animal isa pinguin.
            
rule7::if
            Var_animal isa bird and
            Var_animal does 'fly good'
        then
            Var_animal isa albatross.

% new group added from shell: 
fact::X isa pet :-
pet(X).
% new rule added from shell:
rule::if
     Var_animal isa 'mammal' 
          and 
     Var_animal has 'two legs' 
then
     Var_animal isa 'humanoid' .
% new rule added from shell:
rule::if
     Var_animal isa 'humanoid' 
          and 
     Var_animal has 'language' 
then
     Var_animal isa 'human' .
% new rule added from shell:
rule::if
     Var_animal isa 'humanoid' 
          and 
     Var_animal has 'tools' 
then
     Var_animal isa 'erectus' .     
% new rule added from shell:
rule::if
     Var_animal has 'scales' 
          and 
     Var_animal has 'cold-blood' 
then
     Var_animal isa 'reptile' .
% new group added from shell: 
fact::X isa feline :-
feline(X).
% new rule added from shell:
rule::if
     Var_animal does 'swim' 
          and 
     Var_animal has 'fins' 
then
     Var_animal isa 'fish' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-oopu-nakea' 
          and 
     Var_animal has 'disc-shaped-sucker' 
          and 
     Var_animal does 'climb-waterfalls' 
then
     Var_animal isa 'goby' .
% new group added from shell: 
fact::X isa hawaiian-fish :-
hawaiian-fish(X).
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-oopu-alamoo' 
          and 
     Var_animal has 'disc-shaped-sucker' 
          and 
     Var_animal does 'climb-waterfalls' 
          and 
     Var_animal has 'salmon-like-lifestyle' 
then
     Var_animal isa 'freshwater-goby' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-oopu-nopili' 
          and 
     Var_animal has 'disc-shaped-sucker' 
          and 
     Var_animal does 'climb-waterfalls' 
          and 
     Var_animal has 'amphidromous-lifestyle' 
then
     Var_animal isa 'rockclimbing-goby' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-oopu-naniha' 
          and 
     Var_animal has 'disc-shaped-sucker' 
          and 
     Var_animal does 'not-climb-waterfalls' 
then
     Var_animal isa 'hawaiian-goby' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-oau' 
          and 
     Var_animal has 'disc-shaped-sucker' 
          and 
     Var_animal does 'not-climb-waterfalls' 
then
     Var_animal isa 'sleeper-goby' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'large-eyes' 
          and 
     Var_animal has 'straight-dorsal-head' 
          and 
     Var_animal has 'olive-bronze-color' 
then
     Var_animal isa 'strange-tail-flagtail' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'olive-green-color' 
          and 
     Var_animal has 'silvery-white-sides' 
          and 
     Var_animal has 'thin-lips' 
          and 
     Var_animal has 'lateral-horizonal-lines' 
then
     Var_animal isa 'mullet' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal does 'live-near-coral-reefs' 
          and 
     Var_animal has 'small-mouth' 
          and 
     Var_animal has 'black-head-and-tail' 
          and 
     Var_animal has 'silver-body' 
then
     Var_animal isa 'masked-angelfish' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-kaku' 
          and 
     Var_animal has 'long-body' 
          and 
     Var_animal has 'black-fin' 
          and 
     Var_animal has 'small-smooth-scales' 
then
     Var_animal isa 'blackfin-barracuda' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-aweoweo' 
          and 
     Var_animal has 'large-eye' 
          and 
     Var_animal has 'bright-red-color' 
then
     Var_animal isa 'hawaiian-bigeye' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-ulua' 
          and 
     Var_animal has 'thick-lips' 
          and 
     Var_animal has 'silver-body' 
          and 
     Var_animal does 'swim-fast' 
then
     Var_animal isa 'giant-trevally' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-aliaihi' 
          and 
     Var_animal has 'red-color-and-white-stripes' 
          and 
     Var_animal has 'sharp-gill-spines' 
          and 
     Var_animal has 'rough-scales' 
then
     Var_animal isa 'hawaiian-squirrelfish' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-hinalea-lauwili' 
          and 
     Var_animal has 'vibrant-blue-green-color' 
          and 
     Var_animal has 'brownish-orange-saddle-bar' 
then
     Var_animal isa 'saddle-wrasse' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'brown-color' 
          and 
     Var_animal has 'vivid-yellow-eye' 
          and 
     Var_animal has 'blue-to-yellow-horizontal-stripes' 
then
     Var_animal isa 'goldenring-surgeonfish' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal does 'inflate-twice-its-size' 
          and 
     Var_animal has 'poisonous-flesh' 
          and 
     Var_animal has 'reddish-brown-color' 
          and 
     Var_animal has 'white-spots' 
then
     Var_animal isa 'hawaiian-whitespotted-toby' .
% new rule added from shell:
rule::if
     Var_animal isa 'fish' 
          and 
     Var_animal has 'hawaiian-name-paoo' 
          and 
     Var_animal does 'live-in-tidepools' 
          and 
     Var_animal has 'smart-blue-color' 
          or 
     Var_animal has 'charcoal-color' 
          or 
     Var_animal has 'brownish-gray-color' 
          and 
     Var_animal has 'distinct-bars' 
then
     Var_animal isa 'hawaiian-zebra-blenny' .
