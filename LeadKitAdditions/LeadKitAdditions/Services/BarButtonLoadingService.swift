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
import RxSwift
import RxCocoa

public enum BarButtonLoadingServiceSide {
    case left
    case right
}

public class BarButtonLoadingService {

    fileprivate weak var navigationItem: UINavigationItem?
    fileprivate var savedBarButton: UIBarButtonItem?
    private let side: BarButtonLoadingServiceSide

    private var barButtonItem: UIBarButtonItem? {
        get {
            switch side {
            case .left:
                return navigationItem?.leftBarButtonItem
            case .right:
                return navigationItem?.rightBarButtonItem
            }
        }
        set {
            switch side {
            case .left:
                navigationItem?.leftBarButtonItem = newValue
            case .right:
                navigationItem?.rightBarButtonItem = newValue
            }
        }
    }

    public init(navigationItem: UINavigationItem, side: BarButtonLoadingServiceSide) {
        self.navigationItem = navigationItem
        self.side = side
    }

    fileprivate func setBarButton(waiting: Bool = false) {
        if waiting {
            savedBarButton = barButtonItem

            let activityIndicatorItem =  UIBarButtonItem.activityIndicator
            barButtonItem = activityIndicatorItem.barButton
            activityIndicatorItem.activityIndicator.startAnimating()
        } else {
            barButtonItem = savedBarButton
        }
    }

}

extension Observable {

    public func changeLoadingUI(using loadingService: BarButtonLoadingService) -> Observable<Observable.E> {
        return observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                loadingService.setBarButton(waiting: true)
            }, onDispose: {
                loadingService.setBarButton(waiting: false)
            })
    }

}