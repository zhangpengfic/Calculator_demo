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
    private var operations:Dictionary<String,Operation> =  [
        "∏":Operation.Constant(M_PI),
        "℮":Operation.Constant(M_E),
        "√":Operation.UnaryOperation(sqrt),
        "cos":Operation.UnaryOperation(cos),
        "×":Operation.BinaryOperation{$0*$1},
        "÷":Operation.BinaryOperation{$0/$1},
        "+":Operation.BinaryOperation{$0+$1},
        "−":Operation.BinaryOperation{$0-$1},
        "=":Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation(Double->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol:String) {
        if let constant = operations[symbol] {
            switch constant {
            case.Constant(let value):accumulater = value
            case.UnaryOperation(let function):accumulater = function(accumulater)
            case.BinaryOperation(let BinaryFunc):
                exeutePendingBinaryOperation()
                pending = PendingBinaryOperationInfo.init(binaryFunction: BinaryFunc, fristOperand: accumulater)
            case.Equals:
                exeutePendingBinaryOperation()
                
            }
        }
    }
    
    private func exeutePendingBinaryOperation(){
        if pending != nil {
            accumulater = pending!.binaryFunction(pending!.fristOperand, accumulater)
        }
    }
    
    
    private var pending:PendingBinaryOperationInfo?
    struct PendingBinaryOperationInfo {
        var binaryFunction:(Double,Double)->Double
        var fristOperand:Double
    }
    
    var result:Double{
        get{
            return accumulater
        }
    }
        
}