# Planejamento Clássico

## 1) Hipóteses do planejamento clássico

* Fatos **booleanos** (verdadeiro/falso) e **conjunto finito** de ações.
* Ações são **corretas e determinísticas**: mesma ação no mesmo estado → mesmo resultado.
* **Estado inicial completamente conhecido**.
* **Ambiente estático**: só muda por ações do planejador (sem eventos exógenos).&#x20;

## 2) Modelo e pipeline

* **Sistema de transição de estados**: $\Sigma=(S,A,E,f)$.
* **Descrição**: $(S,A,E,f)$ + **estado inicial** + **objetivos** → **planejador** gera **plano**; **controlador** executa. (No clássico, normalmente $E=\emptyset$).&#x20;

## 3) PDDL — visão geral

* Linguagem padrão (McDermott, 1998), inspirada em **STRIPS** (1971) e **ADL** (1987).
* **Separa**: **Domínio** (variáveis de estado e ações) × **Problema** (objetos, `:init`, `:goal`).&#x20;

### Sintaxe básica

* Tudo entre **parênteses**; **ordem prefixa**; *case-insensitive*.
* Palavras-chave com `:` (ex.: `:requirements`, `:predicates`, `:precondition`, `:effect`).
* Espaços/linhas são ignorados (salvo para separar *tokens*).&#x20;

## 4) Arquivo de **Domínio**

* `(:requirements ...)` → declara recursos usados (ex.: `:strips`, `:typing`, `:adl`).
* `(:predicates ...)` → **variáveis de estado** (predicados).
* **Ações** (schemas): `:parameters`, `:precondition`, `:effect`.
* **Pré-condições** e **efeitos** são dados por **literais** (positivos/negados).&#x20;

## 5) Arquivo de **Problema**

* `(:init ...)` → **fatos verdadeiros** no estado inicial (o resto é **falso**: hipótese de mundo fechado).
* `(:goal ...)` → condição de meta (um fato ou **conjunção** de fatos; não precisa identificar um único estado).&#x20;

## 6) Espaço de estados, alcançabilidade e invariantes

* **Ações** transformam estados; um **plano** é uma sequência aplicável que satisfaz o **goal**.
* **Espaço alcançável**: estados que podem ser atingidos a partir do `:init`.
* **Invariante de estado**: propriedade preservada em **todo** estado alcançável; a modelagem deve manter o problema **dentro** do espaço válido.&#x20;

## 7) Exemplo “Entrega de Produtos” (inteiro discreto via objetos)

* **Tipos**: `location`, `truck`, `refrigerated_truck`, `quantity`.
* **Predicados** incluem demandas e capacidades parametrizadas por um **objeto quantidade** (`n0`, `n1`, …).
* Sucessor **discreto** com `(plus1 n_k n_{k+1})` no `:init` para permitir **incremento/decremento** de contagens **sem números reais**.
* Ações `deliver_*` consomem demanda e capacidade trocando `n_k` por `n_{k-1}` via pré-condições/efeitos; `drive` move caminhões. (Padrão útil quando ainda não se usa *fluents* numéricos.)&#x20;

## 8) ADL: expressividade extra

* **Efeito condicional**: `(when <cond> <effect>)` — aplica `<effect>` **apenas se** `<cond>` vale **no momento do efeito**. Útil p/ “elevador”, por ex., abrir portas só se houver passageiro no andar.&#x20;
* **Quantificador universal em `:effect`**: `(forall (<vars>) <effect>)` — evita listar cada constante; pode **conter** efeitos condicionais.&#x20;
* **Pré-condição disjuntiva**: `(or c1 c2 ...)` — basta **uma** ser verdadeira. **Existencial**: `(exists (<vars>) <cond>)`.&#x20;
* **Implicação**: `(imply A B)` é **operador lógico** para **fórmulas** (pré-condição/goal). **Não** confundir com `when` (que vive em `:effect`).&#x20;

---

## Checklist rápido de modelagem

* [ ] Escolha `:requirements` mínimos (ex.: `:strips`; acrescente `:typing`, `:adl` conforme necessário).&#x20;
* [ ] Garanta que **toda ação** mantém **invariantes** e **não sai** do espaço válido alcançável.&#x20;
* [ ] No `:init`, liste **somente** os fatos verdadeiros (lembre do **mundo fechado**).&#x20;
* [ ] Use **ADL** (when/forall/or/exists/imply) para **clareza** e **concisão** quando a semântica pedir.&#x20;
