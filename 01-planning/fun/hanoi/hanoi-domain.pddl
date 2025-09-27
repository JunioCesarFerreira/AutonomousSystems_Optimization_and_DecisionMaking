(define (domain hanoi-stacks)
  (:requirements :strips :typing :equality)
  (:types disc peg)

  (:predicates
    (on ?d - disc ?p - peg)                 ; disco d está no pino p
    (top ?d - disc ?p - peg)                ; d é o topo de p
    (bottom ?d - disc ?p - peg)             ; d é a base de p
    (next ?b - disc ?a - disc ?p - peg)     ; em p, a está imediatamente acima de b
    (empty ?p - peg)                        ; p está vazio
    (smaller ?d1 - disc ?d2 - disc)         ; d1 é menor que d2
  )

  ;; mover topo i de FROM (com item abaixo b) para TO vazio
  (:action move-top-to-empty
    :parameters (?i - disc ?b - disc ?from - peg ?to - peg)
    :precondition (and
      (top ?i ?from)
      (next ?b ?i ?from)
      (empty ?to)
      (not (= ?from ?to))
    )
    :effect (and
      ;; origem
      (not (top ?i ?from))
      (not (next ?b ?i ?from))
      (not (on ?i ?from))
      (top ?b ?from)
      ;; destino
      (not (empty ?to))
      (on ?i ?to)
      (top ?i ?to)
      (bottom ?i ?to)
    )
  )

  ;; mover último disco i (top & bottom) de FROM para TO vazio
  (:action move-last-to-empty
    :parameters (?i - disc ?from - peg ?to - peg)
    :precondition (and
      (top ?i ?from)
      (bottom ?i ?from)
      (empty ?to)
      (not (= ?from ?to))
    )
    :effect (and
      ;; origem fica vazia
      (not (top ?i ?from))
      (not (bottom ?i ?from))
      (not (on ?i ?from))
      (empty ?from)
      ;; destino
      (not (empty ?to))
      (on ?i ?to)
      (top ?i ?to)
      (bottom ?i ?to)
    )
  )

  ;; mover topo i (com b abaixo) de FROM para TO não-vazio (coroado por t), respeitando tamanho
  (:action move-top-to-nonempty
    :parameters (?i - disc ?b - disc ?t - disc ?from - peg ?to - peg)
    :precondition (and
      (top ?i ?from)
      (next ?b ?i ?from)
      (top ?t ?to)
      (smaller ?i ?t)
      (not (= ?from ?to))
    )
    :effect (and
      ;; origem
      (not (top ?i ?from))
      (not (next ?b ?i ?from))
      (not (on ?i ?from))
      (top ?b ?from)
      ;; destino
      (not (top ?t ?to))
      (next ?t ?i ?to)
      (top ?i ?to)
      (on ?i ?to)
    )
  )

  ;; mover último disco i (top & bottom) de FROM para TO não-vazio (coroado por t), respeitando tamanho
  (:action move-last-to-nonempty
    :parameters (?i - disc ?t - disc ?from - peg ?to - peg)
    :precondition (and
      (top ?i ?from)
      (bottom ?i ?from)
      (top ?t ?to)
      (smaller ?i ?t)
      (not (= ?from ?to))
    )
    :effect (and
      ;; origem vira vazia
      (not (top ?i ?from))
      (not (bottom ?i ?from))
      (not (on ?i ?from))
      (empty ?from)
      ;; destino
      (not (top ?t ?to))
      (next ?t ?i ?to)
      (top ?i ?to)
      (on ?i ?to)
    )
  )
)
