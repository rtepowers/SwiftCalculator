//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Raymond Powers on 6/22/15.
//  Copyright (c) 2015 RayPowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	@IBOutlet weak var display: UILabel!
	
	var isCurrentlyEntering: Bool = false

	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		if (isCurrentlyEntering) {
			display.text = display.text! + digit
		} else {
			display.text = digit
			isCurrentlyEntering = true
		}
	}
	
	var operandStack = Array<Double>()
	
	@IBAction func enter() {
		isCurrentlyEntering = false
		operandStack.append(displayValue)
		println("operandStack = \(operandStack)")
	}
	
	var displayValue: Double {
		get {
			return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
		}
		set {
			display.text = "\(newValue)"
			isCurrentlyEntering = false
		}
	}
	
	private func performOperation(operation: Double -> Double) {
		if operandStack.count >= 1 {
			displayValue = operation(operandStack.removeLast())
			enter()
		}
	}
	
	func performOperation(operation: (Double, Double) -> Double) {
		if operandStack.count >= 2 {
			displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
			enter()
		}
	}
	
	@IBAction func operation(sender: UIButton) {
		let operation = sender.currentTitle!
		if (isCurrentlyEntering) {
			enter()
		}
		switch operation {
		case "+": performOperation { $0 + $1 }
		case "-": performOperation { $1 - $0 }
		case "÷": performOperation { $1 / $0 }
		case "✕": performOperation { $0 * $1 }
		case "√": performOperation { sqrt($0) }
		default: break
		}
	}
	
}

