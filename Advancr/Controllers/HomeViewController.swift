//
//  HomeViewController.swift
//  Advancr
//
//  Created by Zain Ali on 02/04/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit
import Toast_Swift

class HomeViewController: UIViewController
{
    override func viewDidLoad() {
        
    }
    
    @IBAction func loanBtnAction(_ button: UIButton)
    {
        let nextVC:UIViewController!
        if button.tag == 1001
        {
            nextVC = self.storyboard!.instantiateViewController(withIdentifier: "GiveLoanVC") as! GiveLoanVC
        }
        else
        {
            nextVC = self.storyboard!.instantiateViewController(withIdentifier: "GetLoanVC") as! GetLoanVC
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
