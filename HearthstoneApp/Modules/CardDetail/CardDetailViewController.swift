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
    
    private lazy var nameLabel: UILabel = createLabel()
    private lazy var flavorLabel: UILabel = createLabel()
    private lazy var descriptionLabel: UILabel = createLabel()
    private lazy var setLabel: UILabel = createLabel()
    private lazy var typeLabel: UILabel = createLabel()
    private lazy var factionLabel: UILabel = createLabel()
    private lazy var rarityLabel: UILabel = createLabel()
    private lazy var attackLabel: UILabel = createLabel()
    private lazy var costLabel: UILabel = createLabel()
    private lazy var healthLabel: UILabel = createLabel()
    
    private var presenter: CardDetailPresenterProtocol
    private var card: CardListModels.Card
    
    private let undefinedText = AppDesignSystem.Strings.undefinedText
    
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
        let descriptionLabelStackView = createLabelStackView(label: "Descrição curta:", valueLabel: descriptionLabel)
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppDesignSystem.Colors.text]
        navigationItem.title = AppDesignSystem.Strings.appTitle
    }
    
    private func createLabelStackView(label: String, valueLabel: UILabel) -> UIStackView {
        let labelLabel = UILabel()
        labelLabel.textColor = AppDesignSystem.Colors.text
        labelLabel.text = label
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(labelLabel)
        stackView.addArrangedSubview(valueLabel)
        
        return stackView
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.font = AppDesignSystem.Fonts.attributesTitle
        label.textColor = AppDesignSystem.Colors.text
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }
    
    func displayCardDetail(_ card: CardListModels.Card) {
        cardImageDowloader(card)
        nameLabel.text = card.name
        flavorLabel.text = card.flavor ?? undefinedText
        descriptionLabel.setHTMLText(card.text ?? undefinedText)
        setLabel.text = card.cardSet ?? undefinedText
        typeLabel.text = card.type ?? undefinedText
        factionLabel.text = card.faction ?? undefinedText
        rarityLabel.text = card.rarity ?? undefinedText
        attackLabel.text = card.attack != nil ? "\(card.attack!)" : undefinedText
        costLabel.text = card.cost != nil ? "\(card.cost!)" : undefinedText
        healthLabel.text = card.health != nil ? "\(card.health!)" : undefinedText
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

extension UILabel {
    func setHTMLText(_ htmlString: String) {
        let textColor = AppDesignSystem.Colors.text
        let font = AppDesignSystem.Fonts.attributesTitle
        let textAlignment = NSTextAlignment.right
        
        guard let data = htmlString.data(using: .utf8) else {
            self.text = htmlString
            self.textColor = textColor
            self.font = font
            self.textAlignment = textAlignment
            return
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            let fullRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.foregroundColor, value: textColor, range: fullRange)
            attributedString.addAttribute(.font, value: font, range: fullRange)
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        } else {
            self.text = htmlString
            self.textColor = textColor
            self.font = font
            self.textAlignment = textAlignment
        }
    }
}
