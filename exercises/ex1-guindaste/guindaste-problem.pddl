(define (problem carregar-todos) 
  (:domain guindaste)
  (:objects
    g1 - guindaste
    t1 - caminhao
    c1 c2 c3 - container
    A B - local
  )
  (:init
    (guindaste_em g1 A)
    (caminhao_em t1 A)
    (container_em c1 B)
    (container_em c2 B)
    (container_em c3 B)
    (vazio g1)
  )
  (:goal (and (carregado t1 c1) (carregado t1 c2) (carregado t1 c3)))
)