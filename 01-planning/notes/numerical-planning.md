# Planejamento Numérico (PDDL) 

## Ideia central

Planejamento clássico **com variáveis numéricas de estado** (funções/fluents) que podem aparecer em **pré-condições, efeitos e métricas**. Lembre de habilitar `:fluents` em `:requirements`.

---

## Tabela-resumo

| Categoria                        | Operadores / Construtores                                  | Sintaxe geral             | Exemplos                                                                                                                             | Observações                                                                                                                  |                                                                                                                                                                                       |
| -------------------------------- | ---------------------------------------------------------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Efeitos Numéricos**            | `assign`, `increase`, `decrease`, `scale-up`, `scale-down` | `(<op> <f-head> <f-exp>)` | `(assign (carga ?t) 100)` • `(increase (total-cost) (* (distance ?a ?b) (per_km ?t)))` • `(decrease (free_capacity ?t) (demand ?l))` | Usados dentro de `:effect`. `f-exp` aceita `+ - * /` e `-` unário.                                                           |                                                                                                                                                                                       |
| **Expressões Relacionais**       | `=`, `<`, `<=`, `>`, `>=`                                  | `(<rel> <f-exp> <f-exp>)` | `(>= (free_capacity ?t) (demand ?l))` • `(= (total-cost) 0)` • `(< (tempo ?x) 10)`                                                   | Usadas em pré-condições/condições (e às vezes em `:constraints`). Permitem substituir predicados booleanos por comparações.  |                                                                                                                                                                                       |
| **Fatos Numéricos (no `:init`)** | Atribuição inicial de funções                              | `(= <f-head> <número>)`   | `(= (distance A B) 573)` • `(= (per_km truck1) 1.8)` • `(= (total-cost) 0)`                                                          | Inicialize **todas** as funções relevantes. Valores “estáticos” (ex. distâncias) vão no `:init`.                             |                                                                                                                                                                                       |
| **Métricas**                     | \`:metric minimize                                         | maximize\`                | `(:metric <min/max> <ground-f-exp>)`                                                                                                 | `(:metric minimize (total-cost))` • `(:metric minimize (+ (total-cost) (* 0.1 (risco))) )` • `(:metric minimize total-time)` | Métrica típica: **custo acumulado** via `(increase (total-cost) …)`. `total-time` requer planejamento temporal; nem todo planner otimiza expressões complexas com a mesma eficiência. |

---

## Checklist rápido

1. Em `:requirements`, inclua **`:fluents`** (e `:adl` se usar condições/efeitos condicionais).
2. Declare funções em `(:functions ...)` (ex.: `(total-cost) - number`).
3. No `:init`, **inicialize** todos os valores (incluindo `(= (total-cost) 0)`).
4. Atualize *fluents* via **efeitos numéricos**.
5. Defina `(:metric minimize (total-cost))` (ou outra expressão).

---

## “Receita” do `total-cost` (custo por ação)

No **domínio**:

```pddl
(:requirements :strips :typing :adl :fluents)
(:functions
  (total-cost) - number
  (distance ?l1 ?l2) - number
  (per_km ?t) - number
)
(:action move
  :parameters (?t - truck ?from - loc ?to - loc)
  :precondition (and (at ?t ?from) (road ?from ?to))
  :effect (and
    (not (at ?t ?from)) (at ?t ?to)
    (increase (total-cost) (* (distance ?from ?to) (per_km ?t)))
  )
)
```

No **problema**:

```pddl
(:init
  (= (total-cost) 0)
  (= (distance A B) 573)
  (= (per_km truck1) 1.8)
  ; ... outros fatos e posições iniciais ...
)
(:goal (and (at truck1 B)))
(:metric minimize (total-cost))
```

---

## Dicas e armadilhas

* **Não** tipe parâmetros como `number` em `:parameters` (PDDL usa objetos; números entram via **funções**).
* Se esquecer `:fluents`, funções numéricas não serão reconhecidas.
* Métricas muito complexas podem degradar o desempenho — prefira **somas lineares** simples quando possível.
* Para “liga/desliga” numérico (ex.: “há demanda?”), use comparações como `(> (demand ?l) 0)` em vez de predicados booleanos separados.