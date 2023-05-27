//
//  CardListViewController.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardListViewProtocol: AnyObject {
    func displayCards(_ cards: [CardListModels.Card])
    func displayError(message: String)
}

class CardListViewController: UIViewController, CardListViewProtocol {
    var presenter: CardListPresenterProtocol?
    var cards: [CardListModels.Card] = []

    @IBOutlet weak var tableView: UITableView!
    // Outlets para outros elementos da interface do usuário, se houver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter?.fetchCards()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func displayCards(_ cards: [CardListModels.Card]) {
        self.cards = cards
        tableView.reloadData()
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension CardListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.name
        // Configurar outras propriedades da célula com base nos dados do cartão, se necessário
        return cell
    }
}
