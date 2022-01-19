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
    public init(data: Data, mimeType: String, fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }

    public let data: Data
    public let mimeType: String
    public let fileName: String
}

public protocol CanSendEmail: MFMailComposeViewControllerDelegate {
    func sendEmail(to: [String], subject: String, body: String, isHtml: Bool)
    func sendEmail(to: [String], subject: String, body: String, isHtml: Bool, attachments: [EmailAttachment])
}

public extension CanSendEmail where Self: UIViewController {

    /// Send using mailto
    /// - Parameters:
    ///   - to: array of emails
    ///   - subject: subject
    ///   - body: body
    ///   - isHtml: _extremely_ simple html support!
    ///   - attachments: attachments will cause this to fail. They're here to match the system-based call
    /// - Returns: success
    @available(iOS 10.0, *)
    func sendByURL(to: [String], subject: String, body: String, isHtml: Bool, attachments: [EmailAttachment] = []) -> Bool {

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
            // don't bother checking if we can open it.
            // that requires us to set LSApplicationQueries
            // even with no mail app and no default handler, opening mailto simply prompts to install mail app
            UIApplication.shared.open(url)
            return true
        }

        return false

    }

    /// Send email with system dialog if available, then with mailto
    /// - Parameters:
    ///   - to: array of emails
    ///   - subject: subject
    ///   - body: body
    ///   - isHtml: _extremely_ simple html support!
    ///   - attachments: attachments only work with the system email
    func sendEmail(to: [String], subject: String, body: String, isHtml: Bool = false, attachments: [EmailAttachment]) {

        if MFMailComposeViewController.canSendMail() {

            let mail = MFMailComposeViewControllerwDelegate()
            mail.mailComposeDelegate = mail
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

            var ableToSendByURL = false
            if #available(iOS 10.0, *) {
                ableToSendByURL = sendByURL(to: to,
                                            subject: subject,
                                            body: body,
                                            isHtml: isHtml,
                                            attachments: attachments)
            }

            if !ableToSendByURL {
                self.showAlert(title: "Doh! - Unable to send email",
                               message: "Please check that you have installed Apple's Mail app and configured it with your account")
            }
        }
    }

    func sendEmail(to: [String], subject: String, body: String, isHtml: Bool = false) {
        sendEmail(to: to,
                  subject: subject,
                  body: body,
                  isHtml: isHtml,
                  attachments: [])
    }
}

// Delegate isn't always called (e.g. VC can be dismissed by tapping outside form in iPad)
// using subclass rather than delegate object means there isn't a stranded delegate
// delegate is weak - so no self-retain issue
private class MFMailComposeViewControllerwDelegate: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Mail failed")
        default:
            break
        }

        self.dismiss(animated: true, completion: nil)
    }
}

#endif
