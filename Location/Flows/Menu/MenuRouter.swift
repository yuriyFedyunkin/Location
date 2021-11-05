//
//  MenuRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import Foundation

protocol MenuRouter: MapPresentableRouter {}

final class MenuRouterImpl: BaseRouterImpl, MenuRouter {}
