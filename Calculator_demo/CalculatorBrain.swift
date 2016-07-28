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
    var operations:Dictionary<String,Double> =  [
        "℮":M_E
    ]
    
    func performOperation(symbol:String) {
        if let constant = operations[symbol] {
            accumulater = constant
        }
    }
    var result:Double{
        get{
            return accumulater
        }
    }
        
}