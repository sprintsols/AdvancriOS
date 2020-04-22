//
//  GetLoanVC.swift
//  Advancr
//
//  Created by Zain Ali on 02/04/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit
import DropDown
import MBProgressHUD
import Social

var loanObject:LoanObject!

class GetLoanVC: UIViewController, UITextFieldDelegate, UITextViewDelegate
{
    @IBOutlet weak var contentView:UIView!
    
    @IBOutlet weak var lblNumber1:UILabel!
    @IBOutlet weak var lblNumber2:UILabel!
    @IBOutlet weak var lblNumber3:UILabel!
    @IBOutlet weak var lblText1:UILabel!
    @IBOutlet weak var lblText2:UILabel!
    @IBOutlet weak var lblText3:UILabel!
    @IBOutlet weak var btn1:UIButton!
    @IBOutlet weak var btn2:UIButton!
    @IBOutlet weak var btn3:UIButton!
    
    @IBOutlet weak var view1:UIView!
    @IBOutlet weak var view2:UIView!
    @IBOutlet weak var view3:UIView!
    
    //View1 Controls
    @IBOutlet weak var txtAmount:UITextField!
    @IBOutlet weak var lblCurrency:UILabel!
    @IBOutlet weak var dropDownView:UIView!
    @IBOutlet weak var txtWeeks:UITextField!
    @IBOutlet weak var lblWeeks:UILabel!
    @IBOutlet weak var repayImgView:UIImageView!
    @IBOutlet weak var percentageImgView:UIImageView!
    @IBOutlet weak var txtMessage:UITextView!
    
    @IBOutlet weak var topConstraint:NSLayoutConstraint!
    
    //View2 Controls
    @IBOutlet weak var txtPolicy:UITextView!
    @IBOutlet weak var txtAccount:UITextField!
    
    //View3 Controls
    @IBOutlet weak var lblCode:UILabel!
    
    @IBOutlet weak var nextBtn:UIButton!
    @IBOutlet weak var backBtn:UIButton!
    
    let dropDown = DropDown()
    
    override func viewDidLoad()
    {
        loanObject = LoanObject()
        loanObject.repayType = 2
        loanObject.interestRate = 5
        loanObject.calendarType = "Weeks"
        dropDown.anchorView = dropDownView

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")

            if self.dropDown.tag == 1001
            {
                loanObject.currency = item
                self.lblCurrency.text = item
            }
            else
            {
                loanObject.calendarType = item
                self.lblWeeks.text = item
            }
        }
        
        
        btn1.layer.cornerRadius = 8
        btn1.layer.maskedCorners = [.layerMinXMinYCorner]
        btn1.layer.masksToBounds = true
        
        btn3.layer.cornerRadius = 8
        btn3.layer.maskedCorners = [.layerMaxXMinYCorner]
        btn3.layer.masksToBounds = true
        
