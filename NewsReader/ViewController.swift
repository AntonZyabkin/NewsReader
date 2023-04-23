//
//  ViewController.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 21.04.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewController = AddListViewController(viewModel: AddListViewModel(service: AddsService()))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)

    }

}

