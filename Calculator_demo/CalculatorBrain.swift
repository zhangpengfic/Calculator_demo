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
    
    func performOperation(symbol:String) {
        switch symbol {
        case "℮":accumulater = M_E
        case "√":accumulater=sqrt(accumulater)
        default:break
        }
    }
    var result:Double{
        get{
            return accumulater
        }
    }
        
}