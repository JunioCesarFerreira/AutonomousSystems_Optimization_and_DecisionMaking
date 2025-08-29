(define (problem mover-pilha-A-para-B)
  (:domain pilhas)
  (:objects
    a b c - item
    A B - pilha
  )
  (:init
    ;; pilha A com três itens: base a, depois b, topo c
    (on a A) (on b A) (on c A)
    (bottom a A)
    (next a b A)
    (next b c A)
    (top c A)
    ;; pilha B vazia
    (empty B)
  )
  (:goal (and
    (on a B)
    (on b B)
    (on c B)
    (top a B)
    (next b a B)
    (bottom c B)
  ))
)
