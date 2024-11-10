// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

@MainActor
public extension UIViewController {
    
    class func getTopmost() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topmostViewController(for: rootController)
    }
    
    private class func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private class func topmostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topmostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topmostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topmostViewController(for: topController)
        }
        return controller
    }
    
}
