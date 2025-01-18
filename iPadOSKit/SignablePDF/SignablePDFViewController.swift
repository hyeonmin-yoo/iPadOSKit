//
//  SignablePDFViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 12/01/2025.
//

import UIKit
import PDFKit

class SignablePDFViewController: UIViewController {
    private let mainView = SignablePDFViewController.View()
    private let overlayProvider = OverlayProvider()
    
    override func loadView() { view = mainView }
    
    override func viewDidLoad() {
        setupView()
        setupViewLayout()
    }
    
    private func setupView() {
        mainView.pdfView.pageOverlayViewProvider = overlayProvider
        
        guard let url = Bundle.main.url(forResource: "pdf-template", withExtension: "pdf"),
              let document = PDFDocument(url: url)
        else { return }
        mainView.pdfView.document = document
        
        mainView.deleteAllbutton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupViewLayout() {
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if overlayProvider.isEmpty() == false {
                overlayProvider.deleteAll()
            }
        case 1: break
            // TODO: Save locally as PDF file or send it to remote
        default: return
        }
    }
}

// MARK: - View
fileprivate extension SignablePDFViewController {
    // MainView
    class View: UIView {
        
        let pdfView: PDFView = {
            let view = PDFView()
            view.displayMode = .singlePageContinuous
            view.usePageViewController(false)
            view.displayDirection = .vertical
            view.isInMarkupMode = true
            view.autoScales = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            return view
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let deleteAllbutton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(String(localized: "Delete All"), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 10
            button.tag = 0
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let doneButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(String(localized: "Done"), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 10
            button.tag = 1
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
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
            [deleteAllbutton, doneButton].forEach(stackView.addArrangedSubview(_:))
            [pdfView, stackView].forEach(addSubview)
        }
        private func setupViewLayouts() {
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0),
                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
                stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24.0),
                pdfView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                pdfView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                pdfView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                pdfView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    }
}

