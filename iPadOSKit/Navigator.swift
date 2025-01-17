//
//  navigator.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

enum ViewControllerType {
    case main
    
    var viewController: UIViewController {
        switch self {
        case .main: MainViewController()
        }
    }
    
    var type: UIViewController.Type {
        switch self {
        case .main: MainViewController.self
        }
    }
}

final class Navigator: UINavigationController {
    static var shared = Navigator()
    
    private init() {
        super.init(rootViewController: ViewControllerType.main.viewController)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func push(_ type: ViewControllerType, animated: Bool = true) {
        shared.pushViewController(type.viewController, animated: animated)
    }
    
    static func pop(_ viewControllerType: ViewControllerType? = nil, animated: Bool = true) {
        if viewControllerType == nil {
            shared.popViewController(animated: animated)
        } else {
            if let type = viewControllerType?.type,
               let viewController = shared.viewControllers.last(where: { $0.isKind(of: type) }) {
                shared.popToViewController(viewController, animated: animated)
            }
        }
    }
    
    static func viewControllers() -> [UIViewController] {
        shared.viewControllers
    }
    
    private static func popTo(type: UIViewController.Type, animated: Bool) {
        if let viewController = shared.viewControllers.last(where: { $0.isKind(of: type) }) {
            shared.popToViewController(viewController, animated: animated)
        } else { assertionFailure("Can not pop to: \(type)") }
    }
    
    static func set(_ types: [ViewControllerType], animated: Bool = true, shouldDismissDialog: Bool = false) {
        shared.setViewControllers(types.map(\.viewController), animated: animated)
    }
}
