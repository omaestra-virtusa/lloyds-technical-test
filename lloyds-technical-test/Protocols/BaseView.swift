//
//  BaseView.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import UIKit

protocol BaseViewProtocol: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func showAlertWithTitle(_ title: String?, message: String)
}

extension BaseViewProtocol {
    public func didStartLoading() {
        DispatchQueue.main.async {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }

    public func didFinishLoading() {
        DispatchQueue.main.async {
//             UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension BaseViewProtocol where Self: UIViewController {
    func showAlertWithTitle(_ title: String?, message: String) {
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (result: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
