//
//  GiveLoanVC.swift
//  Advancr
//
//  Created by Zain Ali on 02/04/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit
import MBProgressHUD
import PDFKit

class GiveLoanVC: UIViewController, UITextFieldDelegate
{
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
    @IBOutlet weak var txtCode:UITextField!
    @IBOutlet weak var txtWeeks:UITextField!
    @IBOutlet weak var txtPayee:UITextField!
    @IBOutlet weak var txtLoan:UITextField!
    @IBOutlet weak var lblWeeks:UILabel!
    @IBOutlet weak var repayImgView:UIImageView!
    
    //View2 Controls
    @IBOutlet weak var txtAmount:UITextField!
    @IBOutlet weak var txtPolicy:UITextView!
    
    //View3 Controls
    @IBOutlet weak var txtCard:UITextField!
    @IBOutlet weak var txtEmail:UITextField!
    
    override func viewDidLoad()
    {
        loanObject = LoanObject()
        
        txtCode.becomeFirstResponder()
        
        btn1.layer.cornerRadius = 8
        btn1.layer.maskedCorners = [.layerMinXMinYCorner]
        btn1.layer.masksToBounds = true
        
        btn3.layer.cornerRadius = 8
        btn3.layer.maskedCorners = [.layerMaxXMinYCorner]
        btn3.layer.masksToBounds = true
        
        lblNumber1.cornerRadius(radius: 8.5)
        lblNumber2.cornerRadius(radius: 8.5)
        lblNumber3.cornerRadius(radius: 8.5)
        
        btn2.isEnabled = false
        btn3.isEnabled = false
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
        hideKeyPad()
        changeControls()
        
        let color:UIColor = UIColor(red: 11.0/255.0, green: 98.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        
        if button.tag == 1001
        {
            lblNumber1.backgroundColor = color
            lblNumber1.textColor = .white
            lblText1.textColor = color
            
            view1.alpha = 1
        }
        else if button.tag == 1002
        {
            lblNumber2.backgroundColor = color
            lblNumber2.textColor = .white
            lblText2.textColor = color
            
            view2.alpha = 1
        }
        else
        {
            lblNumber3.backgroundColor = color
            lblNumber3.textColor = .white
            lblText3.textColor = color
            
            view3.alpha = 1
        }
        
        button.backgroundColor = UIColor(red: 219.0/255.0, green: 236.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }
    
    @IBAction func cardBtnAction(_ button: UIButton)
    {
        
    }
    
    @IBAction func agreementBtnAction(_ button: UIButton)
    {
        let windowCount = UIApplication.shared.windows.count
        
        if txtCard.text!.isEmpty
        {
            UIApplication.shared.windows[windowCount-1].makeToast("Please enter your debit card number")
        }
        else if txtEmail.text!.isEmpty
        {
            UIApplication.shared.windows[windowCount-1].makeToast("Please enter your email address")
        }
        else
        {
            let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "LoanAgreementVC") as! LoanAgreementVC
            nextVC.email = txtEmail.text!
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func getLoanDetail()
    {
        DispatchQueue.main.async {
          MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        if Reachability.isConnectedToNetwork()
        {
            var request = URLRequest(url: URL(string: String(format: "%@/getLoanDetail?loan_code=%@", baseURL, txtCode.text!))!)
            print(request)
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
                            let loanDict = jsonResult["loan_detail"] as! NSDictionary
                            
                            loanObject = LoanObject()
                            loanObject.loanAmount = loanDict["loan_amount"] as! String
                            loanObject.message = loanDict["message"] as? String ?? ""
                            loanObject.repayType = Int(loanDict["repay_type"] as! String)!
                            loanObject.interestRate = Int(Double(loanDict["interest_rate"] as! String)!)
                            loanObject.currency = loanDict["currency"] as! String
                            loanObject.calendarType = loanDict["date_type"] as! String
                            loanObject.counter = String(format: "%d", loanDict["date_type_count"] as! Int)
                            
                            let amount = Double(loanObject.loanAmount)!
                            let amountWithInterest = amount + (amount * Double(loanObject.interestRate))/100
                            
                            loanObject.loanAmount = String(format: "%.2f", amountWithInterest)
                            
                            DispatchQueue.main.async
                            {
                                self.txtLoan.text = String(format: "%@ %@", loanObject.currency, loanObject.loanAmount)
                                self.txtWeeks.text = loanObject.counter
                                self.lblWeeks.text = loanObject.calendarType
                                self.txtAmount.text = String(format: "%@ %@", loanObject.currency, loanObject.loanAmount)
                                
                                self.btn2.isEnabled = true
                                self.btn3.isEnabled = true
                                
                                if loanObject.repayType == 1
                                {
                                    self.repayImgView.image = UIImage(named: "one-payment")
                                }
                                else
                                {
                                    self.repayImgView.image = UIImage(named: "installments")
                                }
                            }
                        }
                        else
                        {
                            DispatchQueue.main.async {
                                self.view.makeToast("No record found.")
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
        txtCode.resignFirstResponder()
        txtCard.resignFirstResponder()
        txtEmail.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        getLoanDetail()
        
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideKeyPad()
    }
}
