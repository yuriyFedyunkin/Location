//
//  BaseRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

protocol BaseRouter: AnyObject {
    var baseViewController: UIViewController? { get set }
    init(viewController: UIViewController)
}

extension BaseRouter {
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        baseViewController?.dismiss(animated: true, completion: completion)
    }

    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let nc = baseViewController?.navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            nc.popViewController(animated: true)
            CATransaction.commit()
        }
        else if baseViewController?.presentingViewController != nil {
            baseViewController?.dismiss(animated: true, completion: completion)
        }
    }
    
    func show(viewController: UIViewController, sender: Any? = nil, completion: (() -> Void)? = nil) {
        if let navigationController = baseViewController?.navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.pushViewController(viewController, animated: true)
            CATransaction.commit()
        }
        else {
            baseViewController?.present(viewController, animated: true, completion: completion)
        }
    }
    
    func present(_ viewController: UIViewController, sender: Any? = nil, completion: (() -> Void)? = nil) {
        baseViewController?.present(viewController, animated: true, completion: completion)
    }
}

class BaseRouterImpl: NSObject, BaseRouter {
    
    weak var baseViewController: UIViewController?
    
    required init(viewController: UIViewController) {
        baseViewController = viewController
        super.init()
    }
}
