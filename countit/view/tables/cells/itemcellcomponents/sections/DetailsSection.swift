//
//  NameRow.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class DetailsSection: UIView {
    
    let DETAILS_PADDING_LEFT: CGFloat = 35
    let DETAILS_PADDING_RIGHT: CGFloat = -10
    let MORE_INFO_HEIGHT: CGFloat = 25
    let MORE_INFO_WIDTH: CGFloat = 25
    
    var cellHeight: CGFloat?
    
    init(delegate: ItemCellButtonDelegate, item: ItemDetailsDto, cellWidth: CGFloat) {
        super.init(frame: CGRect())
        
        let details = setupDetailsStackView(name: setup(name: item.getName(), cellWidth: cellWidth),
                                            target: setup(target: "\(item.getDirection().rawValue) \(item.getValue()) a \(item.getTimePeriod().rawValue.lowercased())", cellWidth: cellWidth))
        let moreInfo = ActionButton(buttonPressAction: delegate.MoreInfoButtonPressed, image: UIImage(named: "MoreInfoIcon")!)
        
        addSubview(details)
        addSubview(moreInfo)
        details.translatesAutoresizingMaskIntoConstraints = false
        moreInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: topAnchor),
            details.bottomAnchor.constraint(equalTo: bottomAnchor),
            details.leftAnchor.constraint(equalTo: leftAnchor, constant: DETAILS_PADDING_LEFT),
            details.rightAnchor.constraint(equalTo: moreInfo.leftAnchor, constant: DETAILS_PADDING_RIGHT),
            moreInfo.topAnchor.constraint(equalTo: topAnchor),
            moreInfo.rightAnchor.constraint(equalTo: rightAnchor),
            moreInfo.heightAnchor.constraint(equalToConstant: MORE_INFO_HEIGHT),
            moreInfo.widthAnchor.constraint(equalToConstant: MORE_INFO_WIDTH)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDetailsStackView(name: UILabel, target: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [name, target])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }
    
    private func setup(name: String, cellWidth: CGFloat) -> UILabel {
        let nameLabel = UILabel()
        nameLabel.attributedText = NSAttributedString(
            string: name,
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                ])
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        if cellHeight != nil {
            cellHeight! += nameLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        else {
            cellHeight = nameLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        return nameLabel
    }
    
    private func setup(target: String, cellWidth: CGFloat) -> UILabel {
        let targetLabel = UILabel()
        targetLabel.attributedText = NSAttributedString(
            string: target,
            attributes:[
                NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                ])
        targetLabel.textAlignment = .center
        targetLabel.numberOfLines = 0
        if cellHeight != nil {
            cellHeight! += targetLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        else {
            cellHeight = targetLabel.sizeThatFits(CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        return targetLabel
    }

    func getHeight() -> CGFloat {
        return cellHeight!
    }
}

