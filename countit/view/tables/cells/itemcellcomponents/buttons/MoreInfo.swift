//
//  MoreInfo.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class MoreInfo: UIButton {
    
    let delegate: ItemCellButtonDelegate
    
    init(delegate: ItemCellButtonDelegate) {
        self.delegate = delegate
        
        super.init(frame: CGRect())
        layer.cornerRadius = 12.5;
        layer.masksToBounds = true;
        backgroundColor = .blue
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        let circleOne = circle()
        let circleTwo = circle()
        let circleThree = circle()
        
        self.addSubview(circleOne)
        self.addSubview(circleTwo)
        self.addSubview(circleThree)
        circleOne.translatesAutoresizingMaskIntoConstraints = false
        circleTwo.translatesAutoresizingMaskIntoConstraints = false
        circleThree.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleOne.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            circleTwo.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            circleThree.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            circleOne.leftAnchor.constraint(equalTo: leftAnchor, constant: 2.5),
            circleTwo.leftAnchor.constraint(equalTo: circleOne.rightAnchor, constant: 2.5),
            circleThree.leftAnchor.constraint(equalTo: circleTwo.rightAnchor, constant: 2.5),
            circleOne.heightAnchor.constraint(equalToConstant: 5),
            circleOne.widthAnchor.constraint(equalToConstant: 5),
            circleTwo.heightAnchor.constraint(equalToConstant: 5),
            circleTwo.widthAnchor.constraint(equalToConstant: 5),
            circleThree.heightAnchor.constraint(equalToConstant: 5),
            circleThree.widthAnchor.constraint(equalToConstant: 5),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        delegate.MoreInfoButtonPressed()
    }
    
    private class circle: UIView {
        
        init() {
            super.init(frame: CGRect())
            layer.cornerRadius = 2.5;
            layer.masksToBounds = true;
            backgroundColor = .white
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
