//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class ButtonWithSpinner: UIButton {
    private var spinner: UIActivityIndicatorView?
    private var oldTitle: String?

    func showSpinner() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .White)
        spinner?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        oldTitle = titleLabel?.text
        setTitle("", forState: .Normal)

        if let spinner = spinner {
            spinner.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            addSubview(spinner)
            spinner.startAnimating()
        }
    }

    func hideSpinner() {
        if let spinner = spinner, oldTitle = oldTitle {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            setTitle(oldTitle, forState: .Normal)
        }
    }
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
let button = ButtonWithSpinner(type: .Custom)

button.frame = CGRect(x: 10, y: 10, width: 180, height: 100)
button.backgroundColor = UIColor(red: 93, green: 193, blue: 123)
button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
button.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
button.setTitle("Test", forState: .Normal)

class SpinnerToggler {
    private var shouldShowSpinner = true

    @objc func toggle() {
        if shouldShowSpinner {
            button.showSpinner()
        } else {
            button.hideSpinner()
        }

        shouldShowSpinner = !shouldShowSpinner
    }
}

let toggler = SpinnerToggler()

button.addTarget(toggler, action: #selector(toggler.toggle), forControlEvents: .TouchUpInside)

view.addSubview(button)

XCPlaygroundPage.currentPage.liveView = view
