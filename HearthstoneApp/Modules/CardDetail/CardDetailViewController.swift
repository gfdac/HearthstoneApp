//
//  CardDetailViewController.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardDetailViewProtocol: AnyObject {
    func displayCardDetail(_ card: CardListModels.Card)
    func displayError(message: String)
}

class CardDetailViewController: UIViewController, CardDetailViewProtocol {
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let flavorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let setLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let factionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let rarityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let healthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private var presenter: CardDetailPresenterProtocol
    private var card: CardListModels.Card
    
    init(presenter: CardDetailPresenterProtocol, card: CardListModels.Card) {
        self.presenter = presenter
        self.card = card
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(cardImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(flavorLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(setLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(factionLabel)
        stackView.addArrangedSubview(rarityLabel)
        stackView.addArrangedSubview(attackLabel)
        stackView.addArrangedSubview(costLabel)
        stackView.addArrangedSubview(healthLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "HearthstoneApp"
    }
    
    func displayCardDetail(_ card: CardListModels.Card) {
        nameLabel.text = card.name
//        flavorLabel.text = card.flavor
//        descriptionLabel.text = card.description
//        setLabel.text = card.cardSet
//        typeLabel.text = card.type
//        factionLabel.text = card.faction
//        rarityLabel.text = card.rarity
//        attackLabel.text = "\(card.attack)"
//        costLabel.text = "\(card.cost)"
//        healthLabel.text = "\(card.health)"
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
