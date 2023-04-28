//
//  AdDetailsViewController.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 25.04.2023.
//

import UIKit
import SwiftUI

class AdDetailsViewController: UIHostingController<AdDetailsView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
    }
}
