//
//  Models.swift
//  Advancr
//
//  Created by Zain Ali on 02/09/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import Foundation

class LoanObject: NSObject
{
    var loanAmount: String = ""
    var createdDate: String = ""
    var message: String = ""
    var repayType: Int = 0
    var interestRate: Int = 0
    var currency: String = ""
    var calendarType: String = ""
    var counter: String = ""
}


class BankDetail: NSObject
{
    var detail: String = ""
    var name: String = ""
    var sortCode: String = ""
    var postCode: String = ""
    var accountNbr: String = ""
    var house: String = ""
}
