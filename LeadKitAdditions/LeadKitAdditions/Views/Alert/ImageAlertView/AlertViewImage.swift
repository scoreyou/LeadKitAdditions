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

public typealias AlertButtonTapped = (Int) -> Void

open class BaseImageAlertView: BaseAlertView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!

    public var buttonsBlock: AlertButtonTapped?

    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    public var leftButtonTitle: String? {
        get {
            return leftButton.title(for: .normal)
        }
        set {
            leftButton.setTitle(newValue, for: .normal)
        }
    }

    public var rightButtonTitle: String? {
        get {
            return rightButton.title(for: .normal)
        }
        set {
            rightButton.setTitle(newValue, for: .normal)
        }
    }

    open var buttonFonts: [UIFont]? {
        return nil
    }

    open var buttonColors: [UIColor]? {
        return nil
    }

    override open func awakeFromNib() {
        super.awakeFromNib()

        let buttons = [leftButton, rightButton]

        if let fonts = buttonFonts {
            zip(buttons, fonts).forEach {
                $0?.titleLabel?.font = $1
            }
        }

        if let colors = buttonColors {
            zip(buttons, colors).forEach {
                $0?.setTitleColor($1, for: .normal)
            }
        }
    }

    // MARK: - Actions

    @IBAction private func buttonTapped(_ sender: UIButton) {
        close()
        buttonsBlock?(sender.tag)
    }

}
