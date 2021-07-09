//
//  PersonListViewModel.swift
//  MVVM
//
//  Created by Muna Abdelwahab on 3/24/21.
//

import Foundation

protocol PersonListViewModelProtocol {
    init(person: [Person])
    var listing : [Person]? {get}
    var listingDidChange : ((PersonListViewModelProtocol) -> (Void))? {get set}
    func showData()
}

class personViewModel : PersonListViewModelProtocol {
    
    let person : [Person]
    var listingDidChange: ((PersonListViewModelProtocol) -> (Void))?
    
    required init(person: [Person]) {
        self.person = person
    }
    
    var listing: [Person]? {
        didSet {
            listingDidChange?(self)
        }
    }
    
    func showData() {
        self.listing = person
    }
    
    
}
