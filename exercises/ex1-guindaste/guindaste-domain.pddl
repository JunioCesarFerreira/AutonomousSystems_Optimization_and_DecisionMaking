(define (domain guindaste)
  (:requirements :strips :typing)
  (:types
    container caminhao guindaste local
  )
  (:predicates
    (guindaste_em ?g - guindaste ?l - local)
    (caminhao_em ?t - caminhao ?l - local)
    (container_em ?c - container ?l - local)
    (vazio ?g - guindaste)
    (segurando ?g - guindaste ?c - container)
    (carregado ?t - caminhao ?c - container)
  )
  (:action mover
    :parameters (?g - guindaste ?de - local ?para - local)
    :precondition (guindaste_em ?g ?de)
    :effect (and (guindaste_em ?g ?para) (not (guindaste_em ?g ?de)))
  )
  (:action pegar
    :parameters (?g - guindaste ?c - container ?l - local)
    :precondition (and (guindaste_em ?g ?l) (container_em ?c ?l) (vazio ?g) )
    :effect (and (segurando ?g ?c) (not (container_em ?c ?l)) (not (vazio ?g)))
  )
  (:action colocar
    :parameters (?g - guindaste ?c - container ?t - caminhao ?l - local)
    :precondition (and (guindaste_em ?g ?l) (caminhao_em ?t ?l) (segurando ?g ?c) )
    :effect (and (carregado ?t ?c) (vazio ?g) (not (segurando ?g ?c)))
  )
)