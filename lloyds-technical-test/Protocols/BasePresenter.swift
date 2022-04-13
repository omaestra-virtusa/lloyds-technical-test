//
//  BasePresenter.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    func attachView(_ view: BaseViewProtocol)
    func detachView(_ view: BaseViewProtocol)
}
