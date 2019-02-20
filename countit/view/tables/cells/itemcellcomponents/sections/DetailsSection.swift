//
//  NameRow.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class DetailsSection: UIView {
    
    let DETAILS_PADDING_LEFT: CGFloat = 50
    let DETAILS_PADDING_RIGHT: CGFloat = -50
    let MORE_INFO_HEIGHT: CGFloat = 25
    let MORE_INFO_WIDTH: CGFloat = 25
    
    var cellHeight: CGFloat?
    
    init(delegate: ItemCellButtonDelegate, item: ItemDetailsDto, percentage: String, percentageColor: ProgressBarColor, cellWidth: CGFloat) {
        super.init(frame: CGRect())
        
        let details = setupDetailsStackView(name: setup(name: item.getName(), cellWidth: cellWidth),
                                            target: setup(target: "\(item.getDirection().rawValue) \(item.getValue()) a \(item.getTimePeriod().rawValue.lowercased())", cellWidth: cellWidth))
        let moreInfo = ActionButton(buttonPressAction: delegate.MoreInfoButtonPressed,
                                    image: UIImage(named: "MoreInfoIcon")!,
                                    accessibilityIdentifier: AccessibilityIdentifiers.ITEM_CELL_MOREINFO_BUTTON)
        let percentageLabel = UILabel()
        
        percentageLabel.text = "\(percentage)%"
        percentageLabel.textColor = get(color: percentageColor)
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        percentageLabel.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_CELL_PROGRESS_PERCENTAGE
        
        addSubview(details)
        addSubview(moreInfo)
        addSubview(percentageLabel)
        details.translatesAutoresizingMaskIntoConstraints = false
        moreInfo.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: topAnchor),
            details.bottomAnchor.constraint(equalTo: bottomAnchor),
            details.leftAnchor.constraint(equalTo: leftAnchor, constant: DETAILS_PADDING_LEFT),
            details.rightAnchor.constraint(equalTo: rightAnchor, constant: DETAILS_PADDING_RIGHT),
            moreInfo.topAnchor.constraint(equalTo: topAnchor),
            moreInfo.rightAnchor.constraint(equalTo: rightAnchor),
            moreInfo.heightAnchor.constraint(equalToConstant: MORE_INFO_HEIGHT),
            moreInfo.widthAnchor.constraint(equalToConstant: MORE_INFO_WIDTH),
            percentageLabel.leftAnchor.constraint(equalTo: leftAnchor),
            percentageLabel.topAnchor.constraint(equalTo: topAnchor)
            
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
        nameLabel.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_CELL_NAME
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
        targetLabel.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_CELL_TARGET
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
    
    func get(color: ProgressBarColor) -> UIColor {
        switch color {
        case .BLUE:
            return Colors.PROGRESS_BLUE
        case .GREEN:
            return Colors.PROGRESS_GREEN
        case .YELLOW:
            return Colors.PROGRESS_YELLOW
        case .RED:
            return Colors.PROGRESS_RED
        }
    }
}

