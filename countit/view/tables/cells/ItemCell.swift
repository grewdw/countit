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
    let DETAILS_PADDING_LEFT: CGFloat = 27.5
    let DETAILS_PADDING_RIGHT: CGFloat = -27.5
    let DETAILS_PADDING_TOP: CGFloat = 15
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
    var detailsSection: DetailsSection?
    var buttonSection: ButtonSection?
    var progressSection: ProgressSection?
    
    var detailsSectionHeight: CGFloat?
    
    var state: ItemCellState = .CLOSED
    
    init(item: ItemSummaryDto, delegate: ProgressTableController, state: ItemCellState) {
        self.item = item
        self.delegate = delegate
        self.state = state
        super.init(style: .default, reuseIdentifier: "itemCell")
        
        self.backgroundColor = Colors.TABLE_BACKGROUND
        self.selectionStyle = .none
        
        let progressDelegate = ProgressDelegate(delegate: self, item: item)
        
        border = Border()
        detailsSection = DetailsSection(delegate: self, item: item.getItemDetailsDto(), cellWidth: bounds.width)
        buttonSection = progressDelegate.getActionButtons()
        progressSection = progressDelegate.getProgressSection()
        
        detailsSectionHeight = detailsSection!.getHeight()
        
        self.addSubview(border!)
        self.addSubview(detailsSection!)
        self.addSubview(buttonSection!)
        self.addSubview(progressSection!)
        border!.translatesAutoresizingMaskIntoConstraints = false
        detailsSection!.translatesAutoresizingMaskIntoConstraints = false
        buttonSection!.translatesAutoresizingMaskIntoConstraints = false
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
        alwaysConstraints.append(detailsSection!.leftAnchor.constraint(equalTo: leftAnchor, constant: DETAILS_PADDING_LEFT))
        alwaysConstraints.append(detailsSection!.rightAnchor.constraint(equalTo: rightAnchor, constant: DETAILS_PADDING_RIGHT))
        alwaysConstraints.append(detailsSection!.topAnchor.constraint(equalTo: topAnchor, constant: DETAILS_PADDING_TOP))
        alwaysConstraints.append(buttonSection!.topAnchor.constraint(equalTo: topAnchor, constant:  ACTION_BUTTON_PADDING_TOP + detailsSectionHeight!))
        alwaysConstraints.append(buttonSection!.leftAnchor.constraint(equalTo: leftAnchor, constant: ACTION_BUTTON_PADDING_LEFT))
        alwaysConstraints.append(buttonSection!.rightAnchor.constraint(equalTo: rightAnchor, constant: ACTION_BUTTON_PADDING_RIGHT))
        alwaysConstraints.append(buttonSection!.heightAnchor.constraint(equalToConstant: ACTION_BUTTON_HEIGHT))
        alwaysConstraints.append(progressSection!.leftAnchor.constraint(equalTo: leftAnchor, constant: PROGRESS_SECTION_PADDING_LEFT))
        alwaysConstraints.append(progressSection!.rightAnchor.constraint(equalTo: rightAnchor, constant: PROGRESS_SECTION_PADDING_RIGHT))
        alwaysConstraints.append(progressSection!.topAnchor.constraint(equalTo: topAnchor, constant: PROGRESS_SECTION_PADDING_TOP + detailsSectionHeight!))
        alwaysConstraints.append(border!.bottomAnchor.constraint(equalTo: progressSection!.bottomAnchor, constant: PROGRESS_SECTION_PADDING_BOTTOM))
    }
    
    func createClosedConstraints() {
        closedConstraints.append(progressSection!.heightAnchor.constraint(equalToConstant: HEIGHT_ZERO))
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
        delegate.updateCellHeights()
        state = .PROGRESS
        delegate.itemCellStateChange(item: item, state: state)
    }
    
    func transitionProgressToClosed() {
        NSLayoutConstraint.activate(closedConstraints)
        NSLayoutConstraint.deactivate(progressConstraints)
        delegate.updateCellHeights()
        state = .CLOSED
        delegate.itemCellStateChange(item: item, state: state)
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
