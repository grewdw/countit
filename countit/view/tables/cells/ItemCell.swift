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
    let ACTION_BUTTON_PADDING_TOP: CGFloat = 27.5
    let ACTION_BUTTON_PADDING_LEFT: CGFloat = 25
    let ACTION_BUTTON_PADDING_RIGHT: CGFloat = -25
    let ACTION_BUTTON_HEIGHT: CGFloat = 50
    let PROGRESS_SECTION_PADDING_LEFT: CGFloat = 25
    let PROGRESS_SECTION_PADDING_RIGHT: CGFloat = -25
    let PROGRESS_SECTION_PADDING_TOP: CGFloat = 90
    let PROGRESS_SECTION_PADDING_BOTTOM: CGFloat = 0

    let HEIGHT_ZERO: CGFloat = 0
    let HEIGHT_PROGRESS: CGFloat = 100
    let HEIGHT_ADD: CGFloat = 250
    
    var alwaysConstraints: [NSLayoutConstraint] = []
    var currentConstraints: [NSLayoutConstraint] = []
    var closedConstraints: [NSLayoutConstraint] = []
    var progressConstraints: [NSLayoutConstraint] = []
    var addConstraints: [NSLayoutConstraint] = []
    
    let item: ItemProgressSummaryDto
    let delegate: ProgressTableController
    
    var border: Border?
    var detailsSection: DetailsSection?
    var buttonSection: ButtonSection?
    var progressSection: ProgressSection?
    
    var detailsSectionHeight: CGFloat?
    
    var state: ItemCellState = .CLOSED
    var currentSection: UIView?
    
    init(item: ItemProgressSummaryDto, delegate: ProgressTableController, state: ItemCellState) {
        self.item = item
        self.delegate = delegate
        self.state = state
        super.init(style: .default, reuseIdentifier: "itemCell")
        
        self.backgroundColor = Colors.TABLE_BACKGROUND
        self.selectionStyle = .none
        
        let progressDelegate = ProgressDelegate(delegate: self, item: item, cellWidth: bounds.width)
        
        border = Border()
        detailsSection = progressDelegate.getDetailsSection()
        buttonSection = progressDelegate.getActionButtons()
        progressSection = progressDelegate.getProgressSection()
        
        detailsSectionHeight = detailsSection!.getHeight()
        
        self.addSubview(border!)
        self.addSubview(detailsSection!)
        self.addSubview(buttonSection!)
        border!.translatesAutoresizingMaskIntoConstraints = false
        detailsSection!.translatesAutoresizingMaskIntoConstraints = false
        buttonSection!.translatesAutoresizingMaskIntoConstraints = false
        progressSection!.translatesAutoresizingMaskIntoConstraints = false
        
        createAlwaysConstraints()
        createClosedConstraints()
        
        switch state {
        case .CLOSED:
            setToClosed()
        case .PROGRESS:
            setTo(section: progressSection!, height: HEIGHT_PROGRESS)
        case .PERFORMANCE:
            setToClosed()
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
    }
    
    func createClosedConstraints() {
        closedConstraints.append(border!.bottomAnchor.constraint(equalTo: topAnchor, constant: PROGRESS_SECTION_PADDING_TOP + detailsSectionHeight!))
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
    
    func setTo(section: UIView, height: CGFloat) {
        addSubview(section)
        currentSection = section
        populateCurrentConstraintsFor(section: section, height: height)
        NSLayoutConstraint.activate(alwaysConstraints)
        NSLayoutConstraint.activate(currentConstraints)
    }
    
    func transitionToClosed() {
        NSLayoutConstraint.activate(closedConstraints)
        NSLayoutConstraint.deactivate(currentConstraints)
        currentSection?.removeFromSuperview()
        delegate.updateCellHeights()
        state = .CLOSED
        delegate.itemCellStateChange(item: item, state: state)
        currentSection = nil
        currentConstraints.removeAll()
    }
    
    func transitionFromClosed(section: UIView, newState: ItemCellState, height: CGFloat) {
        addSubview(section)
        currentSection = section
        populateCurrentConstraintsFor(section: section, height: height)
        NSLayoutConstraint.activate(currentConstraints)
        NSLayoutConstraint.deactivate(closedConstraints)
        delegate.updateCellHeights()
        state = newState
        delegate.itemCellStateChange(item: item, state: state)
    }
    
    private func populateCurrentConstraintsFor(section: UIView, height: CGFloat) {
        currentConstraints.append(border!.bottomAnchor.constraint(equalTo: section.bottomAnchor))
        currentConstraints.append(section.heightAnchor.constraint(equalToConstant: height))
        currentConstraints.append(section.leftAnchor.constraint(equalTo: leftAnchor, constant: PROGRESS_SECTION_PADDING_LEFT))
        currentConstraints.append(section.rightAnchor.constraint(equalTo: rightAnchor, constant: PROGRESS_SECTION_PADDING_RIGHT))
        currentConstraints.append(section.topAnchor.constraint(equalTo: topAnchor, constant: PROGRESS_SECTION_PADDING_TOP + detailsSectionHeight!))
    }
        
}

extension ItemCell: ItemCellButtonDelegate {
    func moreInfoButtonPressed() {
        delegate.itemSelected(itemDetails: item.getItemDetailsDto())
    }
    
    func plusOneButtonPressed() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        delegate.recordActivityFor(item: item.getItemDetailsDto(), value: 1, timestamp: nil)
    }
    
    func activityHistoryButtonPressed() {
        delegate.transitionToActivityHistoryControllerFor(item: item.getItemDetailsDto().getId())
    }
    
    func performanceButtonPressed() {
        print("Performance")
    }
    
    func addButtonPressed() {
        delegate.transitionToRecordActivityFormControllerFor(item: item.getItemDetailsDto())
    }
    
    func progressButtonPressed() {
        transition(section: progressSection!, state: .PROGRESS, height: HEIGHT_PROGRESS)
    }
    
    private func transition(section: UIView, state: ItemCellState, height: CGFloat) {
        if let _ = currentSection {
            if currentSection == section {
                transitionToClosed()
            }
            else {
                transitionToClosed()
                transitionFromClosed(section: section, newState: state, height: height)
            }
        }
        else {
            transitionFromClosed(section: section, newState: state, height: height)
        }
    }
}
