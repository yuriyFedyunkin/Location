//
//  MenuViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import RxSwift

protocol MenuViewModel: AnyObject {
    var router: MenuRouter { get }
    var didTapShowMap: AnyObserver<Void> { get }
}

final class MenuViewModelImpl: NSObject, MenuViewModel {
    
    let router: MenuRouter
    let didTapShowMap: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(router: MenuRouter) {
        self.router = router
        
        let didTapShowMapSubject = PublishSubject<Void>()
        didTapShowMap = didTapShowMapSubject.asObserver()
        didTapShowMapSubject
            .bind { [weak router] _ in router?.showMap() }
            .disposed(by: disposeBag)
    }
}
