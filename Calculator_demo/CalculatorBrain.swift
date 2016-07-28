//
//  CalculatorBrain.swift
//  Calculator_demo
//
//  Created by Alfred on 16/6/1.
//  Copyright © 2016年 Alfredhome. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulater = 0.0
    
    func setOperand(operand:Double){
        accumulater=operand
    }
    var operations:Dictionary<String,Operation> =  [
        "℮":Operation.Constant(M_E)
    ]
    
    enum Operation {
        case Constant(Double)
    }
    
    func performOperation(symbol:String) {
        if let constant = operations[symbol] {
            switch constant {
            case .Constant(let value):accumulater = value
            }
            
        }
    }
    var result:Double{
        get{
            return accumulater
        }
    }
        
}