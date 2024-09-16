//
//  Router.swift
//  swift_playground
//
//  Created by Henry on 9/12/24.
//  https://levelup.gitconnected.com/modular-navigation-in-swiftui-a-comprehensive-guide-5eeb8a511583
//  https://github.com/hoangatuan/iMovie
//

import Foundation
import SwiftUI

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    public init() {}

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
