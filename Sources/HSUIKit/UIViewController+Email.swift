//
//  UIViewController+Alert.swift
//  VLCStreamer2
//
//  Created by Rob Jonson on 09/09/2019.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)


import Foundation
import UIKit
import MessageUI

public struct EmailAttachment {
    public let data:Data
    public let mimeType:String
    public let fileName:String
}

public protocol CanSendEmail:MFMailComposeViewControllerDelegate {
    func sendEmail(to:[String],subject:String,body:String, isHtml:Bool);
    func sendEmail(to:[String],subject:String,body:String, isHtml:Bool,attachments:[EmailAttachment]);
}

public extension CanSendEmail where Self: UIViewController {
    
    @available(iOS 10.0, *)
    func sendByURL(to:[String],subject:String,body:String, isHtml:Bool,attachments:[EmailAttachment]) -> Bool {
        
        if attachments.count != 0 {
            return false
        }
        
        var txtBody = body
        if isHtml {
            txtBody = body.replacingOccurrences(of: "<br />", with: "\n")
            txtBody = txtBody.replacingOccurrences(of: "<br/>", with: "\n")
            if txtBody.contains("/>") {
                print("Can't send html email with url interface")
                return false
            }
        }

        let toJoined = to.joined(separator: ",")
        guard var feedbackUrl = URLComponents.init(string: "mailto:\(toJoined)") else {
            return false
        }
            
            

        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem.init(name: "SUBJECT", value: subject))
        queryItems.append(URLQueryItem.init(name: "BODY",
                                            value: txtBody))
        feedbackUrl.queryItems = queryItems
        
        if let url = feedbackUrl.url {
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
                return true
            }
        }
        
        return false
     
    }
    
    func sendEmail(to:[String],subject:String,body:String, isHtml:Bool = false,attachments:[EmailAttachment]) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(to)
            mail.setMessageBody(body, isHTML: isHtml)
            mail.setSubject(subject)
            
            for attachment in attachments {
                mail.addAttachmentData(attachment.data,
                                       mimeType: attachment.mimeType,
                                       fileName: attachment.fileName)
            }
            
            present(mail, animated: true)
        } else {
            #if targetEnvironment(macCatalyst)
            let ableToSendByURL = sendByURL(to: to,
                                            subject: subject,
                                            body: body,
                                            isHtml: isHtml,
                                            attachments: attachments)
            #else
            let ableToSendByURL = false
            #endif

            if !ableToSendByURL {
                self.showAlert(title: "Doh! - Unable to send email", message: "Please check that the mail app is setup properly")
            }
            
            
            // show failure alert
        }
    }
    
    func sendEmail(to:[String],subject:String,body:String, isHtml:Bool = false) {
        sendEmail(to: to,
                  subject: subject,
                  body: body,
                  isHtml: isHtml,
                  attachments: [])
    }
}

//Annoyingly, this can't be in the extension as it needs to be an @ObjC method
extension UIViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
            break
        case MFMailComposeResult.saved:
            print("Mail saved")
            break
        case MFMailComposeResult.sent:
            print("Mail sent")
            break
        case MFMailComposeResult.failed:
            print("Mail failed")
            break
        default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}

#endif
