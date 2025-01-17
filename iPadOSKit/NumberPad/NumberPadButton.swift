//
//  NumberPadButton.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

protocol NumberPadButtonDelegate: AnyObject {
    func numberPadDidTap(_ button: NumberPadButton)
}

class NumberPadButton: UIButton {
    enum Kind {
        case number, delete, deleteAll
    }

    private let formatter: NumberPadButtonFormatter
    private(set) var kind: Kind
    weak var delegate: NumberPadButtonDelegate?

    override var isHighlighted: Bool {
        didSet {
            formatter.applyHighlight(isHighlighted, to: self)
        }
    }

    init(title: CustomStringConvertible, formatter: NumberPadButtonFormatter, kind: Kind) {
        self.formatter = formatter
        self.kind = kind
        super.init(frame: .zero)
        setTitle(title.description, for: .normal)
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        self.formatter.applyStyle(to: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func buttonClicked() {
        guard let delegate else { return }
        delegate.numberPadDidTap(self)
    }
}

// MARK: - NumberPadButtonFormatter
protocol NumberPadButtonFormatter {
    func applyStyle(to button: NumberPadButton)
    func applyHighlight(_ isHighlighted: Bool, to button: NumberPadButton)
}

// MARK: - NormalKeyButtonFormatter
struct NormalKeyButtonFormatter: NumberPadButtonFormatter {
    func applyStyle(to button: NumberPadButton) {
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = .zero
        button.layer.shadowOffset = CGSize(width: .zero, height: 1.0)
        button.layer.shadowOpacity = 0.25
    }

    func applyHighlight(_ isHighlighted: Bool, to button: NumberPadButton) {
        button.backgroundColor = isHighlighted ? .numberPadButton : .white
    }
}

// MARK: - SpecialKeyButtonFormatter
struct SpecialKeyButtonFormatter: NumberPadButtonFormatter {
    func applyStyle(to button: NumberPadButton) {
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .numberPadButton
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = .zero
        button.layer.shadowOffset = CGSize(width: .zero, height: 1.0)
        button.layer.shadowOpacity = 0.25
    }

    func applyHighlight(_ isHighlighted: Bool, to button: NumberPadButton) {
        button.backgroundColor = isHighlighted ? .white : .numberPadButton
    }
}
