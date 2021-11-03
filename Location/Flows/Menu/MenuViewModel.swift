//
//  MenuViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import Foundation

protocol MenuViewModel: AnyObject {
    var router: MenuRouter { get }
}

final class MenuViewModelImpl: NSObject, MenuViewModel {
    
    let router: MenuRouter
    
    init(router: MenuRouter) {
        self.router = router
    }
}
