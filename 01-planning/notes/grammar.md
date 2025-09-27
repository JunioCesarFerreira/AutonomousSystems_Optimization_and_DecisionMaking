# Gramática do PDDL
*Precisa ser revisado*

A seguir apresentamos uma gramática **EBNF compacta** do PDDL, organizada por versões: **núcleo (PDDL 1.x/“clássico”)**, extensões **PDDL 2.1** (numérico/temporal), **PDDL 2.2** (predicados derivados e *timed initial literals*) e **PDDL 3.0** (restrições de trajetória e preferências). Uso EBNF “legível” e termos próximos ao que você vê nos arquivos `.pddl`.

> Convenções rápidas:
> `[...]` = opcional; `{x}` = zero ou mais; `x | y` = escolha; `⟨T⟩` = não-terminal; `'?x'` = variável.
> `TypedList[X] ::= X* | X+ '-' ⟨type⟩ TypedList[X]` (listas com tipos).

---

# Núcleo (PDDL 1.x — STRIPS/ADL)

```ebnf
domain-file   ::= "(define (domain" name ")" 
                   [require-def] [types-def] [constants-def]
                   [predicates-def] [functions-def] {structure-def} ")"

require-def   ::= "(:requirements" {require-key}+ ")"
require-key   ::= :strips | :typing | :equality 
                 | :negative-preconditions | :disjunctive-preconditions
                 | :existential-preconditions | :universal-preconditions
                 | :quantified-preconditions | :conditional-effects
                 | :adl | :fluents

types-def     ::= "(:types" TypedList[name] ")"
constants-def ::= "(:constants" TypedList[name] ")"
predicates-def::= "(:predicates" {atomic-formula-skel}+ ")"
atomic-formula-skel ::= "(" predicate TypedList[variable] ")"
predicate     ::= name
variable      ::= "?" name

functions-def ::= "(:functions" FunctionTypedList[atomic-fn-skel] ")"
atomic-fn-skel::= "(" function-symbol TypedList[variable] ")"
function-symbol ::= name
FunctionTypedList[X] ::= X* | X+ "-" function-type FunctionTypedList[X]
function-type  ::= number

structure-def ::= action-def | derived-def  (* derived-def só se habilitado por versões mais novas *)

action-def    ::= "(:action" action-symbol
                   ":parameters (" TypedList[variable] ")"
                   [":precondition" GD]
                   [":effect" effect] ")"
action-symbol ::= name

GD            ::= "()" 
                | atomic-formula-term
                | ( "and" {GD} )
                | ( "or"  {GD} )                           ; :disjunctive-preconditions
                | ( "not" GD )                             ; :negative-preconditions
                | ( "imply" GD GD )                        ; ADL
                | ( "exists" "(" TypedList[variable] ")" GD )   ; :existential-preconditions
                | ( "forall" "(" TypedList[variable] ")" GD )   ; :universal-preconditions
                | f-comp                                   ; se :fluents

atomic-formula-term ::= "(" predicate {term} ")"
literal-term   ::= atomic-formula-term | "(not" atomic-formula-term ")"
term           ::= name | variable

effect         ::= "(and" {c-effect} ")"
c-effect       ::= literal-term
                 | "(when" GD effect ")"                  ; :conditional-effects
                 | "(forall (" TypedList[variable] ") " effect ")" 

(* Numérico básico; cheio em 2.1 *)
f-comp         ::= "(" binary-comp f-exp f-exp ")"
binary-comp    ::= ">" | "<" | "=" | ">=" | "<="
f-exp          ::= number 
                 | "(" binary-op f-exp f-exp ")"
                 | "(" "-" f-exp ")" 
                 | f-head
f-head         ::= "(" function-symbol {term} ")" | function-symbol
binary-op      ::= "+" | "-" | "*" | "/"

problem-file   ::= "(define (problem" name ")"
                   "(:domain" name ")"
                   [require-def]
                   [objects-def] init goal [metric-spec] ")"

objects-def    ::= "(:objects" TypedList[name] ")"
init           ::= "(:init" {init-el} ")"
init-el        ::= literal-name | "(=" f-head number ")"   ; se :fluents
literal-name   ::= "(" predicate {name} ")" | "(not (" predicate {name} "))"
goal           ::= "(:goal" GD ")"

metric-spec    ::= "(:metric" optimization ground-f-exp ")"
optimization   ::= minimize | maximize
ground-f-exp   ::= number 
                 | "(" binary-op ground-f-exp ground-f-exp ")"
                 | "(" "-" ground-f-exp ")" 
                 | "(" function-symbol {name} ")" 
                 | function-symbol
```

