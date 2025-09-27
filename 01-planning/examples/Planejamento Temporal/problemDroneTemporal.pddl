(define (problem droneProblemV3 )
    (:domain droneDomainV3)
    (:objects 
        quad - drone
        xWing - asaFixa
        casaA casaB casaC base - local
    )
    (:init ;;essa seção contém uma lista de fatos que são verdadeiros no estado inicial.
        (atende quad base) (atende xWing base)
        (=(estaCarregando quad) 20) (=(estaCarregando xWing) 20)
        (= (demandaItem1 base) 0) (=(demandaItem2 base) 0)
        (= (demandaItem1 casaA) 15) (=(demandaItem2 casaA) 10)
        (=(demandaItem2 casaB) 3) (=(demandaItem1 casaB) 0) 
        (=(demandaItem1 casaC) 4) (=(demandaItem2 casaC) 5)
        (= (trajeto base casaA) 18) (= (trajeto base casaB) 45) (= (trajeto base casaC) 20) 
        (= (trajeto casaA base) 18) (= (trajeto casaA casaB) 12) (= (trajeto casaA casaC) 35) 
        (= (trajeto casaB base) 45) (= (trajeto casaB casaA) 12) (= (trajeto casaB casaC) 10) 
        (= (trajeto casaC base) 20) (= (trajeto casaC casaA) 35) (= (trajeto casaC casaB) 10) 
        (= (custoKm quad) 5.0) (= (custoKm xWing) 1.0) (= (total-cost) 0.0)
        (=(tempoViagem xWing) 0) (=(tempoViagem quad) 0)
        (=(velocidade xWing) 5) (=(velocidade quad) 2)    
        (at 0 (enable casaA))  (at 0 (enable casaB)) 
        (at 0 (enable casaC))  (at 0 (enable base))
        (at 200 (not (enable casaA)))

    )
    (:goal 
        (and (=(demandaItem1 casaA) 0) (=(demandaItem2 casaA) 0)
             (=(demandaItem2 casaB) 0) 
             (=(demandaItem1 casaC) 0) (=(demandaItem2 casaC) 0)
             (atende quad base) (atende xWing base) 
             ;;(at 300 (not (enable casaC)))
          )
    )
    
    (:metric minimize (total-time))
    
)