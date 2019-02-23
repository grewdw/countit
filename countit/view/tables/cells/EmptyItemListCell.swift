//
//  EmptyItemListCell.swift
//  countit
//
//  Created by David Grew on 10/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class EmptyItemListCell: UITableViewCell {
    
    let BORDER_PADDING_TOP: CGFloat = 15
    let BORDER_PADDING_LEFT: CGFloat = 15
    let BORDER_PADDING_RIGHT: CGFloat = -15
    
    let TEXT_PADDING_LEFT: CGFloat = 40
    let TEXT_PADDING_RIGHT: CGFloat = -40
    
    let ARROW_PADDING_TOP: CGFloat = 5
    let ARROW_PADDING_BOTTOM: CGFloat = -5
    let ARROW_PADDING_RIGHT: CGFloat = -10
    let ARROW_WIDTH: CGFloat = 25
    let ARROW_HEIGHT: CGFloat = 50
    
    private let CELL_TEXT = "Create a target to start"
    
    init() {
        super.init(style: .default, reuseIdentifier: "EmptyItemListCell")
        
        backgroundColor = Colors.TABLE_BACKGROUND
        selectionStyle = .none
        accessibilityIdentifier = AccessibilityIdentifiers.EMPTY_ITEM_LIST_CELL
        
        let border = Border()
        let text = UILabel()
        let arrow = UIImageView(image: UIImage(named: "EmptyCellArrow"))
        
        text.text = CELL_TEXT
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.textColor = UIColor.lightGray
        text.numberOfLines = 0
        text.textAlignment = .center
        
        addSubview(border)
        addSubview(text)
        addSubview(arrow)
        border.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            border.leftAnchor.constraint(equalTo: leftAnchor, constant: BORDER_PADDING_LEFT),
            border.rightAnchor.constraint(equalTo: rightAnchor, constant: BORDER_PADDING_RIGHT),
            border.topAnchor.constraint(equalTo: topAnchor, constant: BORDER_PADDING_TOP),
            border.bottomAnchor.constraint(equalTo: bottomAnchor),
            text.centerYAnchor.constraint(equalTo: arrow.centerYAnchor),
            text.leftAnchor.constraint(equalTo: leftAnchor, constant: TEXT_PADDING_LEFT),
            text.rightAnchor.constraint(equalTo: rightAnchor, constant: TEXT_PADDING_RIGHT),
            arrow.topAnchor.constraint(equalTo: border.topAnchor, constant: ARROW_PADDING_TOP),
            arrow.bottomAnchor.constraint(equalTo: border.bottomAnchor, constant: ARROW_PADDING_BOTTOM),
            arrow.rightAnchor.constraint(equalTo: border.rightAnchor, constant: ARROW_PADDING_RIGHT),
            arrow.heightAnchor.constraint(equalToConstant: ARROW_HEIGHT),
            arrow.widthAnchor.constraint(equalToConstant: ARROW_WIDTH)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
