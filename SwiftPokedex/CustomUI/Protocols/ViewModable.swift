//
//  ViewModable.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

/// A protocol used in views to make them implement view models
protocol ViewModable where Self: UIView {
    /// The associated view model type
    associatedtype ViewModel

    /// A view model object for the view
    var viewModel: ViewModel! { get set }

    /// Set the view model for the view and renders all the view model values in the view
    /// - parameter viewModel: The given view model to render
    func setViewModel(_ viewModel: ViewModel)
}
