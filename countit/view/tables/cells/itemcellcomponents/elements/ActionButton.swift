//
//  AddButton.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    private let buttonPressAction: () -> Void
    private let image: UIImage
    
    init(buttonPressAction: @escaping () -> Void, image: UIImage, accessibilityIdentifier: String) {
        self.buttonPressAction = buttonPressAction
        self.image = image
        super.init(frame: CGRect())
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        buttonPressAction()
    }
}
