(define (domain uber)
  (:requirements :strips :typing :fluents)
  (:types car passenger location)

  (:predicates
    (road ?from - location ?to - location)
    (at ?c - car ?l - location)
    (p-at ?p - passenger ?l - location)
    (in ?p - passenger ?c - car)
    (needs-ride ?p - passenger)
    (dest ?p - passenger ?l - location)
    (free ?c - car) ; carro disponível (sem passageiro)
    (served ?p - passenger)
  )

  (:functions
    (distance ?from - location ?to - location) ; km
    (total-cost) ; R$
  )

  ;; custo de R$5,00/km. Só dirige; coleta/entrega não têm custo.
  (:action drive
    :parameters (?c - car ?from - location ?to - location)
    :precondition (and (at ?c ?from) (road ?from ?to))
    :effect (and
      (not (at ?c ?from)) (at ?c ?to)
      (increase (total-cost) (* 5 (distance ?from ?to)))
    )
  )

  (:action pickup
    :parameters (?c - car ?p - passenger ?l - location)
    :precondition (and (free ?c) (at ?c ?l) (p-at ?p ?l) (needs-ride ?p))
    :effect (and (in ?p ?c) (not (p-at ?p ?l)) (not (free ?c)))
  )

  (:action dropoff
    :parameters (?c - car ?p - passenger ?l - location)
    :precondition (and (in ?p ?c) (at ?c ?l) (dest ?p ?l))
    :effect (and (served ?p) (free ?c) (not (in ?p ?c)) (p-at ?p ?l) (not (needs-ride ?p)))
  )
)