        lblNumber1.cornerRadius(radius: 8.5)
        lblNumber2.cornerRadius(radius: 8.5)
        lblNumber3.cornerRadius(radius: 8.5)
    }
    
    func changeControls()
    {
        btn1.backgroundColor = .clear
        btn2.backgroundColor = .clear
        btn3.backgroundColor = .clear
        
        lblNumber1.backgroundColor = UIColor(red: 204.0/255.0, green: 205.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        lblNumber2.backgroundColor = UIColor(red: 204.0/255.0, green: 205.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        lblNumber3.backgroundColor = UIColor(red: 204.0/255.0, green: 205.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        
        let textColor:UIColor = UIColor(red: 113.0/255.0, green: 117.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        lblNumber1.textColor = textColor
        lblNumber2.textColor = textColor
        lblNumber3.textColor = textColor
        
        lblText1.textColor = textColor
        lblText2.textColor = textColor
        lblText3.textColor = textColor
        
        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 0
    }
    
    @IBAction func backBtnAction(_ button: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewsBtnAction(_ button: UIButton)
    {
        let color:UIColor = UIColor(red: 11.0/255.0, green: 98.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        
        if button.tag == 1001
        {
            hideKeyPad()
            changeControls()
            button.backgroundColor = UIColor(red: 219.0/255.0, green: 236.0/255.0, blue: 246.0/255.0, alpha: 1.0)
            
            lblNumber1.backgroundColor = color
            lblNumber1.textColor = .white
            lblText1.textColor = color
            
            view1.alpha = 1
        }
        else if button.tag == 1002
        {
            let windowCount = UIApplication.shared.windows.count
            
            if txtAmount.text!.isEmpty
            {
                UIApplication.shared.windows[windowCount-1].makeToast("Please enter loan amount.")
            }
            else if loanObject.currency.isEmpty
            {
                UIApplication.shared.windows[windowCount-1].makeToast("Please select currency.")
            }
            else if txtWeeks.text!.isEmpty
            {
                UIApplication.shared.windows[windowCount-1].makeToast(String(format: "Please enter number of %@.", lblWeeks.text!))
            }
            else
            {
                loanObject.message = txtMessage.text
                loanObject.loanAmount = txtAmount.text ?? "0"
                loanObject.counter = txtWeeks.text ?? "0"
                
                hideKeyPad()
                changeControls()
                button.backgroundColor = UIColor(red: 219.0/255.0, green: 236.0/255.0, blue: 246.0/255.0, alpha: 1.0)
                
                lblNumber2.backgroundColor = color
                lblNumber2.textColor = .white
                lblText2.textColor = color
                
                view2.alpha = 1
            }
        }
    }
    
    @IBAction func pickerBtnAction(_ button: UIButton)
    {
        hideKeyPad()
        dropDown.tag = button.tag
        if button.tag == 1001
        {
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 2)
            dropDown.dataSource = ["$", "£", "BTN", "€", "∞", "¢"]
            dropDown.show()
        }
        else if button.tag == 1002
        {
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 90)
            dropDown.dataSource = ["Weeks", "Months", "Years"]
            dropDown.show()
        }
    }
    
    @IBAction func repayBtnAction(_ button: UIButton)
    {
        hideKeyPad()
        
        var imgName = ""
        
        if button.tag == 1001
        {
            imgName = "installment-active"
            loanObject.repayType = 1
        }
        else if button.tag == 1002
        {
            imgName = "one-payment-active"
            loanObject.repayType = 2
        }
        
        repayImgView.image = UIImage(named: imgName)
    }
    
    @IBAction func interestBtnAction(_ button: UIButton)
    {
        hideKeyPad()
        
        var imgName = ""
        
        if button.tag == 1001
        {
            imgName = "5-active"
            loanObject.interestRate = 5
        }
        else if button.tag == 1002
        {
            imgName = "10-active"
            loanObject.interestRate = 10
        }
        else
        {
            imgName = "20-active"
            loanObject.interestRate = 15
        }
        
        percentageImgView.image = UIImage(named: imgName)
    }
    
    @IBAction func accountBtnAction(_ button: UIButton)
    {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "BankAccountVC") as! BankAccountVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func acceptRejectBtnAction(_ button: UIButton)
    {
        if button.tag == 1001
        {
            let alert = UIAlertController(title: nil , message: "Are you sure you want to reject?", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "YES" , style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
            
                alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action in
                }))

                self.present(alert, animated: true, completion: nil)
        }
        else
        {
            hideKeyPad()
            sendLoanDetail()
        }
    }
    
    @IBAction func nextBtnAction(_ button: UIButton)
    {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func shareBtnAction(_ button: UIButton)
    {
//        Personal message + You can download advancr here + AppLink +  using my pin
//        + Code generated
        
        let text = String(format: "%@ You can download advancr here https://itunes.apple.com using my pin %@", loanObject.message, lblCode.text!)
        
        if button.tag == 1001
        {
            let objectsToShare = [text]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            self.present(activityVC, animated: true, completion: nil)
        }
        else if button.tag == 1002
        {
            if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                vc.setInitialText(text)
                vc.add(URL(string: "https://itunes.apple.com"))
                present(vc, animated: true)
            }
        }
        else if button.tag == 1003
        {
            let urlString = String(format: "whatsapp://send?text=%@", text)
            var urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            let whatsappURL = URL(string: urlStringEncoded!)
            if (UIApplication.shared.canOpenURL(whatsappURL!)) {
                UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
            }
        }
        else if button.tag == 1004
        {
            let pasteboard = UIPasteboard.general
            pasteboard.string = lblCode.text!
            DispatchQueue.main.async {
                self.view.makeToast("Loan code is copied to clipboard.")
            }
        }
    }
    
    func sendLoanDetail()
    {
        DispatchQueue.main.async {
          MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        if Reachability.isConnectedToNetwork()
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            
            loanObject.createdDate = formatter.string(from: Date())
            
            let urlPath = String(format: "loan_amount=%@&date=%@&message=%@&interest_rate=%@&currency=%@&date_type=%@&date_type_count=%@", loanObject.loanAmount, loanObject.createdDate, loanObject.message, String(format:"%d", loanObject.interestRate), loanObject.currency, loanObject.calendarType, loanObject.counter)
            
            var request = URLRequest(url: URL(string: baseURL + "/addLoan?" + urlPath + String(format:"&repay_type=%d", loanObject.repayType))!)
            
            request.httpMethod = "POST"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in

                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                
                let responseString = String(data: data, encoding: .utf8)
                
                print(responseString)
                
                do
                {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {
                        let successCode = jsonResult["code"] as! Int
                        
                        if successCode == 101
                        {
                            DispatchQueue.main.async
                            {
                                let windowCount = UIApplication.shared.windows.count
                                UIApplication.shared.windows[windowCount-1].makeToast("Loan detail added successfully.")
                            
                                
                                self.lblCode.text = jsonResult["loan_code"] as? String
                            
                                self.changeControls()
                                
                                let color:UIColor = UIColor(red: 11.0/255.0, green: 98.0/255.0, blue: 216.0/255.0, alpha: 1.0)
                                
                                self.lblNumber3.backgroundColor = color
                                self.lblNumber3.textColor = .white
                                self.lblText3.textColor = color
                                self.btn3.backgroundColor = UIColor(red: 219.0/255.0, green: 236.0/255.0, blue: 246.0/255.0, alpha: 1.0)
                                
                                self.view3.alpha = 1
                                self.nextBtn.alpha = 1
                                self.backBtn.alpha = 0
                                self.btn1.isEnabled = false
                                self.btn2.isEnabled = false
                            }
                        }
                        else
                        {
                             DispatchQueue.main.async {
                                 self.view.makeToast("Something went wrong. Please try again.")
                             }
                         }
                    }
                }
               catch
               {
                    DispatchQueue.main.async {
                        self.view.makeToast("Something went wrong. Please try again.")
                    }
                }
            }

            task.resume()
        }
        else
        {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("You are not connected to internet. Please check Wifi or Data network.")
            }
        }
    }
    
    func hideKeyPad()
    {
        txtAmount.resignFirstResponder()
        txtWeeks.resignFirstResponder()
        txtMessage.resignFirstResponder()
        
        topConstraint.constant = 0
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        topConstraint.constant = -150
        
        UIView.animate(withDuration: 0.2) { [weak self] in
          self?.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideKeyPad()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        addToolBar(textField: textField)
    }
    
    func addToolBar(textField: UITextField)
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 42/255, green: 113/255, blue: 158/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneBtnAction(button:)))
        doneButton.tag = textField.tag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @IBAction func doneBtnAction(button: UIButton)
    {
        hideKeyPad()
    }
}

extension UILabel
{
    func cornerRadius(radius: CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
