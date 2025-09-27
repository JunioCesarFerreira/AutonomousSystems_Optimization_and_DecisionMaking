(define (domain pilhas)
  (:requirements :strips :typing :equality :negative-preconditions)
  (:types item pilha)

  (:predicates
    (on ?i - item ?p - pilha)          ; item está na pilha p
    (top ?i - item ?p - pilha)         ; i é o topo da pilha p
    (bottom ?i - item ?p - pilha)      ; i é a base da pilha p
    (next ?b - item ?a - item ?p - pilha) ; em p, a está imediatamente acima de b
    (empty ?p - pilha)                 ; pilha p está vazia
  )

  ;; mover topo i de FROM (com pelo menos 2 itens) para TO vazio
  (:action move-top-to-empty
    :parameters (?i - item ?b - item ?from - pilha ?to - pilha)
    :precondition (and
      (top ?i ?from)
      (next ?b ?i ?from)
      (not (= ?from ?to))
      (empty ?to)
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

  ;; mover topo i que é o único item (top & bottom) de FROM para TO vazio
  (:action move-last-to-empty
    :parameters (?i - item ?from - pilha ?to - pilha)
    :precondition (and
      (top ?i ?from)
      (bottom ?i ?from)
      (not (= ?from ?to))
      (empty ?to)
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

  ;; mover topo i (com item abaixo ?b) de FROM para TO não-vazio (coroa ?t)
  (:action move-top-to-nonempty
    :parameters (?i - item ?b - item ?t - item ?from - pilha ?to - pilha)
    :precondition (and
      (top ?i ?from)
      (next ?b ?i ?from)
      (top ?t ?to)
      (not (= ?from ?to))
      (not (empty ?to))
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
      (not (bottom ?i ?to))  ;; i não é base ao empilhar sobre algo
    )
  )

  ;; mover último item i (top & bottom) de FROM para TO não-vazio (coroa ?t)
  (:action move-last-to-nonempty
    :parameters (?i - item ?t - item ?from - pilha ?to - pilha)
    :precondition (and
      (top ?i ?from)
      (bottom ?i ?from)
      (top ?t ?to)
      (not (= ?from ?to))
      (not (empty ?to))
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
      (not (bottom ?i ?to))
    )
  )
)
