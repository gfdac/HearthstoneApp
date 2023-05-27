//
//  CardDetailViewController.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardDetailViewProtocol: AnyObject {
    func displayCardDetail(_ card: CardListModels.Card)
}

class CardDetailViewController: UIViewController, CardDetailViewProtocol {
    var presenter: CardDetailPresenterProtocol!

    // Outlets para os elementos da interface do usuário (UI)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    private func setupUI() {
        // Configurar a aparência e o layout da interface do usuário (UI)
    }

    // Implementação do protocolo CardDetailViewProtocol

    func displayCardDetail(_ card: CardListModels.Card) {
        // Atualizar a interface do usuário (UI) com os detalhes do cartão recebido
    }
}

