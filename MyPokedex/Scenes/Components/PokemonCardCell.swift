//
//  PokemonCardCell.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 15/01/23.
//

import UIKit

class PokemonCardCell: UITableViewCell {
    
    // MARK: - CONSTANT
    static let IDENTIFIER = "POKEMON_CARD_CELL"
    static let CEL_HEIGHT = 100
    
    // MARK: - PROPERTIES
    var pokeImage: URL? {
        didSet {
            guard let imageURL = pokeImage else { return  }
            pokemonImage.loadImage(from: imageURL)
        }
    }
    
    var pokeName: String = "" {
        didSet {
            pokemonNameLabel.text = pokeName
        }
    }
    
    var pokeType: String = "" {
        didSet {
            pokemonTypesLabel.text = pokeType
        }
    }
    
    // MARK: - UI COMPONENTS
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return view
    }()
    
    let pokemonImage: UIImageView = {
        let image =  UIImageView(frame: .init(origin: .zero, size: .init(width: 80, height: 80)))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let baseStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        return stack
    }()
    
    let rightContent: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.init(1000), for: .vertical)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let pokemonTypesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LIFE CYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.image = UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        rightContent.addArrangedSubview(pokemonNameLabel)
        rightContent.addArrangedSubview(pokemonTypesLabel)
        baseStackView.addArrangedSubview(pokemonImage)
        baseStackView.addArrangedSubview(rightContent)
        baseView.addSubview(baseStackView)
        contentView.addSubview(baseView)
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 8),
            baseStackView.topAnchor.constraint(equalTo: baseView.topAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: baseStackView.bottomAnchor),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
