//
//  DetailViewController.swift
//  Comparer
//
//  Created by Karol Cápay on 15/11/2018.
//  Copyright © 2018 Karol Cápay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  
    var placeholderLabel : UILabel!
    var pricePerkWh: Float  = 0.0488
    var consumption: Float = 0.00
    var price: Float? = 0.00
    var totalPrice: Float?  = 0.00
    var nameTextError: Bool = false
    var energyConsumptionError: Bool = false
    let lightColor:UIColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    let placeholder = "Description"

    public var product: Products?
    public var saved: Bool?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var withPrice: UISwitch!
    @IBOutlet weak var descriptText: UITextView!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var energyConsumption: UITextField!
    @IBOutlet weak var showPrice: UILabel!
    
    @IBAction func saveIt(_ sender: Any) {
        let validName = validation(myTextField: nameText)
        let validEnergy = validation(myTextField: energyConsumption)
        if (validName && validEnergy) {
            product!.name = nameText.text
            product!.consumption = NumberFormatter().number(from: energyConsumption.text!)!.floatValue
            product!.price = NumberFormatter().number(from: productPrice.text!)!.floatValue
            product?.descript = descriptText.text
            saved = true
            performSegue(withIdentifier: "unwindFromProductDetail", sender: nil)
        }
    }

        
    @IBAction func nameTextChange(_ sender: Any) {
        if nameText.layer.borderColor == UIColor.red.cgColor {
            changeState(myTextField: nameText, state: true)
        }
    }

    @IBAction func withPriceChange(_ sender: Any) {
        vypocitaj()
    }
    
    @IBAction func productPriceChange(_ sender: Any) {
        vypocitaj()
    }
    
    @IBAction func energyConsumptionChange(_ sender: Any) {
        if energyConsumption.layer.borderColor == UIColor.red.cgColor {
            changeState(myTextField: energyConsumption, state: true)
        }
        vypocitaj()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        vypocitaj()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = product!.name
        descriptText.text = product!.descript
        energyConsumption.text = String.localizedStringWithFormat("%.2f", product!.consumption)
        productPrice.text = String.localizedStringWithFormat("%.2f", product!.price)
        productPrice.delegate = self
        energyConsumption.delegate = self
        descriptText.layer.borderColor = lightColor.cgColor
        descriptText.layer.borderWidth = 0.5
        descriptText.layer.cornerRadius = 5.0
        descriptText.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = self.placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 14.0)
        placeholderLabel.sizeToFit()
        descriptText.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (descriptText.font?.pointSize)! / 2)
        placeholderLabel.textColor = lightColor
        placeholderLabel.isHidden = !descriptText.text.isEmpty
        vypocitaj()
    }

    func vypocitaj() {
        let period:Int = Int(mySlider.value)
        consumption = (energyConsumption.text! as NSString).floatValue
        price = (productPrice.text! as NSString).floatValue
        labelYear.text = "\(period)"
        let tempPrice = (withPrice.isOn) ? price : 0
        showPrice.text =  "\(Int(((consumption * pricePerkWh) * Float(period)) + tempPrice!))"
    }
    
    func changeState(myTextField: UITextField, state: Bool) {
        let myColor = state ? lightColor : UIColor.red
        myTextField.layer.borderColor = myColor.cgColor
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.cornerRadius = 5.0
        myTextField.attributedPlaceholder = NSAttributedString(string: myTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : myColor])
    }
    
    func validation(myTextField: UITextField) -> Bool {
        guard let text = myTextField.text, !text.isEmpty else {
            changeState(myTextField: myTextField, state: false)
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789,.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}
