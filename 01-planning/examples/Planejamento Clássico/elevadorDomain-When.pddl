(define (domain elevador-dominio)

(:requirements :typing :conditional-effects)

(:constants p1 p2 p3 - passageiro)

(:types elevador passageiro andar -object)

(:predicates (passageiro-no-andar ?p -passageiro ?a -andar)
             (passageiro-no-elevador ?p -passageiro ?e -elevador)
             (elevador-no-andar ?e -elevador ?a -andar) (proximo ?n1 - andar ?a2 - andar)
)

(:action move-acima
  :parameters (?e - elevador ?atual ?prox - andar)
  :precondition (and(elevador-no-andar ?e ?atual) (proximo ?atual ?prox))
  :effect (and(not(elevador-no-andar ?e ?atual))(elevador-no-andar ?e ?prox))
)

(:action move-abaixo
  :parameters (?e -elevador ?atual ?prox - andar)
  :precondition (and(elevador-no-andar ?e ?atual)(proximo ?prox ?atual))
  :effect (and (not (elevador-no-andar ?e ?atual)) (elevador-no-andar ?e ?prox))
)

(:action embarcar
  :parameters (?numAndar -andar ?e -elevador )
  :precondition ( and(elevador-no-andar ?e ?numAndar))
  :effect   (and (when (passageiro-no-andar p1 ?numAndar) 
                    (and(not(passageiro-no-andar p1 ?numAndar))
                    (passageiro-no-elevador p1 ?e)))
                 (when (passageiro-no-andar p2 ?numAndar) 
                    (and(not(passageiro-no-andar p2 ?numAndar))
                    (passageiro-no-elevador p2 ?e)))
                (when (passageiro-no-andar p3 ?numAndar) 
                    (and(not(passageiro-no-andar p3 ?numAndar))
                    (passageiro-no-elevador p3 ?e)))
            )
)

(:action desembarcar
  :parameters (?numAndar -andar ?e -elevador )
  :precondition ( and(elevador-no-andar ?e ?numAndar))
  :effect   (and (when (passageiro-no-elevador p1 ?e)
                    (and(not(passageiro-no-elevador p1 ?e))
                        (passageiro-no-andar p1 ?numAndar)))
                (when (passageiro-no-elevador p1 ?e)
                    (and(not(passageiro-no-elevador p2 ?e))
                        (passageiro-no-andar p2 ?numAndar)))
                (when (passageiro-no-elevador p2 ?e)
                    (and(not(passageiro-no-elevador p3 ?e))
                        (passageiro-no-andar p3 ?numAndar)))
            )
)
                
)