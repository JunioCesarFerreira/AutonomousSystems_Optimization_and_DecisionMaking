(define (domain elevador-dominio)

(:requirements :typing)

(:types elevador passageiro andar -object)

(:predicates (passageiro-no-andar ?p -passageiro ?a -andar)
             (passageiro-no-elevador ?p -passageiro ?e -elevador)
             (elevador-no-andar ?e -elevador ?a -andar) (proximo ?n1 - andar ?a2 - andar)
             (requisita-elevador ?p -passageiro ?a -andar)
             (manutencao)
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
  :effect (and (forall (?p -passageiro)
                    (when (passageiro-no-andar ?p ?numAndar) 
                            (and(not(passageiro-no-andar ?p ?numAndar))
                                (passageiro-no-elevador ?p ?e))))))

(:action desembarcar
  :parameters (?numAndar -andar ?e -elevador )
  :precondition ( and(elevador-no-andar ?e ?numAndar))
  :effect (and (forall (?p -passageiro)
                    (when (passageiro-no-elevador ?p ?e)
                        (and(not(passageiro-no-elevador ?p ?e))
                            (passageiro-no-andar ?p ?numAndar))))))

(:action entrar-manutencao
  :parameters (?e -elevador)
  :precondition (forall (?p - passageiro)
                    (and(not(passageiro-no-elevador ?p ?e))
                         (forall (?numAndar - andar)
                                (imply (requisita-elevador ?p ?numAndar)
                                       (passageiro-no-andar ?p ?numAndar)))))
  :effect (manutencao))

)