(define (problem elevador-problema-temporal)
  (:domain elevador-dominio-temporal)
  (:objects 
   a1 a2 a3 a4 a5 - num
   p1 p2 p3 - passageiro
   e1 e2 - elevador
  )
  
  (:init
   (proximo a1 a2) (proximo a2 a3) (proximo a3 a4) (proximo a4 a5)
   (elevador-no-andar e1 a1) (elevador-no-andar e2 a5)
   (passageiro-no-andar p1 a2) (passageiro-no-andar p2 a2)
   (passageiro-no-andar p3 a4)
   (= (passageiro_veloc p1) 2)
   (= (passageiro_veloc p2) 3)
   (= (passageiro_veloc p3) 2)
   (= (elevador_veloc e1) 2)
   (= (elevador_veloc e2) 3)
   (= (floor_distance a1 a2) 3)
   (= (floor_distance a2 a3) 4)
   (= (floor_distance a3 a4) 4)
   (= (floor_distance a4 a5) 3)
   (= (floor_distance a5 a4) 3)
   (= (floor_distance a4 a3) 4)
   (= (floor_distance a3 a2) 4)
   (= (floor_distance a2 a1) 3)
   
  )
  
  (:goal (and (passageiro-no-andar p1 a1)
              (passageiro-no-andar p2 a1) 
              (passageiro-no-andar p3 a1))
  )
  
  (:metric minimize (total-time))
)