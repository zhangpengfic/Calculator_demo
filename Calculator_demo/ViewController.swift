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
    
    var displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    var savedProgram : CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program=savedProgram!
            displayValue = brain.result
        }
    }
    
    
    var brain=CalculatorBrain()
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANumber {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingANumber=false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
        
    }
    
}

