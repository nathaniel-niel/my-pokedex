//
//  FavoritePokemonViewController.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import UIKit
import RxSwift

class FavoritePokemonViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let viewModel = FavoritePokemonViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - UI COMPONENTS
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefreshControlTrigerred), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "FAVORITE"
        setup()
        setLayout()
        bind()
    }
    
    private func setup() {
        tableView.register(PokemonCardCell.self, forCellReuseIdentifier: PokemonCardCell.IDENTIFIER)
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.item.bind(to: tableView.rx.items){ tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCardCell.IDENTIFIER) as! PokemonCardCell
            cell.pokeName = item.name
            cell.pokeImage = URL(string: item.image)
            cell.selectionStyle = .none
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.refreshControlComplete.subscribe(onNext: {[weak self] _ in
            self?.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
    @objc func didRefreshControlTrigerred() {
        viewModel.refreshAction.onNext(())
    }
}

extension FavoritePokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(PokemonCardCell.CEL_HEIGHT)
    }
}
