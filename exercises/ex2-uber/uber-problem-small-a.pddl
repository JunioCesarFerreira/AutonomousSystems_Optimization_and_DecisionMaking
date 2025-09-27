(define (problem uber-prob-small-a)
  (:domain uber)
  (:objects
    a b c d e - location
    car1 - car
    p1 p2 - passenger
  )
  (:requirements :action-costs)
  (:init
    ;; grafo não-direcionado modelado por duas arestas dirigidas
    (road a b) (road b a)
    (road b c) (road c b)
    (road c d) (road d c)
    (road b e) (road e b)

    ;; distâncias em km
    (= (distance a b) 10) (= (distance b a) 10)
    (= (distance b c) 8)  (= (distance c b) 8)
    (= (distance c d) 6)  (= (distance d c) 6)
    (= (distance b e) 12) (= (distance e b) 12)

    (at car1 a) (free car1)

    ;; passageiros (origem/destino)
    (p-at p1 b) (needs-ride p1) (dest p1 d)
    (p-at p2 e) (needs-ride p2) (dest p2 c)

    (= (total-cost) 0)
  )
  (:goal (and (served p1) (served p2)))
  (:metric minimize (total-cost))
)
