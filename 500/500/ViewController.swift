//
//  ViewController.swift
//  500
//
//  Created by BraveSoft on 16/10/27.
//  Copyright © 2016年 lidengjie. All rights reserved.
//

import UIKit
import Photos

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

        for i in 1...32 {
            numbers.append(i)
            if i <= 16 {
                blueNumbers.append(i)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func startAction(_ sender: AnyObject) {
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
}

