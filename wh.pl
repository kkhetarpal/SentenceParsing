% ****************************************************************************************************************************************************
        %  s(Inv,PG,WH,Voice,Agr,Vform,Tree):
	% Inv - Inverted/Non-inverted sentence
	% PG - -passgap for active and +passgap for passive
	% WH - q for WH type, r for relative type
	% Voice - active or passive voice
	% Agr - Sentence agreement (Eg. 1s,1p,2p)
	% Vform - Vform of the verb (past,present,base)
	% Tree - Sentence parse tree (Eg. s(Agr,NP,VP))

	s --> s(_,_,_,_,_,_).
	s(-,PG,WH,Voice,Agr,Vform,s(Subcat,NP,VP)) -->	np(WH,Agr,NP),vp(PG,Voice,Agr,Vform,Subcat,VP),{member(Vform,[pres,past,base,inf,pastprt,ing])}.
	s(+,PG,WH,Voice,Agr,Vform,s(Subcat,Aux,NP,VP)) -->   aux(_,Agr,Compform,Vform,Aux),np(WH,Agr,NP),vp(PG,Voice,Agr,Compform,Subcat,VP),{member(Vform,[pres,past,base,inf,pastprt,ing])}.

	s(-,PG,WH,Voice,Agr,Vform,s(Subcat,NP,S)) --> np(WH,Agr,NP), s(+,PG,WH,Voice,_,Vform,S).
        s(-,PG,WH,Voice,Agr,Vform,s(Subcat,PP,S)) --> pp(WH,Pform,PP), s(+,PG,WH,Voice,_,Vform,S).  %prepositional sentence rule 13
        s(-,PG,WH,Voice,Agr,Vform,s(Subcat,PP,VP)) --> pp(WH,Pform,PP), vp(PG,Voice,Agr,Compform,Subcat,VP).


	% np(WH,Agr,Tree):

	% Agr - NP agreement (Eg. 1s,1p,2s)
	% Tree - NP parse tree (Eg. np(Agr,Art,N))
        % WH - q for WH type, r for relative type

	np(_,Agr,np(Agr,Art,N)) -->  art(Agr,Art),n(Agr,_,N).
	np(WH,Agr,np(Agr,Pro)) --> pro(Agr,WH,Poss,Pro).
	np(_,Agr,np(Agr,Proper)) --> proper(Agr,Proper).
        np(WH,Agr,np4(Agr,Qdet,N)) --> qdet(Agr,WH,Qdet),n(Agr,_,N).
        np(_,Agr,np10(Agr,Adj,N)) -->  adjp(_,Adj),n(Agr,_,N).

        np(WH,Agr,np22(Agr,Pro,N)) --> pro(Agr,WH,+,Pro),n(Agr,_,N). %only true for possesive pronouns


	n(Agr,Irreg_pl,n(N)) --> [N],{is_noun(N,Agr,Irreg_pl)}.
	n('3p',_,n(RootN+s)) -->
		[N],
		{name(N,Plname),append(Singname,"s",Plname),
		name(RootN,Singname),is_noun(RootN,'3s',-)}.


        %*************************************************************************************************************************************
        %WH words Lexicon
        qdet(Agr,WH,qdet(QDet)) --> [QDet],{is_qdet(QDet,WH,Agr)}.
        is_qdet(what,'q',Agr):-member(Agr,['3s','3p']).
        is_qdet(which,'q',Agr):-member(Agr,['3s','3p']).


        %Prepositional Phrases
        pp(WH,Pform,pp(PP,Pform)) --> [PP], {is_pp(PP,WH,Pform)}.
        is_pp(where,WH,Pform):-member(WH,['q','r']),member(Pform,['LOC','MOT']).
        is_pp(when,WH,'TIME'):-member(WH,['q','r']).

	%Pronouns
	pro(Agr,WH,Poss,pro(Pro)) --> [Pro],{is_pronoun(Pro,WH,Poss,Agr)}.
	is_pronoun(i,_,-,_).
	is_pronoun(he,_,-,'3s').
        is_pronoun(she,_,-,'3s').
	is_pronoun(me,_,-,_).
        is_pronoun(what,'q',-,Agr):-member(Agr,['3s','3p']).
        is_pronoun(who,WH,-,Agr):-member(WH,['q','r']),member(Agr,['3s','3p']).
        is_pronoun(which,'r',-,Agr):-member(Agr,['3s','3p']).
        is_pronoun(whose,WH,+,Agr):-member(WH,['q','r']),member(Agr,['3s','3p']).
        is_pronoun(this,_,-,'3s').
        is_pronoun(you,_,-,Agr):-member(Agr,['2s','2p']).

	%Proper nouns
	proper(Agr,proper(Proper)) --> [Proper],{is_proper(Proper,Agr)}.
	is_proper(jack,'3s').
	is_proper(jane,'3s').
        is_proper(kevin, '3s').
        is_proper(jacob,'3s').

	%Nouns
	%is_noun(saw,'3s',-).
	is_noun(seed,'3s',-).
	is_noun(pizza,'3s',-).
	is_noun(board,'3s',-).
	is_noun(half,'3s',+).
	is_noun(dog,'3s',-).
	is_noun(fish,Agr,+):-member(Agr,['3s','3p']).
	is_noun(man,'3s',-).
	is_noun(men,'3p',-).
	is_noun(song,'3s',-).
        is_noun(name,'3s',-).
        is_noun(game,'3s',-).
        is_noun(book,'3s',-).
        is_noun(movie,'3s',-).
	is_noun(date,'3s',-).
        is_noun(gator,'3s',-).

	% in(Agr,Vform,Tree)
	% Agr - Agreement of in (Eg. 1s,2s,3p).
	% Vform - Form of the verb(past,pres,base,inf).
	% Tree - Parse tree of in (Eg. in(IN))
	in(Agr,Vform,in(IN)) --> [in],{is_in(IN,Agr,Vform)}.
	is_in(in,_,_).

	%verbs
	is_verb(be,Subcat,base,_):-member(Subcat,['_adjp','_np','_vp:inf']).
	is_verb(cry,_,base,_).
        is_verb(put,_,base,_).
	is_verb(eat,_,base,_).
	is_verb(is,Subcat,Vform,'3s'):-	member(Subcat,['_adjp','_np','_vp:inf']),member(Vform,[pres,ing]).
        is_verb(are,Subcat,Vform,'3p'):-member(Subcat,['_adjp','_np','_vp:inf']),member(Vform,[pres,ing	]).
	is_verb(saw,'_np',base,_).
	is_verb(saw2,'_np',past,_).
	is_verb(see,_,base,_).
	is_verb(want,Subcat,base,_):-member(Subcat,['_np_vp:inf','_vp:inf','_np']).
	is_verb(was,_,pastprt,Agr):-member(Agr,['1s','3s']).
	is_verb(were,Subcat,past,Agr):-member(Subcat,['_adjp','_np']),member(Agr,['2s','1p','2p','3p']).
	is_verb(play,_,base,_).
        is_verb(sing,_,base,_).
        is_verb(read,_,base,_).


	% adjp(Subcat,Tree).
	% Subcat - Subcategory of the Adjp (Eg. '_vp:inf').
	% Tree - Parse Tree of the Adjp (Eg. adjp(Adj)).

	adjp(Subcat,adjp(Subcat,Adj)) --> adj(Subcat,Adj).
	adjp(Subcat,adjp(Subcat,Adj,VP)) --> adj('inf',Adj),vp(-passgap,_,_,inf,'inf',VP).
	adj(Subcat,adj(Adj)) --> [Adj],{is_adjective(Adj,Subcat)}.
	is_adjective(happy,'_vp:inf').
	is_adjective(half,'_vp:inf').
	is_adjective(broken,'_vp:inf').

	% art(Agr,Tree).
	% Agr - Agreement of the article (Eg. 1s,2s,3s).
	% Tree - Parse tree of the article (Eg. art(Art))

	art(Agr,art(Art)) --> [Art],{is_article(Art,Agr)}.
	is_article(a,'3s').
	is_article(the,Agr):-member(Agr,['3s','3p']).


	to(Agr,Vform,to(TO)) --> [to],{is_to(TO,Agr,Vform)}.
	is_to(to,_,_).


	%vp(PG,Voice,Agr,Vform,Subcat,Tree)
	%Vform - Vform of the verb(past,present,base).
	%Agr - VP agreement (Eg. 1s,2s,2p).
	%Tree - VP parse tree (Eg. vp(Agr,V).
	%PG - -passgap for active and +passgap for passive
	%Voice  active or passive voice
	%Subcat  Subcat of the verb (Eg. _np,_vp:inf)

	% Auxillary Verb Rules
	vp(-passgap,active,Agr,Vform,Subcat,vp1(Aux,VP)) -->	aux(_,Agr,Compform,Vform,Aux),vp(_,_,Agr,Compform,Subcat,VP).
	vp(-passgap,active,Agr,Vform,_,vp2(Aux,NP)) -->	aux(_,Agr,_,Vform,Aux),np(_,Agr,NP).

	% active verb rules
	vp(-passgap,active,Agr,Vform,_,vp3(V)) --> v('_none',Agr,Vform,V).

	vp(-passgap,active,Agr,Vform,_,vp4(V,NP)) -->	v('_np',Agr,Vform,V),np(_,Agr,NP).

	vp(-passgap,active,Agr,Vform,Subcat,vp5(V,VP)) -->	v('_vp:inf',Agr,Vform,V),vp(_,_,Agr,Vform,Subcat,VP).

	vp(-passgap,active,Agr,Vform,Subcat,vp6(V,VP)) -->	v('_vp:inf',Agr,Vform,V),vp(_,_,Agr,inf,Subcat,VP).

	vp(-passgap,active,Agr,Vform,Subcat,vp7(V,NP,VP)) -->	v(Subcat,Agr,Vform,V),np(_,Agr,NP),vp(_,_,Agr,Vform,Subcat,VP).

	vp(-passgap,active,Agr,Vform,Subcat,vp8(V,ADJP)) -->	v('_adjp',Agr,Vform,V),adjp(Subcat,ADJP).

	vp(-passgap,active,Agr,inf,'inf',vp9(TO,VP)) --> to(Agr,inf,TO),vp(_,_,Agr,base,_,VP).


	% passive verb rules
	vp(+passgap,passive,Agr,_,Subcat,vp10(Aux,VP)) -->	aux(_,Agr,pastprt,past,Aux),vp(_,_,Agr,pastprt,Subcat,VP).
	vp(+passgap,passive,Agr,_,Subcat,vp11(Aux,VP)) -->	aux(_,Agr,past,past,Aux),vp(_,_,Agr,past,Subcat,VP).
	vp(+passgap,passive,Agr,Vform,Subcat,vp12(Aux,VP)) -->	aux(_,Agr,_,Vform,Aux),vp(_,_,Agr,past,Subcat,VP).

	v(Subcat,Agr,Vform,v(V)) --> [V],{is_verb(V,Subcat,Vform,Agr)}.

	v(Subcat,'3s',pres,v(RootV+s)) -->
		[V],
		{name(V,TPV),append(Baseverb,"s",TPV),
		name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.
	v(Subcat,_,past,v(RootV+ed)) -->
		[V],
		{name(V,TPV),append(Baseverb,"ed",TPV),
		name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.
	v(Subcat,_,pastprt,v(RootV+ed)) -->
		[V],
		{name(V,TPV),append(Baseverb,"ed",TPV),
		name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.
	v(Subcat,_,pres,v(RootV+ed)) -->
		[V],
		{name(V,TPV),append(Baseverb,"ed",TPV),
		name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.
	v(Subcat,_,pastprt,v(RootV+en)) -->
		[V],
		{name(V,TPV),append(Baseverb,"en",TPV),
	name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.
	v(Subcat,_,_,v(RootV+ing)) -->
		[V],
		{name(V,TPV),append(Baseverb,"ing",TPV),
	name(RootV,Baseverb),is_verb(RootV,Subcat,base,_)}.

	%rule for auxiliary verbs
	aux(Modal,Agr,Compform,Vform,aux(Aux)) -->	[Aux],{is_aux(Aux,_,Modal,Vform,Agr,Compform)}.

	%lexicon for auxiliary verbs
	is_aux(can,_,+,pres,_,base).
	is_aux(do,_,+,pres,Agr,base):-member(Agr,['1s','2s','1p','2p','3p']).
	is_aux(be1,be,-,base,_,ing).
	is_aux(could,_,+,Vform,_,base):-member(Vform,[past,pres]).
	is_aux(have,have,+,_,_,pastprt).
	is_aux(has,has,+,Vform,_,base):-member(Vform,[pres,pastprt,past,ing]).
	is_aux(was,be,-,past,_,Compform):-member(Compform,[past,pastprt]).
        is_aux(did,do,+,past,_,base).





