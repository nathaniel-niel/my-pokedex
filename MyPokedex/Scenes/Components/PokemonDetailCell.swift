//
//  PokemonDetailCell.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import Foundation
import UIKit

class PokemonCardDetailCell: UITableViewCell {
    
    // MARK: - CONSTANT
    static let IDENTIFIER = "POKEMON_CARD_DETAIL_CELL"
    
    // MARK: - PROPERTIES
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var contentText: String = "" {
        didSet {
            contentLabel.text = contentText
        }
    }
    
    // MARK: - UI COMPONENTS
    let baseStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.setContentHuggingPriority(.init(1000), for: .vertical)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - LIFE CYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        baseStackView.addArrangedSubview(titleLabel)
        baseStackView.addArrangedSubview(contentLabel)
        contentView.addSubview(baseStackView)
        
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: baseStackView.bottomAnchor)
        ])
    }
}
