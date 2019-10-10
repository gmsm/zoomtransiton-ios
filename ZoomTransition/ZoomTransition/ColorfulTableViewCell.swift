//
//  ColorfulTableViewCell.swift
//  ZoomTransition
//
//  Created by Glauco Moraes on 10/10/19.
//  Copyright © 2019 Glauco. All rights reserved.
//

import UIKit

class ColorfulTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    var cardView: UIView!
    
    // MARK: - Initialization
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGraphic()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Methods

    private func setupGraphic() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        let cardView = UIView()
        cardView.backgroundColor = .blue
        cardView.layer.cornerRadius = 12.0
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.cardView = cardView
        self.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
    }
}
