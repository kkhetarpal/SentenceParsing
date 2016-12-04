# SentenceParsing
1. Parse English WH type of sentences - implementation in Prolog.
-The wh-words like who, what, which, whose, can appear as pronouns. The words 'what', and 'which' have been categorised as determiners. ---Prepositional phrases have been seperately defined to include wh-words such as 'when' and 'where'. 


2. Translating corpus of English sentences into Predicate Calculus - implementation in Prolog
-The underlying concept I adopted to approach this problem is using the DCGs to compute more complex analyses of language.  
-The sentence can be broken down into noun_phrase and verb phrase. The noun phrase is further broken into determiner and noun. Verb phrase is further divided into verb and noun phrase
-The structural breakdown of a sentence is handled in the following order:
Step 1: Define rules for sentence, noun phrases, verb phrases, which form the integral part of the
grammar.
Step 2: Define rules for determiners such as for all(∀x), there exists(]) to implement the predicate
calculus definitions.
Step 3: Construct a well defined lexicon comprising of nouns, transitive and intransitive verbs, proper
nouns, verbs, relative clauses, determiners. 


References:
1. Clocksin & Mellish, Programming in Prolog, S-V, 5th ed.
2. Russell & Norvig, Artificial Intelligence: A Modern Approach, Prentice-Hall, 3rd Ed. 2009.
