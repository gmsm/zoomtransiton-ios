//
//  ViewController.swift
//  ZoomTransition
//
//  Created by Glauco Moraes on 10/10/19.
//  Copyright © 2019 Glauco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let coolColors = [UIColor.sunsetOrange, UIColor.sunGlow, UIColor.yellowGreen, UIColor.cynaCornflowerBlue, UIColor.darkLavender]
    
    var zoomTransitionManager: ZoomTransitionManager?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorfulTableViewCell.classForCoder(), forCellReuseIdentifier: "ColorfulCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - DetailsViewControllerDelegate

extension ViewController: DetailsViewControllerDelegate {
    
    private func pushToDetailsViewControllerFrom(row: Int) {
        let detailsViewController = DetailsViewController()
        detailsViewController.selectedRow = row
        detailsViewController.didGoBackDelegate = self
        detailsViewController.modalPresentationStyle = .overCurrentContext
        detailsViewController.modalTransitionStyle = .crossDissolve
        present(detailsViewController, animated: true, completion: nil)
    }

    func didGoBack() {
        UIView.animate(withDuration: 0.4, animations: {
            self.zoomTransitionManager?.cardView.frame = self.zoomTransitionManager!.cardViewFrame
            self.zoomTransitionManager?.cardView.layer.cornerRadius = 12.0
            
        }) { (shrinked) in
            self.zoomTransitionManager?.cardView.removeFromSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorfulCell", for: indexPath) as! ColorfulTableViewCell
        cell.cardView.backgroundColor = coolColors[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ColorfulTableViewCell else {return}
        
        let cardViewFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil)
        let copyOfCardView = UIView(frame: cardViewFrame!)
        copyOfCardView.layer.cornerRadius = 12.0
        copyOfCardView.backgroundColor = coolColors[indexPath.row]
        view.addSubview(copyOfCardView)
        
        zoomTransitionManager = ZoomTransitionManager(cardView: copyOfCardView, cardViewFrame: cardViewFrame!)
        
        UIView.animate(withDuration: 0.4, animations: {
            copyOfCardView.layer.cornerRadius = 0.0
            copyOfCardView.frame = self.view.frame
        }, completion: {(expanded) in
            self.pushToDetailsViewControllerFrom(row: indexPath.row)
        })
    }
}
