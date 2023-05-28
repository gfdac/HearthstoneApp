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
    var presenter: CardDetailPresenterProtocol!
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        // Configurar as propriedades do imageView
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let flavorLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let setLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let factionLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let rarityLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    private let healthLabel: UILabel = {
        let label = UILabel()
        // Configurar as propriedades do label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
    
    // Implementação do protocolo CardDetailViewProtocol
    
    func displayCardDetail(_ card: CardListModels.Card) {
        cardImageView.image = UIImage(named: card.image)
        nameLabel.text = card.name
        flavorLabel.text = card.flavor
        descriptionLabel.text = card.description
        setLabel.text = card.cardSet
        typeLabel.text = card.type
        factionLabel.text = card.faction
        rarityLabel.text = card.rarity
        attackLabel.text = "\(card.attack)"
        costLabel.text = "\(card.cost)"
        healthLabel.text = "\(card.health)"
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
