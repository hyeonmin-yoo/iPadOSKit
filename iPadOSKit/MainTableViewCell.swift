//
//  MainTableViewCell.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    private var title: String? {
        didSet { titleLabel.text = title }
    }
    
    private var viewColour: UIColor? {
        didSet { cellView.backgroundColor = viewColour }
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        cellView.pinToEdges(of: contentView, margins: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
        titleLabel.pinToEdges(of: cellView, margins: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
    }
    
    func configure(title: String, hexColor: String) {
        self.title = title
        self.viewColour = UIColor(hex: hexColor)
    }
}
