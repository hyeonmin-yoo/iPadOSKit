//
//  NumberPad.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit
import AVFoundation

class NumberPad: UIInputView {
    static let height: CGFloat = 350.0
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.frame = frame
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30.0),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8.0),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])

        return stackView
    }()

    private var horizontalStackView1: UIStackView {
        let stackView = createHorizontalStackView()
        let button1 = createButton(with: "1",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button1)
        let button2 = createButton(with: "2",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button2)
        let button3 = createButton(with: "3",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button3)
        return stackView
    }

    private var horizontalStackView2: UIStackView {
        let stackView = createHorizontalStackView()
        let button4 = createButton(with: "4",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button4)
        let button5 = createButton(with: "5",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button5)
        let button6 = createButton(with: "6",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button6)
        return stackView
    }

    private var horizontalStackView3: UIStackView {
        let stackView = createHorizontalStackView()
        let button7 = createButton(with: "7",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button7)
        let button8 = createButton(with: "8",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button8)
        let button9 = createButton(with: "9",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button9)
        return stackView
    }

    private var horizontalStackView4: UIStackView {
        let stackView = createHorizontalStackView()
        let deleteAllbutton = createButton(with: String(localized: "Delete All"),
                                           formatter: SpecialKeyButtonFormatter(),
                                           kind: .deleteAll)
        stackView.addArrangedSubview(deleteAllbutton)
        let button0 = createButton(with: "0",
                                   formatter: NormalKeyButtonFormatter())
        stackView.addArrangedSubview(button0)
        let deleteButton = createButton(with: String(localized: "Delete"),
                                        formatter: SpecialKeyButtonFormatter(),
                                        kind: .delete)
        stackView.addArrangedSubview(deleteButton)
        return stackView
    }

    weak var textField: UITextField?

    init() {
        super.init(frame: CGRect(x: .zero, y: .zero, width: .zero, height: NumberPad.height), inputViewStyle: .keyboard)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        verticalStackView.addArrangedSubview(horizontalStackView3)
        verticalStackView.addArrangedSubview(horizontalStackView4)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.frame = frame
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        return stackView
    }

    private func createButton(with title: CustomStringConvertible, formatter: NumberPadButtonFormatter, kind: NumberPadButton.Kind = .number) -> NumberPadButton {
        let button = NumberPadButton(title: title, formatter: formatter, kind: kind)
        button.delegate = self
        return button
    }
}

extension NumberPad {
    func inputAccessoryToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: .zero,
                                              y: .zero,
                                              width: UIScreen.main.bounds.width,
                                              height: 44.0))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let closeBarButtonItem = UIBarButtonItem(title: "",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(onCloseBarButtonTapped))
        closeBarButtonItem.image = .init(systemName: "keyboard.chevron.compact.down")
        closeBarButtonItem.tintColor = .darkGray
        toolbar.items = [spacer, closeBarButtonItem]
        toolbar.sizeToFit()
        return toolbar
    }

    @objc
    func onCloseBarButtonTapped() {
        textField?.endEditing(false)
    }
}

// MARK: - NumberPadButtonDelegate
extension NumberPad: NumberPadButtonDelegate {
    func numberPadDidTap(_ button: NumberPadButton) {
        guard let textField else { return }
        hapticFeedback()
        playSound()
        
        switch button.kind {
        case .delete: _ = textField.text?.popLast()
        case .deleteAll: textField.text = ""
        case .number: textField.text = (textField.text ?? "") + (button.titleLabel?.text ?? "") }
        textField.sendActions(for: .editingChanged)
    }
    
    func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func playSound() {
        AudioServicesPlaySystemSound(1104)
    }
}

// MARK: - UIInputViewAudioFeedback
extension NumberPad: UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool { return true }
}

// MARK: - UITextField
extension UITextField {
    func setNumberPad() {
        let numberPad = NumberPad()
        numberPad.textField = self
        inputView = numberPad
        inputAccessoryView = numberPad.inputAccessoryToolbar()
        inputAssistantItem.leadingBarButtonGroups = []
        inputAssistantItem.trailingBarButtonGroups = []
    }
}
