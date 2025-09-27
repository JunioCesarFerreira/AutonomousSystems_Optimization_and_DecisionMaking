(define (domain elevador-dominio-temporal)

(:requirements :typing :durative-actions :fluents)

(:types elevador passageiro num -object)

(:predicates (passageiro-no-andar ?p -passageiro ?a -num)
             (passageiro-no-elevador ?p -passageiro ?e -elevador)
             (elevador-no-andar ?e -elevador ?a -num) (proximo ?n1 - num ?a2 - num)
)

(:functions
    (passageiro_veloc ?p - passageiro)
    (elevador_veloc ?e - elevador)
    (floor_distance ?a1 ?a2 - num)
)

(:durative-action move-acima
  :parameters (?e - elevador ?atual ?prox - num)
  :duration (= ?duration (/ (floor_distance ?atual ?prox)
                            (elevador_veloc ?e)))
  :condition (and(at start (elevador-no-andar ?e ?atual))
                 (over all (proximo ?atual ?prox)))
  :effect (and(at start (not(elevador-no-andar ?e ?atual)))
              (at end (elevador-no-andar ?e ?prox)))
)

(:durative-action move-abaixo
  :parameters (?e - elevador ?atual ?prox - num)
  :duration (= ?duration (/ (floor_distance ?atual ?prox)
                            (elevador_veloc ?e)))
  :condition (and(at start (elevador-no-andar ?e ?atual))
                 (over all (proximo ?prox ?atual)))
  :effect (and(at start (not(elevador-no-andar ?e ?atual)))
              (at end (elevador-no-andar ?e ?prox)))
)

(:durative-action embarcar
  :parameters (?p - passageiro ?numAndar -num ?e -elevador )
  :duration (= ?duration (passageiro_veloc ?p))
  :condition ( and (over all (elevador-no-andar ?e ?numAndar))
                   (at start (passageiro-no-andar ?p ?numAndar)))
  :effect  (and (at start (not (passageiro-no-andar ?p ?numAndar))) 
                (at end (passageiro-no-elevador ?p ?e)))
)

(:durative-action desembarcar
  :parameters (?p -passageiro ?numAndar -num ?e -elevador )
  :duration (= ?duration (passageiro_veloc ?p))
  :condition ( and(over all (elevador-no-andar ?e ?numAndar))
                  (at start (passageiro-no-elevador ?p ?e)))
  :effect (and (at end (passageiro-no-andar ?p ?numAndar))
               (at start (not(passageiro-no-elevador ?p ?e))))
)
)
