//
//  PokedexViewController.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import UIKit
import RxSwift

class PokedexViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let disposeBag = DisposeBag()
    let viewModel = PokedexViewModel()
    
    // MARK: - UI COMPONENTS
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private lazy var activityView: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: view.frame.size.width, height: 100)))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        bindData()
        bindTableView()
        bindRefreshAction()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = "POKEDEX"
        tableView.delegate = self
        tableView.register(PokemonCardCell.self, forCellReuseIdentifier: PokemonCardCell.IDENTIFIER)
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    private func bindData() {
        viewModel.items.bind(to: tableView.rx.items) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCardCell.IDENTIFIER) as! PokemonCardCell
            cell.pokeName = item.name
            cell.pokeImage = item.sprites.front_default ?? URL(string: "")
            var types = ""
            item.types.forEach({
                types += $0.type.name + " "
            })
            cell.pokeType = types
            cell.selectionStyle = .none
            
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableView.rx.didScroll.subscribe {[weak self] _ in
            guard let self = self else { return }
            let offsetY = self.tableView.contentOffset.y
            let tableViewContentHeight = self.tableView.contentSize.height
            
            if offsetY > (tableViewContentHeight - self.tableView.frame.size.height - 100) {
                self.viewModel.fetchMoreData.onNext(())
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] data in
            guard let data = self?.viewModel.items.value[data.element?.row ?? 0] else { return }
            let vc = PokemonDetailViewController()
            let viewModel = PokemonDetailViewModel(pokemonDetail: .init(id: data.id, name: data.name, image: data.sprites.front_default, types: data.types, abilities: data.abilities, baseExperience: data.base_experience, height: data.height, order: data.order, weight: data.weight))
            vc.viewModel = viewModel
            self?.showDetailViewController(vc, sender: self)
        }.disposed(by: disposeBag)
    }
    
    private func bindRefreshAction() {
        viewModel.isLoadingSpinnerAvailable.subscribe {[weak self]  isAvailable in
            guard let isAvailable = isAvailable.element, let self = self else { return }
            self.tableView.tableFooterView = isAvailable ? self.activityView : UIView(frame: .zero)
        }.disposed(by: disposeBag)
        
        viewModel.refreshControlComplete.subscribe { [weak self ] _ in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }

    @objc private func refreshControlTriggered() {
        viewModel.refreshControlAction.onNext(())
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(PokemonCardCell.CEL_HEIGHT)
    }
}
