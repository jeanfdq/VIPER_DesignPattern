//
//  Interactor.swift
//  VIPER_DesignPattern
//
//  Created by Jean Paul Borges Manzini on 18/01/22.
//

// Object
// Protocol
// Ref to Presenter

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func getUsers() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(.genericError))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(.genericError))
            }
            
        }.resume()
        
    }
    
}
