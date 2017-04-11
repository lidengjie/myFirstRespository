//
//  ViewController.swift
//  500
//
//  Created by BraveSoft on 16/10/27.
//  Copyright © 2016年 lidengjie. All rights reserved.
//

import UIKit
import Photos
import LocalAuthentication

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct ValueStack<Element> : Container {
    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop(item: Element) {
        items.removeLast()
    }
    
    typealias ItemType = Element
    var count: Int {
        return items.count
    }
    
    mutating internal func append(item: Element) {
        return self.push(item: item)
    }
    
    internal subscript(i: Int) -> Element {
        return items[i]
    }

}

class ViewController: UIViewController {

    @IBOutlet var numberLabels: [UILabel]!
    @IBOutlet weak var numberLabel: UILabel!
    private var numbers:[NSInteger] = [NSInteger]()
    private var blueNumbers:[NSInteger] = [NSInteger]()
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    private var imageLocalIdentifier: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var stack = ValueStack<String>()
        stack.push(item: "hello")
        stack.push(item: " ")
        stack.push(item: "world")
        stack.push(item: "!")
        print(stack.items)
//        var oneNum = 2
//        var towNum = 3
//        print(oneNum, towNum)
//        swapTwoValus(&oneNum, &towNum)
//        print(oneNum, towNum)
//        
//        var someString = "hello"
//        var anotherString = "world"
//        print(someString, anotherString)
//        swapTwoValus(&someString, &anotherString)
//        print(someString, anotherString)
//
//        someString.substring(to: someString.index(someString.startIndex, offsetBy: 100))
//        
//        var someDouble = 2.22
//        var anotherDouble = 3.33
//        print(someDouble, anotherDouble)
//        swap(&someDouble, &anotherDouble)
//        print(someDouble, anotherDouble)
        
        
//        navigationController?.navigationBar.barTintColor = UIColor.blue
//        view.backgroundColor = UIColor.red
//        for i in 1...32 {
//            numbers.append(i)
//            if i <= 16 {
//                blueNumbers.append(i)
//            }
//        }
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
//        print(a, b)
        let temporaryA = a
        a = b
        b = temporaryA
//        print(a, b)
    }
    
    func swapTowStrings(_ a: inout String, _ b: inout String) {
        
    }
    
    func swapTwoValus<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func startAction(_ sender: AnyObject) {
        authLocal()
        return
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
//        present(vc, animated: true, completion: nil)
        var selectedNumbers:[NSInteger] = []
        startBtn.isEnabled = false
        for _ in 0...5 {
            let number = getTheNumber(numbers: numbers);
            numbers.remove(at: numbers.index(of: number)!)
            selectedNumbers.append(number)
        }
        selectedNumbers.sort()
        showNumbers(numbers: selectedNumbers)
        showTimeLabel()
    }
    
    @IBAction func resetAction(_ sender: AnyObject) {
        for label in numberLabels {
            label.text = ""
        }
        numberLabel.text = ""
        timeLabel.text = ""
        startBtn.isEnabled = true
    }
    
    private func getTheNumber(numbers:[NSInteger]) -> NSInteger {
        var result = 0
        let count = UInt32(numbers.count)
        let index = arc4random()%count
        result = numbers[Int(index)];
        return result
    }
    
    private func showNumbers(numbers:[NSInteger]) {
        for index in 0...5 {
            numberLabels[index].text = String(numbers[index])
        }
        let number = getTheNumber(numbers: blueNumbers);
        numberLabel.text = String(number)
    }
    
    private func showTimeLabel() {
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = dateFormatter.string(from: time)
        timeLabel.text = timeString
    }
    
    //指纹解锁
    private func authLocal() {
        let content = LAContext()
        var error: NSError?
        
        if content.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            content.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "需要指纹解锁你的设备！", reply: { (success: Bool, error: Error?) in
                if success {
                    print("验证成功！")
                    DispatchQueue.main.async {
                        
                    }
                }else {
                    let err = error as? NSError
                    print(error)
                    switch err?.code {
                    case LAError.authenticationFailed.rawValue?:
                        print("授权失败")
                    case LAError.userCancel.rawValue?:
                        print("用户取消")
                    case LAError.userFallback.rawValue?:
                        print("用户点击 输入密码，切换主线程处理")
                    case LAError.systemCancel.rawValue?:
                        print("切换到其他APP，系统取消验证Touch ID")
                    case LAError.passcodeNotSet.rawValue?:
                        print("系统未设置密码")
                    case LAError.touchIDNotAvailable.rawValue?:
                        print("设备Touch ID不可用，例如未打开")
                    case LAError.touchIDNotEnrolled.rawValue?:
                        print("设备Touch ID不可用，用户未录入")
                    case LAError.touchIDLockout.rawValue?:
                        print("Touch ID输入错误多次，已被锁")
                    case LAError.appCancel.rawValue?:
                        print("用户除外的APP挂起，如电话接入等切换到了其他APP")
                    default:
                        print("其他情况")
                    }
                }
            })
        }
    }
}


