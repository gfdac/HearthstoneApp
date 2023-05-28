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
    func startLoadingIndicator()
    func stopLoadingIndicator()
}
class CardListViewController: UIViewController, CardListViewProtocol {
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    private var searchController: UISearchController!
    
    var presenter: CardListPresenterProtocol?
    var sectionData: [String] = []
    var cardData: [String: [CardListModels.Card]] = [:]
    var filteredData: [String: [CardListModels.Card]] = [:]
    
    var isSearchEnabled: Bool = false {
        didSet {
            searchController.searchBar.isUserInteractionEnabled = isSearchEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppDesignSystem.Colors.background
        configureNavigationBar()
        configureTableView()
        configureActivityIndicator()
        setupSearchController()
        setupPresenter()
        presenter?.fetchCards()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = AppDesignSystem.Colors.navigationBarBackground
        navigationController?.navigationBar.tintColor = AppDesignSystem.Colors.navigationBarTint
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppDesignSystem.Colors.navigationBarTitle,
            NSAttributedString.Key.font: AppDesignSystem.Fonts.navigationBarTitle
        ]
        navigationItem.title = "HearthstoneApp"
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        // Constraints
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = AppDesignSystem.Colors.activityIndicator
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        isSearchEnabled = false
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
        filteredData = cards
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.isSearchEnabled = true
        }
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func navigateToCardDetail(card: CardListModels.Card) {
        guard let navigationController = navigationController else {
            return
        }
        
        let cardDetailViewController = CardDetailRouter.createModule(with: card)
        navigationController.pushViewController(cardDetailViewController, animated: true)
    }
    
    func startLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func stopLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sectionData[section]
        return filteredData[sectionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        let sectionKey = sectionData[indexPath.section]
        if let cardsInSection = filteredData[sectionKey] {
            let card = cardsInSection[indexPath.row]
            cell.configure(with: card)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKey = sectionData[indexPath.section]
        if let cardsInSection = filteredData[sectionKey] {
            let selectedCard = cardsInSection[indexPath.row]
            presenter?.selectCard(selectedCard)
        }
    }
}

extension CardListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        if searchText.isEmpty {
            filteredData = cardData
        } else {
            filteredData = cardData.mapValues { cards in
                cards.filter { card in
                    card.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        tableView.reloadData()
    }
}

class CardTableViewCell: UITableViewCell {
    private var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameLabel()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNameLabel()
        configureAppearance()
    }
    
    private func configureNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppDesignSystem.Sizes.cellPadding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppDesignSystem.Sizes.cellPadding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppDesignSystem.Sizes.cellPadding),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppDesignSystem.Sizes.cellPadding)
        ])
        
        nameLabel.font = AppDesignSystem.Fonts.cellTitle
        nameLabel.textColor = AppDesignSystem.Colors.text
    }
    
    func configure(with card: CardListModels.Card) {
        nameLabel.text = card.name
    }
    
    private func configureAppearance() {
        backgroundColor = AppDesignSystem.Colors.background
        contentView.backgroundColor = AppDesignSystem.Colors.background
    }
}

extension CardListViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = AppDesignSystem.Colors.headerBackground
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = AppDesignSystem.Colors.headerTitle
        titleLabel.font = AppDesignSystem.Fonts.headerTitle
        titleLabel.text = sectionData[section]
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: AppDesignSystem.Sizes.headerPadding),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -AppDesignSystem.Sizes.headerPadding),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: AppDesignSystem.Sizes.headerPadding),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -AppDesignSystem.Sizes.headerPadding)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AppDesignSystem.Sizes.headerHeight
    }
}
