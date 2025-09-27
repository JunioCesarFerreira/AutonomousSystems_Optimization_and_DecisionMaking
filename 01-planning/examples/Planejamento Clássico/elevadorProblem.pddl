(define (problem elevador-problema)
  (:domain elevador-dominio)
  (:objects 
   a1 a2 a3 a4 a5 - andar
   pi1 pi2 pi3 - passageiro
   e1 e2 - elevador
  )
  
  (:init
   (proximo a1 a2) (proximo a2 a3) (proximo a3 a4) (proximo a4 a5)
   (elevador-no-andar e1 a1) (elevador-no-andar e2 a5)
   (passageiro-no-andar pi1 a2) (passageiro-no-andar pi2 a2)
   (passageiro-no-andar pi3 a4)
  )
  
  (:goal (and (passageiro-no-andar pi1 a1)
              (passageiro-no-andar pi2 a1) 
              (passageiro-no-andar pi3 a1))
  )
)