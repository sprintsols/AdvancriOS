//
//  BankAccountVC.swift
//  Advancr
//
//  Created by Zain Ali on 02/07/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit
import QuickLook

class LoanAgreementVC: UIViewController
{
    @IBOutlet weak var txtAgreement:UITextView!
    @IBOutlet weak var popupView:UIView!
    
    var email = ""
    
    override func viewDidLoad()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: Date())
        
        let payeeName = "Payee"
        let amount = String(format: "%@%@", loanObject.currency, loanObject.loanAmount)
        let time = String(format: "%@ %@", loanObject.counter, loanObject.calendarType)
        
        txtAgreement.text = String(format: "This agreement confirms %@ has made a loan payment of %@ to %@ on %@\n\n%@ agrees to repay %@ within the period of %@.\n\nIt is the sole responsibility of %@ to schedule repayment in accordance of this loan agreement. %@ acknowledges that full repayment including interest or late fees is paid in full on time to %@.\n\nFailure to repay the loan in full to %@ could result in a claim being brought against %@ in a court of law.\n\nAdvancr act only as an intermediary in this process and hold no legal responsibility for the repayment of the loan. This falls directly and soley with %@", email, amount, payeeName, date, payeeName, amount, time, payeeName, payeeName, email, email, payeeName, payeeName)
        
        generatePDF()

    }
    
    func generatePDF()
    {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (documentsDirectory as NSString).appendingPathComponent("LoanAgreement.pdf") as String
        print(filePath)
        let pdfTitle = "Advancr Loan Agreement"
        let pdfMetadata = [
            kCGPDFContextCreator: "Advancr",
            kCGPDFContextAuthor: "Advancr",
            kCGPDFContextTitle: "Advancr Loan Agreement"
        ]
        
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)

        UIGraphicsBeginPDFPage()

        let pageSize = UIGraphicsGetPDFContextBounds().size
        
        //Draw PDF title
        var font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let attributedPDFTitle = NSAttributedString(string: pdfTitle, attributes: [NSAttributedString.Key.font: font])
        let titleSize = attributedPDFTitle.size()
        let titleRect = CGRect(x: (pageSize.width / 2 - titleSize.width / 2), y: 30, width: titleSize.width, height: titleSize.height)
        attributedPDFTitle.draw(in: titleRect)
        
        //Draw PDF content
        let pdfText = txtAgreement.text!
        font = UIFont.systemFont(ofSize: 13)
        let attributedPDFText = NSAttributedString(string: pdfText, attributes: [NSAttributedString.Key.font: font])
        let textRect = CGRect(x: 50, y: 70, width: 500, height: 300)
        attributedPDFText.draw(in: textRect)

        UIGraphicsEndPDFContext()
    }
    
    @IBAction func cardBtnAction(_ button: UIButton)
    {
        
    }
    
    @IBAction func shareBtnAction(_ button: UIButton)
    {
        let fileManager = FileManager.default
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentoPath = (documentsDirectory as NSString).appendingPathComponent("LoanAgreement.pdf")

        if fileManager.fileExists(atPath: documentoPath)
        {
            let documento = NSData(contentsOfFile: documentoPath)
            //             let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: ["",documento!], applicationActivities: nil)
            //             activityViewController.popoverPresentationController?.sourceView = self.view
            //             present(activityViewController, animated: true, completion: nil)

            let objectsToShare = ["Loan agreement", documento!] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        else
        {
            print("document was not found")
        }
    }
    
    @IBAction func printBtnAction(_ button: UIButton)
    {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
    
    @IBAction func nextBtnAction(_ button: UIButton)
    {
        popupView.alpha = 1
    }
    
    @IBAction func crossBtnAction(_ button: UIButton)
    {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension LoanAgreementVC : QLPreviewControllerDelegate , QLPreviewControllerDataSource
{
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int
    {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem
    {
         let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
         let documentoPath = (documentsDirectory as NSString).appendingPathComponent("LoanAgreement.pdf")
         let path:URL = URL(fileURLWithPath: documentoPath)
        return path as QLPreviewItem
    }

    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool
    {
        return true
    }
}
