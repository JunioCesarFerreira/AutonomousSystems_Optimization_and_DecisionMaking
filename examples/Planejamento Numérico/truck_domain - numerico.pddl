(define (domain caminhao_numerico) 
    (:requirements :strips :typing :numeric-fluents :conditional-effects) 
    (:types location truck quantity - object 
            refrigerated_truck - truck ) 
            
    (:predicates (at ?t - truck ?l - location))
    
    
    (:functions 
        (demand_chilled_goods ?c - location) - number ; remaining demand
        (demand_ambient_goods ?c - location) - number ; at ?c for goods
        (free_capacity ?t - truck) - number ; unused capacity in truck 
        (distance ?l1 ?l2 - location) - number ; distance between locations
        (per_km_cost ?t - truck) - number ; per-kilometer cost of each truck
        (total-cost) - number
    ) 
    
    (:action deliver_ambient
            :parameters (?t - truck ?l - location)
            :precondition (at ?t ?l) 
            :effect (and 
                        (when (>= (free_capacity ?t) (demand_ambient_goods ?l ))
                            (and (decrease (free_capacity ?t) (demand_ambient_goods ?l)) 
                                (assign (demand_ambient_goods ?l) 0)))
                        (when (< (free_capacity ?t) (demand_ambient_goods ?l ))
                            (and (decrease (demand_ambient_goods ?l) (free_capacity ?t)) 
                                (assign (free_capacity ?t) 0))))
    ) 

    (:action deliver_chilled
            :parameters (?t - truck ?l - location)
            :precondition (at ?t ?l) 
            :effect (and 
                        (when (>= (free_capacity ?t) (demand_chilled_goods ?l ))
                            (and (decrease (free_capacity ?t) (demand_chilled_goods ?l)) 
                                (assign (demand_chilled_goods ?l) 0)))
                        (when (< (free_capacity ?t) (demand_chilled_goods ?l ))
                            (and (decrease (demand_chilled_goods ?l) (free_capacity ?t)) 
                                (assign (free_capacity ?t) 0))))
    ) 

    
    (:action drive 
        :parameters (?t - truck ?from ?to - location) 
        :precondition (at ?t ?from) 
        :effect (and (not (at ?t ?from)) 
                        (at ?t ?to)
                        (increase (total-cost)
                        (* (distance ?from ?to) (per_km_cost ?t))))
    )
)