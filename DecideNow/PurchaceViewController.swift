//
//  PurchaceViewController.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

class PurchaceViewController: UIViewController, UITextFieldDelegate {
    
    var nameForm: UITextField!
    var adressForm: UITextField!
    var creditForm: UITextField!
    var securityCodeForm: UITextField!
    var timer: Timer!
    var countdown: UIView!
    var timeLabel: UILabel!
    var count = 60
    var fromTop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Const.MAIN_BACKGROUND_COLOR
        
        self.view.addSubview(UIView.makeHeader())
        
        let name = UILabel.makeLabel(y: 80, text: "Name:")
        self.view.addSubview(name)
        
        nameForm = UITextField.makeNameForm(y: name.frame.maxY + 10)
        nameForm.delegate = self
        self.view.addSubview(nameForm)
        
        let adress = UILabel.makeLabel(y: nameForm.frame.maxY + 30, text: "Adress:")
        self.view.addSubview(adress)
        
        adressForm = UITextField.makeAdressForm(y: adress.frame.maxY + 10)
        adressForm.delegate = self
        self.view.addSubview(adressForm)
        
        let credit = UILabel.makeLabel(y: adressForm.frame.maxY + 30, text: "Credit Card Number:")
        self.view.addSubview(credit)
        
        creditForm = UITextField.makeCreditForm(y: credit.frame.maxY + 10)
        creditForm.delegate = self
        self.view.addSubview(creditForm)
        
        let security_code = UILabel.makeLabel(y: creditForm.frame.maxY + 30, text: "Security Code Number:")
        self.view.addSubview(security_code)
        
        securityCodeForm = UITextField.makeSecurityCodeForm(y: security_code.frame.maxY + 10)
        securityCodeForm.delegate = self
        self.view.addSubview(securityCodeForm)
        
        
        let footer = UIView.makeFooter()
        let cancel = UIButton.cancelButton(frame: CGRect(x: 32, y: 10, width: 100, height: 30))
        cancel.addTarget(self, action: #selector(self.canceling), for: .touchUpInside)
        footer.addSubview(cancel)
        
        let buy = UIButton.buyButton(frame: CGRect(x: Const.SCREEN_WIDTH - 32 - 100, y: 10, width: 100, height: 30))
        buy.addTarget(self, action: #selector(self.buyButton), for: .touchUpInside)
        footer.addSubview(buy)
        self.view.addSubview(footer)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        timeInit()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    func timeInit(){
        countdown = UIView.makeCountDownView(frame: CGRect(x: Const.SCREEN_WIDTH - 60, y: 72, width: 50, height: 50))
        self.view.addSubview(countdown)
        self.view.bringSubview(toFront: countdown)
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        timeLabel.text = "\(self.count)"
        timeLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.sizeToFit()
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.layer.position = countdown.center
        self.view.addSubview(timeLabel)
    }
    
    func updateTime(_ timer: Timer){
        self.count -= 1
        if self.count == 0{
            timer.invalidate()
            countdown.removeFromSuperview()
            timeLabel.removeFromSuperview()
            self.canceling()
        }else{
            timeLabel.text = "\(self.count)"
            timeLabel.font = UIFont.systemFont(ofSize: CGFloat(60 - CGFloat(self.count) * 2.5 / 6))
            timeLabel.sizeToFit()
            countdown.frame.size.width += 5 / 6
            countdown.frame.size.height += 5 / 6
            countdown.layer.cornerRadius += 2.5 / 6
            countdown.frame.origin.x -= 5 / 6
            countdown.frame.origin.y += 2.5 / 6
            timeLabel.layer.position = countdown.center
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if(nameForm.isFirstResponder){
            nameForm.resignFirstResponder()
        }
        if(adressForm.isFirstResponder){
            adressForm.resignFirstResponder()
        }
        if(creditForm.isFirstResponder){
            creditForm.resignFirstResponder()
        }
        if securityCodeForm.isFirstResponder {
            securityCodeForm.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func canceling(){
        if fromTop == true{
            Const.app.flag = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func buyButton(){
        if nameForm.text != "" && adressForm.text != "" && creditForm.text != "" && securityCodeForm.text != ""{
            let name = nameForm.text
            let adress = adressForm.text
            let credit =  Int(creditForm.text!)
            let security = Int(securityCodeForm.text!)
            Server.purchaces(name: name!, adress: adress!, credit_card: credit!, security_code: security!, completion: {response in
                
            })
        }else{
            self.present(UIAlertController.errorAlert(), animated: true, completion: nil)
        }
    }
}
