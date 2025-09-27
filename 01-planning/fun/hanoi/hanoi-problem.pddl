(define (problem hanoi-3)
  (:domain hanoi-stacks)

  (:objects
    d1 d2 d3 - disc
    A B C - peg
  )

  (:init
    ;; relação de tamanhos (d1 < d2 < d3)
    (smaller d1 d2)
    (smaller d1 d3)
    (smaller d2 d3)

    ;; estado inicial: todos em A (base d3, depois d2, topo d1)
    (on d3 A) (on d2 A) (on d1 A)
    (bottom d3 A)
    (next d3 d2 A)
    (next d2 d1 A)
    (top d1 A)

    ;; B e C vazios
    (empty B)
    (empty C)
  )

  (:goal (and
    (on d3 C) (on d2 C) (on d1 C)
    (bottom d3 C)
    (next d3 d2 C)
    (next d2 d1 C)
    (top d1 C)
  ))
)
