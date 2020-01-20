//
//  PNUtils.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import SwiftMessages
import Alamofire
import AlamofireImage

class PNUtils: NSObject {
    
    class func displayAlert(message: String ,themeStyle: Theme?) {
        let aSwiftMessage = MessageView.viewFromNib(layout: .tabView)
        aSwiftMessage.configureTheme(themeStyle!)
        aSwiftMessage.configureContent(title: "", body: message)
        aSwiftMessage.button?.isHidden = true
        var aSwiftMessageConfig = SwiftMessages.defaultConfig
        aSwiftMessageConfig.presentationStyle = .top
        aSwiftMessageConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        aSwiftMessageConfig.duration = .seconds(seconds: 1.5)
        SwiftMessages.show(config: aSwiftMessageConfig, view: aSwiftMessage)
    }
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension String {
    
    func trim() -> String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: self)
    }
    
    func formattedNewsDate(isNewsDetail: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: String(self.dropLast()))
        dateFormatter.dateFormat = (isNewsDetail) ? "E, d MMM yyyy, h:mm a" : "MMM d yy, h:mm a"
        let formattedDate = dateFormatter.string(from: date!)
        return formattedDate
    }
}

extension UITextField {
    
    func isEmpty() -> Bool{
        return (self.text!.trim().count == 0) ? true : false
    }
    
}

extension UIDevice {
    
    func isIpad() -> Bool {
        return (UI_USER_INTERFACE_IDIOM() == .pad) ? true : false
    }
    
}

extension UIImageView {
    
    func setupImage(imageUrl: String, imageViewSize: CGSize,placeholderImage: String) {
        self.contentMode = .center
        if imageUrl.count != 0 {
            let encodedImage = imageUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let imageurl = URL(string: encodedImage!)
            let filter = AspectScaledToFillSizeFilter(size: (imageViewSize))
            self.af_setImage(withURL: imageurl!, placeholderImage: UIImage.init(named: placeholderImage), filter: filter, completion: { (response) in
                if !(response.error != nil) {
                    self.contentMode = .scaleToFill
                }
            })
        }else {
            self.image = UIImage.init(named: placeholderImage)
            self.contentMode = .scaleAspectFit
        }
    }
    
}

extension Date {
    
    func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

@IBDesignable class UIAlignedLabel: UILabel {

    override func drawText(in rect: CGRect) {
        if let text = text as NSString? {
            func defaultRect(for maxSize: CGSize) -> CGRect {
                let size = text
                    .boundingRect(
                        with: maxSize,
                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                        attributes: [
                            NSAttributedString.Key.font: font!
                        ],
                        context: nil
                    ).size
                let rect = CGRect(
                    origin: .zero,
                    size: CGSize(
                        width: min(frame.width, ceil(size.width)),
                        height: min(frame.height, ceil(size.height))
                    )
                )
                return rect

            }
            switch contentMode {
            case .top, .bottom, .left, .right, .topLeft, .topRight, .bottomLeft, .bottomRight:
                let maxSize = CGSize(width: frame.width, height: frame.height)
                var rect = defaultRect(for: maxSize)
                switch contentMode {
                    case .bottom, .bottomLeft, .bottomRight:
                        rect.origin.y = frame.height - rect.height
                    default: break
                }
                switch contentMode {
                    case .right, .topRight, .bottomRight:
                        rect.origin.x = frame.width - rect.width
                    default: break
                }
                super.drawText(in: rect)
            default:
                super.drawText(in: rect)
            }
        } else {
            super.drawText(in: rect)
        }
    }

}
