//
//  NumberPadViewController.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

class NumberPadViewController: UIViewController {
    private let mainView = NumberPadViewController.View()
    
    override func loadView() { view = mainView }
    
    override func viewDidLoad() {
        setupView()
        setupViewLayout()
    }
    
    private func setupView() {
        mainView.numberPad.becomeFirstResponder()
    }
    
    private func setupViewLayout() {
        
    }
}

// MARK: - View
fileprivate extension NumberPadViewController {
    class View: UIView {
        
        let numberPad: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter number"
            textField.font = .systemFont(ofSize: 40)
            textField.textAlignment = .center
            textField.setNumberPad()
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            setupViews()
            setupViewLayouts()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupViews() {
            [numberPad].forEach(addSubview)
        }
        private func setupViewLayouts() {
            NSLayoutConstraint.activate([
                numberPad.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200.0),
                numberPad.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
                numberPad.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
            ])
        }
    }
}

