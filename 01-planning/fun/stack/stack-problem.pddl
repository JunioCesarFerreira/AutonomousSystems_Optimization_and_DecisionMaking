(define (problem mover-pilha-p1-para-p2)
  (:domain pilhas)
  (:objects
    a b c - item
    p1 p2 - pilha
  )
  (:init
    ;; pilha p1 com três itens: base a, depois b, topo c
    (on a p1) (on b p1) (on c p1)
    (bottom a p1)
    (next a b p1)
    (next b c p1)
    (top c p1)
    ;; pilha p2 vazia
    (empty p2)
  )
  (:goal (and
    (on a p2)
    (on b p2)
    (on c p2)
    (top a p2)
    (next b a p2)
    (bottom c p2)
  ))
)
