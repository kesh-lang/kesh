-- original: https://raw.githubusercontent.com/anon767/TsetlinMachine/master/tsetlin.js

import [ floor, random ]: Math

new-machine: [ num-classes, num-clauses, num-features, num-states, s, threshold ] ->
    let ta-state: array[]
    let clause-sign: array[]
    
    let clause-count:        Array(num-classes).fill(0)
    let clause-output:       Array(num-clauses).fill(0)
    let class-sum:           Array(num-classes).fill(0)
    let feedback-to-clauses: Array(num-clauses).fill(0)
    
    init-ta-state: () *->
        loop 0 ..< num-clauses as i
            set ta-state.(i): array[]
            loop 0 ..< num-features as j
                set ta-state.(i).(j): array[]
                set ta-state.(i).(j).0: if floor(random()) then num-states else num-states + 1
                set ta-state.(i).(j).1: if floor(random()) then num-states else num-states + 1
    
    init-clause-signs: () *->
        loop 0 ..< num-classes as i
            set clause-sign.(i): array[]
            loop 0 ..< (num-clauses / num-classes) as j
                set clause-sign.(i).(j): array[]
                set clause-sign.(i).(j).0: 0
                set clause-sign.(i).(j).1: 0
    
    init-clause-count: () *->
        loop 0 ..< num-classes as i
            loop 0 ..< floor(num-clauses / num-classes) as j
                set clause-sign.(i).( clause-count.(i) ).0: i * (num-clauses / num-classes) + j
                if j rem 2 = 0
                    set clause-sign.(i).( clause-count.(i) ).1: 1
                else
                    set clause-sign.(i).( clause-count.(i) ).1: -1
                increment clause-count.(i)
    
    action: (state) -> if state <= num-states then 0 else 1
    
    calc-clause-output: (x, predict ? 0) *->
        loop 0 ..< num-clauses as j
            set clause-output.(j): 1
            let all-exclude: 1
            loop 0 ..< num-features as k
                action-include: action ta-state.(j).(k).0
                action-include-neg: action ta-state.(j).(k).1
                if action-include = 1 or action-include-neg = 1
                    set all-exclude: 0
                if (action-include = 1 and x.(k) = 0) or (action-include-neg = 1 and x.(k) = 1)
                    set clause-output.(j): 0
                    break
            if predict = 1 and all-exclude = 1
                set clause-output.(j): 0
    
    sum-up-class-votes: () *->
        loop 0 ..< num-classes as target-class
            set class-sum.(target-class): 0
            loop 0 ..< clause-count.(target-class) as j
                set class-sum.(target-class): _
                    + (clause-output.( clause-sign.(target-class).(j).0 )
                    * clause-sign.(target-class).(j).1)
                if class-sum.(target-class) > threshold
                    set class-sum.(target-class): threshold
                else if class-sum.(target-class) < -threshold
                    set class-sum.(target-class): -threshold
    
    predict: (x) ->
        calc-clause-output(x, 1)
        sum-up-class-votes()
        let max-class-sum: class-sum.0
        let max-class: 0
        loop 1 ..< num-classes as target-class
            if max-class-sum < class-sum.(target-class)
                set max-class-sum: class-sum.(target-class)
                set max-class: target-class
        max-class
    
    update: (x, target-class) *->
        -- Randomly pick one of the other classes, for pairwise learning of class output
        let negative-target-class: floor(num-classes * (1.0 - 1e-15) * random())
        while negative-target-class = target-class
            set negative-target-class: floor(num-classes * (1.0 - 1e-15) * random())
        -- Calculate Clause Output
        calc-clause-output(x)
        -- sum up clause votes
        sum-up-class-votes()
        -- calculate Feedback to Clauses
        
        loop 0 ..< num-clauses as j  --  init feedback to clauses
            set feedback-to-clauses.(j): 0
    
        loop 0 ..< clause-count.(target-class) as j
            if random() > (1.0 / threshold * 2) * (threshold - class-sum.(target-class))
                continue
    
            if clause-sign.(target-class).(j).1 > 0
                increment feedback-to-clauses.( clause-sign.(target-class).(j).0 )
            else if clause-sign.(target-class).(j).1 < 0
                decrement feedback-to-clauses.( clause-sign.(target-class).(j).0 )
    
        loop 0 ..< clause-count.(negative-target-class) as j
            if random() > (1.0 / threshold * 2) * (threshold + class-sum.(negative-target-class))
                continue
    
            if clause-sign.(negative-target-class).(j).1 > 0
                decrement feedback-to-clauses.( clause-sign.(negative-target-class).(j).0 )
            else if clause-sign.(negative-target-class).(j).1 < 0)
                increment feedback-to-clauses.( clause-sign.(negative-target-class).(j).0 )
    
        -- Train individual Automata
        loop 0 ..< num-clauses as j
            if feedback-to-clauses.(j) > 0
                -- Type I Feedback (Combats False Negatives)
                if clause-output.(j) = 0
                    loop 0 ..< num-features as k
                        if random() <= 1.0 / s
                            if ta-state.(j).(k).0 > 1
                                decrement ta-state.(j).(k).0
                        if random() <= 1.0 / s
                            if ta-state.(j).(k).1 > 1
                                decrement ta-state.(j).(k).1
                else if clause-output.(j) = 1
                    loop 0 ..< num-features as k
                        if x.(k) = 1
                            if random() <= (s - 1) / s
                                if ta-state.(j).(k).0 < num-states * 2
                                    increment ta-state.(j).(k).0
                            if random() <= 1.0 / s
                                if ta-state.(j).(k).1 > 1
                                    decrement ta-state.(j).(k).1
                        else if x.(k) = 0
                            if random() <= (s - 1) / s
                                if ta-state.(j).(k).1 < num-states * 2
                                    increment ta-state.(j).(k).1
                            if random() <= 1.0 / s
                                if ta-state.(j).(k).0 > 1
                                    decrement ta-state.(j).(k).0
            else if feedback-to-clauses.(j) < 0
                --  Type II Feedback (Combats False Positives)
                if clause-output.(j) = 1
                    loop 0 ..< num-features as k
                        let action-include: action ta-state.(j).(k).0
                        let action-include-negated: action ta-state.(j).(k).1
                        if x.(k) = 0
                            if action-include = 0 and ta-state.(j).(k).0 < num-states * 2
                                increment ta-state.(j).(k).0
                        else if x.(k) = 1
                            if action-include-negated = 0 and ta-state.(j).(k).1 < num-states * 2
                                increment ta-state.(j).(k).1
    
    evaluate: (x, y) ->
        let errors: 0
        loop 0 ..< x.length as l
            if predict x.(l) ≠ y.(l) then increment errors
        1.0 - errors / x.length
    
    init-ta-state()
    init-clause-signs()
    init-clause-count()
    
    [ predict, update, evaluate ]
    
[ new-machine ]
