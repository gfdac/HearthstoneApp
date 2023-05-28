//  CardListViewController.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardListViewProtocol: AnyObject {
    func displayCards(_ cards: [String: [CardListModels.Card]])
    func displayError(message: String)
    func navigateToCardDetail(card: CardListModels.Card)
}

class CardListViewController: UIViewController, CardListViewProtocol {
    private var tableView: UITableView!
    
    var presenter: CardListPresenterProtocol?
    var sectionData: [String] = []
    var cardData: [String: [CardListModels.Card]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupPresenter()
        presenter?.fetchCards()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Constraints
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupPresenter() {
        let networkService = NetworkService()
        let apiService = HearthstoneService(networkService: networkService)
        let interactor = CardListInteractor(apiService: apiService)
        let presenter = CardListPresenter(view: self, interactor: interactor, router: CardListRouter(viewController: self))
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    func displayCards(_ cards: [String: [CardListModels.Card]]) {
        cardData = cards
        sectionData = Array(cards.keys).sorted()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToCardDetail(card: CardListModels.Card) {
        let cardDetailViewController = CardDetailViewController()
        navigationController?.pushViewController(cardDetailViewController, animated: true)
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sectionData[section]
        return cardData[sectionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        let sectionKey = sectionData[indexPath.section]
        if let cardsInSection = cardData[sectionKey] {
            let card = cardsInSection[indexPath.row]
            cell.configure(with: card)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKey = sectionData[indexPath.section]
        if let cardsInSection = cardData[sectionKey] {
            let selectedCard = cardsInSection[indexPath.row]
            presenter?.selectCard(selectedCard)
        }
    }
}

class CardTableViewCell: UITableViewCell {
    private var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNameLabel()
    }
    
    private func configureNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with card: CardListModels.Card) {
        nameLabel.text = card.name
    }
}
