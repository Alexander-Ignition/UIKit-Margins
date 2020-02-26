//
//  FirstViewController.swift
//  UIKit-Margins
//
//  Created by Alexander Ignatev on 25.02.2020.
//  Copyright © 2020 Alexandr Ignatyev. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {

    private var gridViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGrid()
    }

    @IBAction func toggleGrid() {
        gridViews.forEach { $0.isHidden.toggle() }
    }

    private func setupGrid() {
        gridViews = UIView.LayoutGuide.allCases.map { (guide: UIView.LayoutGuide) -> UIView in
            let grid = UIView()
            grid.backgroundColor = .clear
            grid.layer.borderWidth = 1
            grid.layer.borderColor = UIColor.gray.cgColor
            view.addContent(grid, guide: guide)
            view.sendSubviewToBack(grid)
            return grid
        }
    }
}
