//
//  Router.swift
//  VIPER_DesignPattern
//
//  Created by Jean Paul Borges Manzini on 18/01/22.
//

// Object
// Entry Point

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry: EntryPoint? {get}
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?

    static func start() -> AnyRouter {
        
        let router = UserRouter()
        
        //Assing VIP
        
        let view        = UserViewController()
        let interactor  = UserInteractor()
        let presenter   = UserPresenter()
        
        view.presenter          = presenter
        interactor.presenter    = presenter
        
        presenter.router        = router
        presenter.interactor    = interactor
        presenter.view          = view
        
        router.entry = view //as EntryPoint
        
        return router
        
    }
    
}
