//
//  CalcViewController.swift
//  Comparer
//
//  Created by Karol Cápay on 16/11/2018.
//  Copyright © 2018 Karol Cápay. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    let kW = ["W / hour", "W / day", "W / year", "kW / hour", "kW / day", "kW / year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kW.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kW[row]
    }
    
}
