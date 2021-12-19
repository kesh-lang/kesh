-- original: https://raw.githubusercontent.com/anon767/TsetlinMachine/master/tsetlin.js

import [ floor, random ]: Math

new-machine: [ numClasses, numClauses, numFeatures, numStates, s, threshold ] ->
    taState: array[]
    clauseSign: array[]
    
    clauseCount:       #array.from([ length: numClasses ]).fill(0)
    clauseOutput:      #array.from([ length: numClauses ]).fill(0)
    classSum:          #array.from([ length: numClasses ]).fill(0)
    feedBackToClauses: #array.from([ length: numClauses ]).fill(0)
    
    initTaState: () *->
        loop 0 ..< numClauses as i
            set taState.(i): array[]
            loop 0 ..< numFeatures as j
                set taState.(i).(j): array[]
                set taState.(i).(j).0: if floor(random()) then numStates else numStates + 1
                set taState.(i).(j).1: if floor(random()) then numStates else numStates + 1
    
    initClauseSigns: () *->
        loop 0 ..< numClasses as i
            set clauseSign.(i): array[]
            loop 0 ..< (numClauses / numClasses) as j
                set clauseSign.(i).(j): array[]
                set clauseSign.(i).(j).0: 0
                set clauseSign.(i).(j).1: 0
    
    initClauseCount: () *->
        loop 0 ..< numClasses as i
            loop 0 ..< floor(numClauses / numClasses) as j
                set clauseSign.(i).{ clauseCount.(i) }.0: i * (numClauses / numClasses) + j
                if j rem 2 = 0
                    set clauseSign.(i).(clauseCount.(i)).1: 1
                else
                    set clauseSign.(i).(clauseCount.(i)).1: -1
                set clauseCount.(i): _ + 1
    
    action: (state) -> if state <= numStates then 0 else 1
    
    calcClauseOutput: (X, predict) *->
        if not predict or predict is #none then set predict: 0
    
        loop 0 ..< numClauses as j
            set clauseOutput.(j): 1
            let allExclude: 1
            loop 0 ..< numFeatures as k
                actionInclude: action taState.(j).(k).0
                actionIncludeNeg: action taState.(j).(k).1
                if actionInclude = 1 or actionIncludeNeg = 1
                    set allExclude: 0
                if (actionInclude = 1 and X.(k) = 0) or (actionIncludeNeg = 1 and X.(k) = 1)
                    set clauseOutput.(j): 0
                    break
            if predict = 1 and allExclude = 1
                set clauseOutput.(j): 0
    
    sumUpClassVotes: () *->
        loop 0 ..< numClasses as targetClass
            set classSum.(targetClass): 0
            loop 0 ..< clauseCount.(targetClass) as j
                set classSum.(targetClass): _ + clauseOutput.{ clauseSign.(targetClass).(j).0 } * clauseSign.(targetClass).(j).1
                if classSum.(targetClass) > threshold
                    set classSum.(targetClass): threshold
                else if classSum.(targetClass) < -threshold
                    set classSum.(targetClass): -threshold
    
    predict: (X) ->
        calcClauseOutput(X, 1)
        sumUpClassVotes()
        let maxClassSum: classSum.0
        let maxClass: 0
        loop 1 ..< numClasses as targetClass
            if maxClassSum < classSum.(targetClass)
                set maxClassSum: classSum.(targetClass)
                set maxClass: targetClass
        maxClass
    
    update: (X, targetClass) *->
        -- Randomly pick one of the other classes, for pairwise learning of class output
        let negativeTargetClass: floor(numClasses * (1.0 - 1e-15) * random())
        while negativeTargetClass = targetClass
            set negativeTargetClass: floor(numClasses * (1.0 - 1e-15) * random())
        -- Calculate Clause Output
        calcClauseOutput(X)
        -- sum up clause votes
        sumUpClassVotes()
        -- calculate Feedback to Clauses
        
        loop 0 ..< numClauses as j  --  init feedback to clauses
            set feedBackToClauses.(j): 0
    
        loop 0 ..< clauseCount.(targetClass) as j
            if random() > (1.0 / threshold * 2) * (threshold - classSum.(targetClass))
                continue
    
            if clauseSign.(targetClass).(j).1 > 0
                increment feedBackToClauses.{ clauseSign.(targetClass).(j).0 }
            else if clauseSign.(targetClass).(j).1 < 0
                decrement feedBackToClauses.{ clauseSign.(targetClass).(j).0 }
    
        loop 0 ..< clauseCount.(negativeTargetClass) as j
            if random() > (1.0 / threshold * 2) * (threshold + classSum.(negativeTargetClass))
                continue
    
            if clauseSign.(negativeTargetClass).(j).1 > 0
                decrement feedBackToClauses.{ clauseSign.(negativeTargetClass).(j).0 }
            else if clauseSign.(negativeTargetClass).(j).1 < 0)
                increment feedBackToClauses.{ clauseSign.(negativeTargetClass).(j).0 }
    
        -- Train individual Automata
        loop 0 ..< numClauses as j
            if feedBackToClauses.(j) > 0
                -- Type I Feedback (Combats False Negatives)
                if clauseOutput.(j) = 0
                    loop 0 ..< numFeatures as k
                        if random() <= 1.0 / s
                            if taState.(j).(k).0 > 1
                                decrement taState.(j).(k).0
                        if random() <= 1.0 / s
                            if taState.(j).(k).1 > 1
                                decrement taState.(j).(k).1
                else if clauseOutput.(j) = 1
                    loop 0 ..< numFeatures as k
                        if X.(k) = 1
                            if random() <= (s - 1) / s
                                if taState.(j).(k).0 < numStates * 2
                                    increment taState.(j).(k).0
                            if random() <= 1.0 / s
                                if taState.(j).(k).1 > 1
                                    decrement taState.(j).(k).1
                        else if X.(k) = 0
                            if random() <= (s - 1) / s
                                if taState.(j).(k).1 < numStates * 2
                                    increment taState.(j).(k).1
                            if random() <= 1.0 / s
                                if taState.(j).(k).0 > 1
                                    decrement taState.(j).(k).0
            else if feedBackToClauses.(j) < 0) 
                --  Type II Feedback (Combats False Positives)
                if clauseOutput.(j) = 1
                    loop 0 ..< numFeatures as k
                        let actionInclude: action taState.(j).(k).0
                        let actionIncludeNegated: action taState.(j).(k).1
                        if X.(k) = 0
                            if actionInclude = 0 and taState.(j).(k).0 < numStates * 2
                                increment taState.(j).(k).0
                        else if X.(k) = 1
                            if actionIncludeNegated = 0 and taState.(j).(k).1 < numStates * 2
                                increment taState.(j).(k).1
    
    evaluate: (X, y) ->
        let errors: 0
        loop 0 ..< X.length as l
            if predict X[l] /= y[l] then increment errors
        1.0 - errors / X.length
    
    initTaState()
    initClauseSigns()
    initClauseCount()
    
    [ predict, update, evaluate ]
    
[ new-machine ]