Baseado na especificação 1.2 (McDermott et al.) e no apêndice BNF/EBNF de cursos que a reproduzem. ([Courses Washington][1])

---

# Extensões PDDL 2.1 (numérico & temporal)

### (a) Numérico completo e métrica

Já refletido acima (comparações `f-comp`, efeitos numéricos `assign/increase/decrease/scale-up/scale-down`), e **métrica** com `total-time`:

```ebnf
num-effect ::= "(assign"  f-head f-exp ")"
             | "(increase" f-head f-exp ")"
             | "(decrease" f-head f-exp ")"
             | "(scale-up" f-head f-exp ")"
             | "(scale-down" f-head f-exp ")"

c-effect   ::= ... | num-effect

ground-f-exp ::= ... | total-time
```

([planning.wiki][2])

### (b) Ações durativas (temporais)

```ebnf
durative-def  ::= "(:durative-action" action-symbol
                   ":parameters (" TypedList[variable] ")"
                   ":duration" dur-constraint
                   [":condition" "(and" {timed-GD} ")"]
                   [":effect"    "(and" {timed-effect} ")"] ")"

dur-constraint ::= "(= ?duration" f-exp ")"
                 | dur-ineq                               ; se :duration-inequalities

dur-ineq       ::= "(" rel-op "?duration" f-exp ")"
rel-op         ::= "<" | "<=" | "=" | ">=" | ">"

timed-GD       ::= "(at start" GD ")" 
                 | "(over all" GD ")" 
                 | "(at end"  GD ")"

timed-effect   ::= "(at start" effect-el ")"
                 | "(at end"  effect-el ")"
effect-el      ::= literal-term | num-effect | "(when" GD effect ")"
```

([planning.wiki][2])

---

# Extensões PDDL 2.2 (predicados derivados & *timed initial literals*)

```ebnf
derived-def ::= "(:derived" "(" predicate TypedList[variable] ")" GD ")"

init-el     ::= ... | "(at" number literal-name ")"   ; timed initial literal
```

([planning.wiki][3])

---

# Extensões PDDL 3.0 (restrições de trajetória & preferências)

```ebnf
problem-file ::= ... [constraints-def] [metric-spec] ")"

constraints-def ::= "(:constraints" con-GD ")"

con-GD      ::= "(at end"   GD ")"
              | "(always"   GD ")"
              | "(sometime" GD ")"
              | "(within" number GD ")"
              | "(at-most-once" GD ")"
              | "(sometime-after"  GD GD ")"
              | "(sometime-before" GD GD ")"
              | "(always-within" number GD GD ")"
              | "(hold-during" number number GD ")"
              | "(hold-after"  number GD ")"
              | "(and" {con-GD}+ ")" | "(or" {con-GD}+ ")" | "(forall (" TypedList[variable] ") " con-GD ")"

(* Preferências “soft”: *)
GD         ::= ... | preference
preference ::= "(preference" [name] GD ")"

(* Métrica pode referir violação de preferências: *)
ground-f-exp ::= ... | "(is-violated" name ")"
```



---

## Observações úteis (ligadas à gramática)

* **:requirements**: se nenhum é declarado, assume-se `:strips`. Flags adicionais relevantes em 2.1 incluem `:durative-actions`, `:duration-inequalities` e `:continuous-effects` (níveis temporais). ([planning.wiki][2])
* **Ordenação**: em 2.1, declarações (`:types`, `:constants`, `:predicates`, `:functions`) devem vir antes das ações; entre si, `:constants`, `:predicates`, `:functions` podem trocar de ordem. ([planning.wiki][2])
* **PDDL 2.2** acrescenta `:derived-predicates` e `:timed-initial-literals`; em muitos *benchmarks* do IPC, evita-se usar ambos juntos no mesmo domínio. ([planning.wiki][3])
* **PDDL 3.0** introduz `:constraints` (operadores modais) e **preferências** com custo de violação via `(:metric ...)`.&#x20;

---

[1]: https://courses.cs.washington.edu/courses/cse473/06sp/pddl.pdf?utm_source=chatgpt.com "PDDL | The Planning Domain Definition Language - Washington"
[2]: https://planning.wiki/_citedpapers/pddl212003.pdf "(fox03a.pdf)"
[3]: https://planning.wiki/_citedpapers/pddl222004.pdf "total.dvi"
