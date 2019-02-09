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
    let NAME_PADDING_LEFT: CGFloat = 60
    let NAME_PADDING_RIGHT: CGFloat = -60
    let MORE_INFO_PADDING_TOP: CGFloat = 15
    let MORE_INFO_PADDING_RIGHT: CGFloat = -27.5
    let MORE_INFO_HEIGHT: CGFloat = 25
    let MORE_INFO_WIDTH: CGFloat = 25
    let ACTION_BUTTON_PADDING_TOP: CGFloat = 37.5
    let ACTION_BUTTON_PADDING_LEFT: CGFloat = 25
    let ACTION_BUTTON_PADDING_RIGHT: CGFloat = -25
    let ACTION_BUTTON_HEIGHT: CGFloat = 25
    let PROGRESS_SECTION_PADDING_LEFT: CGFloat = 25
    let PROGRESS_SECTION_PADDING_RIGHT: CGFloat = -25
    let PROGRESS_SECTION_PADDING_TOP: CGFloat = 62.5
    let PROGRESS_SECTION_PADDING_BOTTOM: CGFloat = 10

    let HEIGHT_ZERO: CGFloat = 0
    
    var alwaysConstraints: [NSLayoutConstraint] = []
    var closedConstraints: [NSLayoutConstraint] = []
    var progressConstraints: [NSLayoutConstraint] = []
    
    let item: ItemSummaryDto
    let delegate: ProgressTableController
    
    var border: Border?
    var name: Name?
    var moreInfo: ActionButton?
    var actionButtonRow: ActionButtonRow?
    var progressSection: ProgressSection?
    
    var nameHeight: CGFloat?
    
    var state: ItemCellState = .CLOSED
    
    init(item: ItemSummaryDto, delegate: ProgressTableController, state: ItemCellState) {
        self.item = item
        self.delegate = delegate
        self.state = state
        super.init(style: .default, reuseIdentifier: "itemCell")
        
        self.backgroundColor = Colours.TABLE_BACKGROUND
        self.selectionStyle = .none
        
        let progressDelegate = ProgressDelegate(delegate: self, item: item)
        
        border = Border()
        name = Name(item: item, cellWidth: self.bounds.width)
        moreInfo = ActionButton(buttonPressAction: self.MoreInfoButtonPressed, image: UIImage(named: "MoreInfoIcon")!, selectedImage: nil)
        actionButtonRow = progressDelegate.getActionButtons()
        progressSection = progressDelegate.getProgressSection()
        nameHeight = name!.getHeight()
        
        self.addSubview(border!)
        self.addSubview(name!)
        self.addSubview(moreInfo!)
        self.addSubview(actionButtonRow!)
        self.addSubview(progressSection!)
        border!.translatesAutoresizingMaskIntoConstraints = false
        name!.translatesAutoresizingMaskIntoConstraints = false
        moreInfo!.translatesAutoresizingMaskIntoConstraints = false
        actionButtonRow!.translatesAutoresizingMaskIntoConstraints = false
        progressSection!.translatesAutoresizingMaskIntoConstraints = false
        
        createAlwaysConstraints()
        createClosedConstraints()
        createProgressConstraints()
        
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
        alwaysConstraints.append(progressSection!.leftAnchor.constraint(equalTo: leftAnchor, constant: PROGRESS_SECTION_PADDING_LEFT))
        alwaysConstraints.append(progressSection!.rightAnchor.constraint(equalTo: rightAnchor, constant: PROGRESS_SECTION_PADDING_RIGHT))
        alwaysConstraints.append(progressSection!.topAnchor.constraint(equalTo: topAnchor, constant: PROGRESS_SECTION_PADDING_TOP + nameHeight!))
        alwaysConstraints.append(border!.bottomAnchor.constraint(equalTo: progressSection!.bottomAnchor, constant: PROGRESS_SECTION_PADDING_BOTTOM))
    }
    
    func createClosedConstraints() {
        closedConstraints.append(progressSection!.heightAnchor.constraint(equalToConstant: 0))
    }
    
    func createProgressConstraints() {
        progressConstraints.append(progressSection!.heightAnchor.constraint(equalToConstant: 59.5))
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
        NSLayoutConstraint.activate(progressConstraints)
    }
    
    func transitionClosedToProgress() {
        NSLayoutConstraint.deactivate(closedConstraints)
        NSLayoutConstraint.activate(progressConstraints)
        delegate.updateTableHeights()
        state = .PROGRESS
        delegate.stateChange(item: item, state: state)
    }
    
    func transitionProgressToClosed() {
        NSLayoutConstraint.activate(closedConstraints)
        NSLayoutConstraint.deactivate(progressConstraints)
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
        print("add")
    }
    
    func PlusOneButtonPressed() {
        delegate.recordActivityButtonPressedFor(item: item.getItemDetailsDto())
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
