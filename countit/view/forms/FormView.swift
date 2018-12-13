//
//  FormView.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

protocol FormView {
    
    associatedtype formType
    
    var formDelegate: FormController? { get set }
    var editable: Bool { get set }
    
    func initialiseNavBar(for controller: FormController)
    
    func getForm() -> formType
    
    func updateForm(_ form: formType)
    
    func clearForm()
}
