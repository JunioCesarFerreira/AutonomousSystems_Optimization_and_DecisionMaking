(define (domain crane)
  (:requirements :strips :typing)
  (:types container place crane truck)

  (:predicates
    (at ?g - crane ?p - place)
    (truck-at ?t - truck ?p - place)
    (on ?x - container ?y - container)
    (on-truck ?x - container ?t - truck)
    (on-ground ?x - container ?p - place)
    (clear ?x - container)
    (handempty ?g - crane)
    (holding ?g - crane ?x - container)
  )

  (:action pick-ground
    :parameters (?g - crane ?x - container ?p - place)
    :precondition (and (handempty ?g) (on-ground ?x ?p) (clear ?x) (at ?g ?p))
    :effect (and (not (on-ground ?x ?p)) (not (handempty ?g)) (holding ?g ?x))
  )

  (:action put-on-truck
    :parameters (?g - crane ?x - container ?t - truck ?p - place)
    :precondition (and (holding ?g ?x) (truck-at ?t ?p) (at ?g ?p))
    :effect (and (on-truck ?x ?t) (handempty ?g) (not (holding ?g ?x)))
  )

  (:action stack
    :parameters (?g - crane ?x - container ?y - container ?p - place)
    :precondition (and (holding ?g ?x) (clear ?y) (at ?g ?p))
    :effect (and (on ?x ?y) (handempty ?g) (clear ?x) (not (holding ?g ?x)) (not (clear ?y)))
  )

  (:action unstack
    :parameters (?g - crane ?x - container ?y - container ?p - place)
    :precondition (and (handempty ?g) (on ?x ?y) (clear ?x) (at ?g ?p))
    :effect (and (holding ?g ?x) (not (on ?x ?y)) (not (handempty ?g)) (clear ?y) (not (clear ?x)))
  )
)
