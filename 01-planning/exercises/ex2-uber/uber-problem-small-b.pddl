(define (problem uber-prob-small-b)
  (:domain uber)
  (:objects
    a b c d - location
    car1 - car
    p1 p2 p3 - passenger
  )
  (:requirements :action-costs)
  (:init
    (road a b) (road b a) (= (distance a b) 5) (= (distance b a) 5)
    (road b c) (road c b) (= (distance b c) 7) (= (distance c b) 7)
    (road c d) (road d c) (= (distance c d) 4) (= (distance d c) 4)
    (road a d) (road d a) (= (distance a d) 9) (= (distance d a) 9)

    (at car1 a) (free car1)

    (p-at p1 b) (needs-ride p1) (dest p1 d)
    (p-at p2 c) (needs-ride p2) (dest p2 a)
    (p-at p3 a) (needs-ride p3) (dest p3 c)

    (= (total-cost) 0)
  )
  (:goal (and (served p1) (served p2) (served p3)))
  (:metric minimize (total-cost))
)
