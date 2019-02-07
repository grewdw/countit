//
//  AddButton.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    let buttonPressAction: () -> Void
    
    let image: UIImage
    let selectedImage: UIImage?
    
    var active: Bool = false
    
    init(buttonPressAction: @escaping () -> Void, image: UIImage, selectedImage: UIImage?) {
        self.buttonPressAction = buttonPressAction
        self.image = image
        self.selectedImage = selectedImage
        super.init(frame: CGRect())
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        if selectedImage != nil {
            if active {
                setImage(image, for: .normal)
            }
            else {
                setImage(selectedImage, for: .normal)
            }
        }
        active = !active
        buttonPressAction()
    }
}
