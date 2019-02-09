//
//  NameRow.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class Name: UIStackView {
    
    let nameLabel = UILabel()
    let targetLabel = UILabel()
    
    var nameHeight: CGFloat?
    var targetHeight: CGFloat?
    
    let cellWidth: CGFloat
    
    init(item: ItemSummaryDto, cellWidth: CGFloat) {
        self.cellWidth = cellWidth
        super.init(frame: CGRect())
        axis = .vertical
        distribution = .fillProportionally
        alignment = .center
        spacing = 5
        
        let itemDetails = item.getItemDetailsDto()
        setup(name: itemDetails.getName())
        setup(target: "\(itemDetails.getDirection().rawValue) \(itemDetails.getValue()) a \(itemDetails.getTimePeriod().rawValue.lowercased())")
        addArrangedSubview(nameLabel)
        addArrangedSubview(targetLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(name: String) {
        nameLabel.attributedText = NSAttributedString(
            string: name,
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                ])
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameHeight = nameLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    private func setup(target: String) {
        targetLabel.attributedText = NSAttributedString(
            string: target,
            attributes:[
                NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                ])
        targetLabel.textAlignment = .center
        targetLabel.numberOfLines = 0
        targetHeight = targetLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
    }

    func getHeight() -> CGFloat {
        let nameHeightUnwrapped = nameHeight ?? 0
        let targetHeightUnwrapped = targetHeight ?? 0
        return nameHeightUnwrapped + targetHeightUnwrapped
    }
}

