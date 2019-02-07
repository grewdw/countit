//
//  ItemCell.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    let BORDER_PADDING_TOP: CGFloat = 7.5
    let BORDER_PADDING_BOTTOM: CGFloat = -7.5
    let BORDER_PADDING_LEFT: CGFloat = 15
    let BORDER_PADDING_RIGHT: CGFloat = -15
    let NAME_PADDING_TOP: CGFloat = 15
    let NAME_PADDING_LEFT: CGFloat = 50
    let NAME_PADDING_RIGHT: CGFloat = -50
    let MORE_INFO_PADDING_TOP: CGFloat = 15
    let MORE_INFO_PADDING_RIGHT: CGFloat = -27.5
    let MORE_INFO_HEIGHT: CGFloat = 25
    let MORE_INFO_WIDTH: CGFloat = 25
    let ACTION_BUTTON_PADDING_TOP: CGFloat = 37.5
    let ACTION_BUTTON_PADDING_BOTTOM: CGFloat = 15
    let ACTION_BUTTON_PADDING_LEFT: CGFloat = 25
    let ACTION_BUTTON_PADDING_RIGHT: CGFloat = -25
    let ACTION_BUTTON_HEIGHT: CGFloat = 25

    let HEIGHT_ZERO: CGFloat = 0
    
    var alwaysConstraints: [NSLayoutConstraint] = []
    var closedConstraints: [NSLayoutConstraint] = []
    var progressBorderConstraints: [NSLayoutConstraint] = []
    var progressLabelConstraints: [NSLayoutConstraint] = []
    
    let item: ItemSummaryDto
    let delegate: ProgressTableController
    
    var border: Border?
    var name: Name?
    var moreInfo: ActionButton?
    var actionButtonRow: ActionButtonRow?
    var label: UILabel?
    
    var nameHeight: CGFloat?
    var labelHeight: CGFloat?
    
    var state: ItemCellState = .CLOSED
    
    init(item: ItemSummaryDto, delegate: ProgressTableController, state: ItemCellState) {
        self.item = item
        self.delegate = delegate
        self.state = state
        super.init(style: .default, reuseIdentifier: "itemCell")
        
        self.backgroundColor = Colours.TABLE_BACKGROUND
        self.selectionStyle = .none
        
        border = Border()
        name = Name(name: item.getItemDetailsDto().getName())
        moreInfo = ActionButton(buttonPressAction: self.MoreInfoButtonPressed, image: UIImage(named: "MoreInfoIcon")!, selectedImage: nil)
        actionButtonRow = ActionButtonRow(delegate: self)
        label = UILabel()
        label?.text = "newTextThat is really long so it's definitely going to wrap around to the next line"
        label?.numberOfLines = 0
        nameHeight = name!.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        labelHeight = label!.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        
        self.addSubview(border!)
        self.addSubview(name!)
        self.addSubview(moreInfo!)
        self.addSubview(actionButtonRow!)
        self.addSubview(label!)
        border!.translatesAutoresizingMaskIntoConstraints = false
        name!.translatesAutoresizingMaskIntoConstraints = false
        moreInfo!.translatesAutoresizingMaskIntoConstraints = false
        actionButtonRow!.translatesAutoresizingMaskIntoConstraints = false
        label!.translatesAutoresizingMaskIntoConstraints = false
        
        createAlwaysConstraints()
        createClosedConstraints()
        createProgressBorderConstraints()
        createProgressLabelConstraints()
        
        if state == .CLOSED {
            setToClosed()
        }
        else {
            setToProgress()
        }
    }
    
    func createAlwaysConstraints() {
        alwaysConstraints.append(border!.leftAnchor.constraint(equalTo: leftAnchor, constant: BORDER_PADDING_LEFT))
        alwaysConstraints.append(border!.rightAnchor.constraint(equalTo: rightAnchor, constant: BORDER_PADDING_RIGHT))
        alwaysConstraints.append(border!.topAnchor.constraint(equalTo: topAnchor, constant: BORDER_PADDING_TOP))
        alwaysConstraints.append(border!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BORDER_PADDING_BOTTOM))
        alwaysConstraints.append(name!.leftAnchor.constraint(equalTo: leftAnchor, constant: NAME_PADDING_LEFT))
        alwaysConstraints.append(name!.rightAnchor.constraint(equalTo: rightAnchor, constant: NAME_PADDING_RIGHT))
        alwaysConstraints.append(name!.topAnchor.constraint(equalTo: topAnchor, constant: NAME_PADDING_TOP))
        alwaysConstraints.append(moreInfo!.topAnchor.constraint(equalTo: topAnchor, constant: MORE_INFO_PADDING_TOP))
        alwaysConstraints.append(moreInfo!.rightAnchor.constraint(equalTo: rightAnchor, constant: MORE_INFO_PADDING_RIGHT))
        alwaysConstraints.append(moreInfo!.heightAnchor.constraint(equalToConstant: MORE_INFO_HEIGHT))
        alwaysConstraints.append(moreInfo!.widthAnchor.constraint(equalToConstant: MORE_INFO_WIDTH))
        alwaysConstraints.append(actionButtonRow!.topAnchor.constraint(equalTo: topAnchor, constant:  ACTION_BUTTON_PADDING_TOP + nameHeight!))
        alwaysConstraints.append(actionButtonRow!.leftAnchor.constraint(equalTo: leftAnchor, constant: ACTION_BUTTON_PADDING_LEFT))
        alwaysConstraints.append(actionButtonRow!.rightAnchor.constraint(equalTo: rightAnchor, constant: ACTION_BUTTON_PADDING_RIGHT))
        alwaysConstraints.append(actionButtonRow!.heightAnchor.constraint(equalToConstant: ACTION_BUTTON_HEIGHT))
        alwaysConstraints.append(label!.leftAnchor.constraint(equalTo: border!.leftAnchor))
        alwaysConstraints.append(label!.rightAnchor.constraint(equalTo: border!.rightAnchor))
        alwaysConstraints.append(label!.topAnchor.constraint(equalTo: topAnchor, constant: ACTION_BUTTON_PADDING_TOP + ACTION_BUTTON_HEIGHT + ACTION_BUTTON_PADDING_BOTTOM + nameHeight!))
    }
    
    func createClosedConstraints() {
        closedConstraints.append(border!.bottomAnchor.constraint(equalTo: topAnchor, constant: ACTION_BUTTON_PADDING_TOP + ACTION_BUTTON_HEIGHT + ACTION_BUTTON_PADDING_BOTTOM + nameHeight!))
        closedConstraints.append(label!.heightAnchor.constraint(equalToConstant: 0))
    }
    
    func createProgressBorderConstraints() {
        progressBorderConstraints.append(border!.bottomAnchor.constraint(equalTo: label!.bottomAnchor, constant: 7.5))
    }
    
    func createProgressLabelConstraints() {
        progressLabelConstraints.append(label!.heightAnchor.constraint(equalToConstant: labelHeight!))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemCell {
    
    func setToClosed() {
        NSLayoutConstraint.activate(alwaysConstraints)
        NSLayoutConstraint.activate(closedConstraints)
    }
    
    func setToProgress() {
        NSLayoutConstraint.activate(alwaysConstraints)
        NSLayoutConstraint.activate(progressBorderConstraints)
        NSLayoutConstraint.activate(progressLabelConstraints)
    }
    
    func transitionClosedToProgress() {
        NSLayoutConstraint.deactivate(closedConstraints)
        NSLayoutConstraint.activate(progressBorderConstraints)
        delegate.updateTableHeights()
        NSLayoutConstraint.activate(progressLabelConstraints)
        delegate.updateTableHeights()
        state = .PROGRESS
        delegate.stateChange(item: item, state: state)
    }
    
    func transitionProgressToClosed() {
        NSLayoutConstraint.activate(closedConstraints)
        NSLayoutConstraint.deactivate(progressBorderConstraints)
        delegate.updateTableHeights()
        NSLayoutConstraint.deactivate(progressLabelConstraints)
        delegate.updateTableHeights()
        state = .CLOSED
        delegate.stateChange(item: item, state: state)
    }
}

extension ItemCell: ItemCellButtonDelegate {
    func MoreInfoButtonPressed() {
        delegate.itemSelected(itemDetails: item.getItemDetailsDto())
    }
    
    func AddButtonPressed() {
        delegate.recordActivityButtonPressedFor(item: item.getItemDetailsDto())
    }
    
    func PlusOneButtonPressed() {
        print("PlusOne")
    }
    
    func ProgressButtonPressed() {
        if state == .PROGRESS {
            transitionProgressToClosed()
        }
        else {
            transitionClosedToProgress()
        }
    }
    
    func PerformanceButtonPressed() {
        print("Performance")
    }
}

enum ItemCellState {
    
    case CLOSED
    case PROGRESS
    case PERFORMANCE
}
