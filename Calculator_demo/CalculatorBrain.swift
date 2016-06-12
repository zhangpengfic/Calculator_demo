//
//  CalculatorBrain.swift
//  Calculator_demo
//
//  Created by Alfred on 16/6/1.
//  Copyright © 2016年 Alfredhome. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    enum Op : CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double,Double)->Double)
        
        var description:String {
            get{
                switch self {
                case .Operand(let Operand):
                    return "\(Operand)"
                case .UnaryOperation(let Symbol, _):
                    return Symbol
                case .BinaryOperation(let Symbol, _):
                    return Symbol
                }
            }
        }
        
    }
    
    var opStack=[Op]();
    var knownOps = [String:Op]()
    
    init(){
        func learnOp(Ops : Op){
            knownOps[Ops.description]=Ops
        }
        learnOp(Op.BinaryOperation("×", *))
//        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷"){$1/$0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−"){$1-$0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    
    func evaluate(ops:[Op]) -> (result:Double?, remainingOps:[Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand , remainingOps)
            case .UnaryOperation(_, let operation1):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation1(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_,let operation2):
                let operandEvalution1 = evaluate(remainingOps)
                if let operand1 = operandEvalution1.result{
                    let operandEvalution2 = evaluate(operandEvalution1.remainingOps)
                    if let operand2 = operandEvalution2.result {
                        return (operation2(operand1,operand2), operandEvalution2.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double? {
        let (result,remaining)=evaluate(opStack)
        print("\(opStack) = \(result) with \(remaining)left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    
    func performOperation(symbol:String) -> Double? {
        if let operation = knownOps[symbol] {
        opStack.append(operation)
        }
        return evaluate()
    }
    
}