?- op(500,xfy,&).
?- op(600,xfy,->).
% ************************************************************************
% Usage:: sentence(Predicate_Calculus,[comma seperated sentence],[]).


   %Sentence --> NP, VP.
   sentence(P) --> noun_phrase(Z,P1,P), verb_phrase(Z,P1).

   %Noun Phrase --> determiner,noun,relative_clause.
   %Noun Phrase --> determiner,noun.
   %Noun Phrase --> proper_noun.
   noun_phrase(Z,P1,P) --> determiner(Z,P2,P1,P), noun(Z,P3), relative_clause(Z,P3,P2).
   noun_phrase(Z,P1,P) --> determiner(Z,P2,P1,P), noun(Z,P2).
   noun_phrase(Z,P,P) --> proper_noun(Z).

   %Verb Phrase --> transitive verb, NP.
   %Verb Phrase --> intransitive verb.
   verb_phrase(Z,P) --> trans_verb(Z,Y,P1), noun_phrase(Y,P1,P).
   verb_phrase(Z,P) --> in_trans_verb(Z,P).

   %Relative Clause --> [clause], VP.
   relative_clause(Z,P1,(P1 & P2)) --> [that], verb_phrase(Z,P2).
   relative_clause(Z,P1,(P1 & P2)) --> [which], verb_phrase(Z,P2).
   relative_clause(Z,P1,(P1 & P2)) --> [who], verb_phrase(Z,P2).
   relative_clause(Z,P1,(P1 & P2)) --> [whose], verb_phrase(Z,P2).
   relative_clause(_,P,P) --> [].

   % Lexicon %
%****************************************************************************
    %Nouns
    noun(Z,apple(Z)) --> [apple].
    noun(Z,apples(Z)) --> [apples].
    noun(Z,boy(Z)) --> [boy].
    noun(Z,boys(Z)) --> [boys].
    noun(Z,boy(Z)) --> [boy].
    noun(Z,boys(Z)) --> [boys].
    noun(Z,man(Z)) --> [man].
    noun(Z,woman(Z)) --> [woman].
    noun(Z,ibuprofen(Z)) --> [ibuprofen].
    noun(Z,dolphins(Z)) --> [dolphins].
    noun(Z,dolphin(Z)) --> [dolphin].
    noun(Z,book(Z)) --> [book].
    noun(Z,artist(Z)) --> [artist].

    %Proper Nouns
    proper_noun(bob) --> [bob].
    proper_noun(david) --> [david].
    proper_noun(annie) --> [annie].
    proper_noun(john) --> [john].
    proper_noun(mary) --> [mary].

    %Determiner
    determiner(Z,S1,S2, for_all(Z,(S1 -> S2))) --> [every].
    determiner(Z,S1,S2, there_exists(Z, (S1 & S2))) --> [a].
    determiner(Z,S1,S2, there_exists(Z, (S1 & S2))) --> [the].
    determiner(Z,S1,S2, there_exists(Z, (S1 & S2))) --> [an].

    %Transitive Verbs
    trans_verb(X,Y,loves(X,Y)) --> [loves].
    trans_verb(X,Y,takes(X,Y)) --> [takes].
    trans_verb(X,Y,likes(X,Y)) --> [likes].
    trans_verb(X,Y,hates(X,Y)) --> [hates].
    trans_verb(X,Y,eats(X,Y)) --> [eats].
    trans_verb(X,Y,are(X,Y)) --> [are].
    trans_verb(X,Y,is(X,Y)) --> [is].
    trans_verb(X,Y,painted(X,Y)) --> [painted].
    trans_verb(X,Y,can(X,Y)) --> [can].
    trans_verb(X,Y,read(X,Y)) --> [read].

    %Intransitive Verbs
    in_trans_verb(X,lives(X)) --> [lives].
    in_trans_verb(X,runs(X)) --> [runs].
    in_trans_verb(X,sings(X)) --> [sings].
    in_trans_verb(X,reads(X)) --> [reads].
    in_trans_verb(X,swims(X)) --> [swims].
    in_trans_verb(X,paints(X)) --> [paints].
    in_trans_verb(X,dives(X)) --> [dives].







