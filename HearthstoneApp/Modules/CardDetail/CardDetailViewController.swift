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
        label.textAlignment = .right
        return label
    }()
    
    private let flavorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let setLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let factionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let rarityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let healthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .right
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
        
        let nameLabelStackView = createLabelStackView(label: "Nome:", valueLabel: nameLabel)
        let flavorLabelStackView = createLabelStackView(label: "Descrição:", valueLabel: flavorLabel)
        let descriptionLabelStackView = createLabelStackView(label: "Descrição curta:", valueLabel: textLabel)
        let setLabelStackView = createLabelStackView(label: "Set pertencente:", valueLabel: setLabel)
        let typeLabelStackView = createLabelStackView(label: "Tipo:", valueLabel: typeLabel)
        let factionLabelStackView = createLabelStackView(label: "Facção:", valueLabel: factionLabel)
        let rarityLabelStackView = createLabelStackView(label: "Raridade:", valueLabel: rarityLabel)
        let attackLabelStackView = createLabelStackView(label: "Ataque:", valueLabel: attackLabel)
        let costLabelStackView = createLabelStackView(label: "Custo:", valueLabel: costLabel)
        let healthLabelStackView = createLabelStackView(label: "Health:", valueLabel: healthLabel)
        
        stackView.addArrangedSubview(cardImageView)
        stackView.addArrangedSubview(nameLabelStackView)
        stackView.addArrangedSubview(flavorLabelStackView)
        stackView.addArrangedSubview(descriptionLabelStackView)
        stackView.addArrangedSubview(setLabelStackView)
        stackView.addArrangedSubview(typeLabelStackView)
        stackView.addArrangedSubview(factionLabelStackView)
        stackView.addArrangedSubview(rarityLabelStackView)
        stackView.addArrangedSubview(attackLabelStackView)
        stackView.addArrangedSubview(costLabelStackView)
        stackView.addArrangedSubview(healthLabelStackView)
        
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
    
    private func createLabelStackView(label: String, valueLabel: UILabel) -> UIStackView {
        let labelLabel = UILabel()
        labelLabel.textColor = .white
        labelLabel.text = label
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(labelLabel)
        stackView.addArrangedSubview(valueLabel)
        
        return stackView
    }
    
    
    func displayCardDetail(_ card: CardListModels.Card) {
        cardImageDowloader(card)
        nameLabel.text = card.name
        flavorLabel.text = card.flavor ?? "Indefinido"
        textLabel.text = card.text ?? "Indefinido"
        setLabel.text = card.cardSet ?? "Indefinido"
        typeLabel.text = card.type ?? "Indefinido"
        factionLabel.text = card.faction ?? "Indefinido"
        rarityLabel.text = card.rarity ?? "Indefinido"
        attackLabel.text = card.attack != nil ? "\(card.attack!)" : "Indefinido"
        costLabel.text = card.cost != nil ? "\(card.cost!)" : "Indefinido"
        healthLabel.text = card.health != nil ? "\(card.health!)" : "Indefinido"
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func cardImageDowloader(_ card: CardListModels.Card) {
        if let imageURLString = card.img, let imageURL = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                    let resizedImage = image.resized(toWidth: 200)
                    DispatchQueue.main.async {
                        self.cardImageView.image = resizedImage
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
