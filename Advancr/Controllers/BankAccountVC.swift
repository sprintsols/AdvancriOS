//
//  BankAccountVC.swift
//  Advancr
//
//  Created by Zain Ali on 02/07/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit


class BankAccountVC: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtDetail:UITextField!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtSortCode:UITextField!
    @IBOutlet weak var txtPostCode:UITextField!
    @IBOutlet weak var txtAccount:UITextField!
    @IBOutlet weak var txtHouse:UITextField!
    
    override func viewDidLoad()
    {
        
    }
    
    @IBAction func backBtnAction(_ button: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ button: UIButton)
    {
        if verifyFields()
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func verifyFields()-> Bool
    {
        var flag = true
        
        if txtAccount.text!.isEmpty || txtName.text!.isEmpty || txtSortCode.text!.isEmpty || txtPostCode.text!.isEmpty || txtAccount.text!.isEmpty || txtHouse.text!.isEmpty
        {
            flag = false
            let windowCount = UIApplication.shared.windows.count
            UIApplication.shared.windows[windowCount-1].makeToast("Please fillup all the fields.")
        }
        
        return flag
    }
    
    func hideKeyPad()
    {
        txtDetail.resignFirstResponder()
        txtName.resignFirstResponder()
        txtSortCode.resignFirstResponder()
        txtPostCode.resignFirstResponder()
        txtAccount.resignFirstResponder()
        txtHouse.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        if textField == txtDetail
        {
            txtName.becomeFirstResponder()
        }
        else if textField == txtName
        {
            txtSortCode.becomeFirstResponder()
        }
        else if textField == txtAccount
        {
            txtHouse.becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == txtSortCode
        {
            textField.tag = 1001
            addToolBar(textField: textField)
        }
        else if textField == txtPostCode
        {
            textField.tag = 1002
            addToolBar(textField: textField)
        }
    }
    
    func addToolBar(textField: UITextField)
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 42/255, green: 113/255, blue: 158/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneBtnAction(button:)))
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
        if button.tag == 1001
        {
            txtPostCode.becomeFirstResponder()
        }
        else if button.tag == 1002
        {
            txtAccount.becomeFirstResponder()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideKeyPad()
    }
}
