//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import LeadKit

open class BaseAlertView: UIView {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    open var titleFont: UIFont {
        return .systemFont(ofSize: 17)
    }

    open var titleColor: UIColor {
        return .black
    }

    public var message: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }

    open var messageFont: UIFont {
        return .systemFont(ofSize: 13)
    }

    open var messageColor: UIColor {
        return .black
    }

    override open func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font        = titleFont
        titleLabel.textColor   = titleColor
        messageLabel.font      = messageFont
        messageLabel.textColor = messageColor

        dialogView.layer.cornerRadius = 10

        isUserInteractionEnabled = true
        dialogView.isUserInteractionEnabled = true
    }

    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        if let superView = newSuperview {
            self.frame = CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height)
        }
    }

    // MARK: - Public interface

    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self)

        dialogView.layer.opacity = 0
        dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.0)

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.dialogView.layer.opacity = 1.0
            self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: nil)
    }

    public func close() {
        let currentTransform = dialogView.layer.transform
        dialogView.layer.opacity = 1.0

        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = .clear
            self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1.0))
            self.dialogView.layer.opacity = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }

}
