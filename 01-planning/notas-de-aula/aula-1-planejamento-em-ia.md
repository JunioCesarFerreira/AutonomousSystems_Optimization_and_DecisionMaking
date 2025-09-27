# Planejamento em IA

## 1) O que é “planning”

* **Deliberação**: processo de decidir/organizar ações antecipando resultados para atingir objetivos.
* **AI Planning**: estudo de **modelos computacionais** para **criar, analisar, gerenciar e executar planos**.
* Dois enfoques:

  * **Domínio-específico**: modelos/técnicas sob medida para um problema.
  * **Independente de domínio**: abstrações reutilizáveis (línguas de descrição, modelos e solvers genéricos).

## 2) Arquitetura (linguagem → modelo → solver)

* **Problem Description Language** (ex.: PDDL) → **Problem Model** (estados, ações, objetivos, métricas) → **Solver** (planejador) que produz o **plano**.

## 3) State-Transition Systems (STS)

* **Definição**: $\Sigma=(S,A,E,f)$

  * $S$: conjunto (finito ou RE) de estados
  * $A$: ações; $E$: eventos
  * $f: S\times(A\cup E)\to S'$: função de transição
  * $a\in A$ é aplicável em $s$ se $f(s,a)\neq \emptyset$; aplicar $a$ em $s$ leva a $s' = f(s,a)$.
* **Grafo de estados**: $G=(N_G,E_G)$, com $N_G=S$ e há arco $(s,s')\in E_G$ sse $s'\in f(s,\,\cdot\,)$.
* **Plano**: sequência de ações que leva **estado inicial → estado objetivo**.
* **Objetivo**: alcançar estados que satisfazem condição/meta; opcionalmente **otimizar** métrica (custo, utilidade, makespan).

## 4) Representação do conhecimento (estilo PDDL)

* **Objetos**: entidades do domínio (ex.: missionários $M$, canibais $C$, barco).
* **Variáveis de estado**: símbolos associados a objetos (posição do barco, contagens).
* **Fatos/Predicados**: propriedades verdadeiras/falsas (ex.: `naMargemNorte(3m,3c)`, `barcoMargemSul`).
* **Estado**: conjunto de fatos verdadeiros (hipótese de **mundo fechado**: o não mencionado é falso).

## 5) Exemplo canônico — Missionários & Canibais

* **Enunciado**: atravessar todos com um barco de 2 lugares sem que jesuítas/missionários fiquem minoria em alguma margem.
* **Modelagem**:

  * **S**: distribuições possíveis $(mN, cN, mS, cS, barco)$
  * **A**: movimentos válidos (ex.: `Move(1m,1c)`, `Move(2m)`, …)
  * **Plano**: sequência que respeita as restrições até o objetivo (todos na margem alvo, regra nunca violada).

## 6) Planejamento e execução

* **Laço clássico**: Planejador recebe $\Sigma, s_0, G$ → gera **plano** → **Controlador** executa ações no sistema.
* **Planejamento dinâmico**: integra **observações** e **status de execução** (replanejamento quando necessário).

---

## Glossário essencial

* **Plano (plan)**: lista ordenada de ações (ou política, em extensões com incerteza).
* **Estado inicial / objetivo**: origem e critério de parada/sucesso.
* **Evento (E)**: transições não controladas pelo agente (modelo geral).
* **Solver**: planejador (heurístico, SAT/SMT, CP/MIP etc.) que busca plano válido/ótimo.
* **Métrica**: função a minimizar/maximizar durante a transição (ex.: custo).

## Checklist de estudo

* [ ] Identificar $S, A, E, f$ e $G$ no problema dado.
* [ ] Definir **estado inicial** e **objetivo** claramente.
* [ ] Verificar **restrições** (invariantes, segurança).
* [ ] Esboçar **plano** e (se houver) **métrica** a otimizar.
* [ ] Entender como o **planejador** será acoplado à **execução** (observações/replanejamento).
