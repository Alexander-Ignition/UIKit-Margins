//
//  SecondViewController.swift
//  UIKit-Margins
//
//  Created by Alexander Ignatev on 25.02.2020.
//  Copyright © 2020 Alexandr Ignatyev. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {

    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private var gridViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGrid()
        setupScrollView()
        setupStackView()

        stackView.addArrangedSubview({
            let container = UIView(UILabel("Superview"))
            container.backgroundColor = UIColor.magenta.withAlphaComponent(0.3)
            return container
        }())
        stackView.addArrangedSubview({
            let container = UIView(UILabel("System Layout margins"), guide: .layoutMargins)
            container.preservesSuperviewLayoutMargins = true
            container.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
            return container
        }())
        stackView.addArrangedSubview({
            let container = UIView(UILabel("Custom Layout margins: 32"), guide: .layoutMargins)
            container.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
            container.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            return container
        }())
        stackView.addArrangedSubview({
            let container = UIView(UILabel("Safe Area margins"), guide: .safeArea)
            container.backgroundColor = UIColor.cyan.withAlphaComponent(0.3)
            return container
        }())
        stackView.addArrangedSubview({
            let container = UIView(UILabel("Readable Content margins"), guide: .readableContent)
            container.preservesSuperviewLayoutMargins = true
            container.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            return container
        }())
    }

    @IBAction func toggleGrid() {
        gridViews.forEach { $0.isHidden.toggle() }
    }

    // MARK: - Private

    private func setupScrollView() {
        scrollView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.preservesSuperviewLayoutMargins = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }

    private func setupGrid() {
        gridViews = UIView.LayoutGuide.allCases.map { (guide: UIView.LayoutGuide) -> UIView in
            let grid = UIView()
            grid.backgroundColor = .clear
            grid.layer.borderWidth = 1
            grid.layer.borderColor = UIColor.gray.cgColor
            view.addContent(grid, guide: guide)
            return grid
        }
    }

}

// MARK: - Helpers

extension UILabel {
    convenience init(_ text: String) {
        self.init()
        self.text = text
        self.font = UIFont.preferredFont(forTextStyle: .title2)
    }
}

extension UIView {
    enum LayoutGuide: CaseIterable {
        case safeArea
        case layoutMargins
        case readableContent
    }

    convenience init(_ view: UIView, guide: LayoutGuide) {
        self.init()
        self.addContent(view, guide: guide)
    }

    convenience init(_ view: UIView) {
        self.init()
        self.addContent(view)
    }

    func addContent(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }

    func addContent(_ view: UIView, guide: LayoutGuide) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let guide: UILayoutGuide = {
            switch guide {
            case .safeArea:
                return self.safeAreaLayoutGuide
            case .layoutMargins:
                return self.layoutMarginsGuide
            case .readableContent:
                return self.readableContentGuide
            }
        }()
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: guide.topAnchor),
            view.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: guide.leadingAnchor)
        ])
    }
}
