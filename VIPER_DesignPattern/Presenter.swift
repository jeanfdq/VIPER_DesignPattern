//
//  Presenter.swift
//  VIPER_DesignPattern
//
//  Created by Jean Paul Borges Manzini on 18/01/22.
//

// Object
// Protocol
// Ref to Interactor, Router, View

import Foundation

enum fetchError: Error {
    case genericError
}

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchUsers(with result: Result<[User], fetchError>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUsers(with result: Result<[User], fetchError>) {
        
        switch result {
        case .success(let users): view?.update(with: users)
        case .failure: view?.update(with: "Algo deu errado!")
        }
        
    }
    
}
