//
//  ViewController.swift
//  Calculator_demo
//
//  Created by Alfred on 16/5/27.
//  Copyright © 2016年 Alfredhome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber : Bool = false
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text=display.text!+digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber=true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "+": performOperation(add)
        case "−":performOperation({(op1:Double,op2:Double)->Double in
            return op2-op1
            }
)
            
        case "×": performOperation({op1,op2 in op1 * op2})
        case "÷": performOperation{$1 / $0}
        case "√": performOperation2({op1 in return sqrt(op1)})
        default:
            break
        }
        
    }
    
    func add(op1:Double,op2:Double)->Double {
        return op1+op2
    }
    
    func performOperation(operation:(Double,Double)->(Double)) {
        if operandStack.count>=2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
        }
        enter()
        
    }
    func performOperation2(operation:Double->Double) {
        if operandStack.count>=1{
            displayValue = operation(operandStack.removeLast())
        }
        enter()
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack\(operandStack)")
    }
    
    var displayValue : Double {
        get{
            return (NSNumberFormatter().numberFromString(display.text!)!.doubleValue)
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber=false
        }
    }
    
    
}

