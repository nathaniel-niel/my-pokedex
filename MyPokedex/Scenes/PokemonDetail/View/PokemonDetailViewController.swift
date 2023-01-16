//
//  PokemonDetail.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import UIKit
import RxSwift

class PokemonDetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var viewModel: PokemonDetailViewModel? = nil
    let disposeBag = DisposeBag()
    
    // MARK: - UI COMPONENTS
    let baseStakView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        return stack
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let imageBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    let addToFavoritebutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add To Favorite", for: [])
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        setupTableView()
        addToFavoritebutton.addTarget(self, action: #selector(saveToFavorite), for: .touchUpInside)
        bind()
    }
    
    private func setLayout() {
        baseStakView.addArrangedSubview(imageBanner)
        baseStakView.addArrangedSubview(pokemonNameLabel)
        baseStakView.addArrangedSubview(tableView)
        baseStakView.addArrangedSubview(addToFavoritebutton)
        
        view.addSubview(baseStakView)
        
        NSLayoutConstraint.activate([
            baseStakView.topAnchor.constraint(equalTo: view.topAnchor),
            baseStakView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: baseStakView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: baseStakView.bottomAnchor),
            imageBanner.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.25)
        ])
    }
    
    private func setupTableView() {
        tableView.register(PokemonCardDetailCell.self, forCellReuseIdentifier: PokemonCardDetailCell.IDENTIFIER)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
    }
    
    private func bind() {
        viewModel?.item.subscribe { [weak self] data in
            guard let pokemon = data.element?.image else { return }
            self?.imageBanner.loadImage(from: pokemon)
            self?.pokemonNameLabel.text = data.element?.name
        }.disposed(by: disposeBag)
        
        viewModel?.tableItem.bind(to: tableView.rx.items) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCardDetailCell.IDENTIFIER) as! PokemonCardDetailCell
            cell.titleText = item.title
            cell.contentText = item.content
            cell.isUserInteractionEnabled = false
            return cell
        }.disposed(by: disposeBag)
        
        viewModel?.saveActionComplete.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    @objc func saveToFavorite() {
        viewModel?.saveToFavorite()
    }
}

extension PokemonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
