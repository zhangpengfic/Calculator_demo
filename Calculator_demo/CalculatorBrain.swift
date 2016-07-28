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
        "∏":Operation.Constant(M_PI),
        "℮":Operation.Constant(M_E),
        "√":Operation.UnaryOperation(sqrt),
        "cos":Operation.UnaryOperation(cos)
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation(Double->Double)
        case BinaryOperation
        case Equals
    }
    
    func performOperation(symbol:String) {
        if let constant = operations[symbol] {
            switch constant {
            case.Constant(let value):accumulater = value
            case.UnaryOperation(let function):accumulater = function(accumulater)
            case.BinaryOperation:break
            case.Equals:break
            }
            
        }
    }
    var result:Double{
        get{
            return accumulater
        }
    }
        
}