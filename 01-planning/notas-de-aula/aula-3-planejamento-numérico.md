# O que é Planejamento Numérico

É o planejamento clássico com as mesmas hipóteses (modelo determinístico, estado inicial conhecido, sem eventos exógenos), **mas com variáveis numéricas de estado** (funções) que podem aparecer em pré-condições, efeitos e métricas. Use `:fluents` em `:requirements`.&#x20;

## Funções e *fluents*

* **Funções** podem ter parâmetros (objetos do domínio ou do problema).
* **Fluent** = função **não estática** (muda por efeitos); **estática** = usada só para cálculo (valor fixo no `:init`).
* O PDDL **não** restringe intervalos (ex.: “só positivos”); você controla indiretamente por pré-condições e efeitos.
* Em problemas numéricos, *todas* as funções têm valor numérico.&#x20;

## Efeitos numéricos (no `:effect`)

Formato geral: `(<effect-type> <function-term> <expression>)`

* `assign` — atribui: `(assign (carga ?b) 100)`
* `increase` — soma: `(increase (total-cost) (* (distance ?l1 ?l2) (per_km_cost ?t)))`
* `decrease` — subtrai
* `scale-up` — multiplica
* `scale-down` — divide
  As expressões aceitam `+ - * /` (com `-` também unário) e literais numéricos racionais.&#x20;

## Expressões relacionais (em pré-condições/condições)

`(= | < | <= | > | >=  <exp>  <exp>)`
Ex.: `(<= (demandItem2 casaB) 0)`. Isso permite trocar predicados booleanos por **comparações numéricas** (p.ex., “há demanda?” vira `>= 1`).&#x20;

## Métrica de plano (no problema)

```
(:metric minimize | maximize <expression>)
```

Muito comum: **custo acumulado** via uma função 0-ária `total-cost`, aumentada nos efeitos das ações. **Inicialize `total-cost` em 0 no `:init`**. Observação: nem todo planejador otimiza métricas complexas com eficiência; o mais comum é minimizar soma de custos de ação.&#x20;

## Fatos numéricos (no `:init`)

Valores iniciais são dados como **fatos numéricos**:

```
(= <f-head> <valor-decimal>)
; ex.: (= (distance A B) 573)   (= (per_km_cost truck1) 1.8)
```

Estáticos (ex.: `distance`, `per_km_cost`) devem ser definidos no `:init`.&#x20;

---

# Checklist rápido para modelar

1. Em `:requirements`, inclua `:fluents`.
2. Declare funções em `(:functions ...)` (0-ária para `total-cost` se for usar custo).
3. No `:init`, forneça *todos* os valores estáticos e **`(= (total-cost) 0)`**.
4. Use efeitos numéricos para atualizar *fluents*.
5. Ponha `(:metric minimize (total-cost))` (ou outra expressão).&#x20;

# Armadilhas comuns (e como evitar)

* **Esquecer `:fluents`** → o domínio não reconhece funções numéricas.
* **Tentar tipar parâmetros como `number`** em `:parameters` → não é permitido (use objetos + funções para armazenar valores).
* **Não inicializar funções** no `:init` → muitos planejadores assumem 0, mas é fonte de erro/ambiguidade.
* **Otimização “lenta”** com métricas complexas → simplifique a métrica ou use custos de ação constantes.&#x20;

---

# Exercícios guiados (a partir do exemplo “Entrega de Produtos”)

1. **Custo por distância**:

   * Declare `distance`, `per_km_cost` (estáticas) e `total-cost` (0-ária).
   * Em `move`, faça `(increase (total-cost) (* (distance ?from ?to) (per_km_cost ?t)))`.
   * Defina `(:metric minimize (total-cost))` e compare planos.&#x20;
2. **Capacidade vs demanda**:

   * Modele `free_capacity(t)` e `demand_chilled_goods(l)`.
   * Use pré-condição relacional: `(>= (free_capacity ?t) (demanda ?l))`.
   * Adapte efeitos com `decrease`/`increase`.&#x20;
3. **Efeito condicional (ADL)**:

   * “Se a demanda zerar, marque local atendido.”
   * `(when (<= (demand ?l) 0) (served ?l))`. (Requer ADL.)&#x20;
