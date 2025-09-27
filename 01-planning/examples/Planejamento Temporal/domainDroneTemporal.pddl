(define (domain droneDomainV3)

    (:requirements :strips :typing :equality :numeric-fluents :continuous-effects :preferences :action-costs 
        :durative-actions :timed-initial-literals) ;; seção que indica quais recursos do PDDL o domínio usa
    (:types
        local drone - object
        asaFixa - drone
    )
    
    (:predicates ;;seção que contém a lista de variáveis de estado do modelo. 
    
        (atende ?dr - drone ?c - local) ;;drone precisa atender local
        (enable ?c - local)
    )
    
    (:functions
     (total-cost) - number
     (trajeto ?orig - local ?dest - local) - number
     (custoKm ?dr - drone) - number
     (estaCarregando ?dr - drone) - number;; drone carrega quantidade
     (demandaItem1 ?c - local) - number ;; demanda cliente item1
     (demandaItem2 ?c - local) - number;; demanda cliente item1
     (tempoViagem ?dr - drone) - number
     (velocidade ?dr - drone) - number          
    )

    (:action entregaItem1
        :parameters (?dr - drone ?l - local)
        :precondition (and (atende ?dr ?l)
                           (>=(demandaItem1 ?l) 1)
                           (>=(estaCarregando ?dr) 1))
        :effect (and (decrease (demandaItem1 ?l) 1)
                     (decrease (estaCarregando ?dr) 1))
                     
    )
    
    (:action entregaItem2
        :parameters (?dr - asaFixa ?l - local)
        :precondition (and (atende ?dr ?l)
                           (>=(demandaItem2 ?l) 1)
                           (>=(estaCarregando ?dr) 1))
        :effect (and (decrease (demandaItem2 ?l) 1)
                     (decrease (estaCarregando ?dr) 1))
                     
    )

    (:action calcularTempoViagem 
        :parameters (?dr - drone ?orig ?dest - local)
        :precondition (and (atende ?dr ?orig)
                           (=(tempoViagem ?dr) 0)
                      )
        :effect (and (assign (tempoViagem ?dr) (*(velocidade ?dr) (trajeto ?orig ?dest)))        
                )
    )


    (:durative-action voa
        :parameters (?dr - drone ?origem ?destino - local)
        :duration ( = ?duration  (tempoViagem ?dr) ) 
        :condition (and (at start (atende ?dr ?origem))
                        (over all (and (>(tempoViagem ?dr)0)
                                       (enable ?destino)
                                  )
                         )
                    )
                
        :effect (and (at start (not (atende ?dr ?origem)))
                     (at end (atende ?dr ?destino))
                     (at end (increase (total-cost) 
                            (* (trajeto ?origem ?destino) (custoKm ?dr))))
                     (at end (assign (tempoViagem ?dr) 0))
                )
    )   

)