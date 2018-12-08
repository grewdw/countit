//
//  ButtonBuilder.swift
//  GuitarPracticeApp
//
//  Created by David Grew on 25/10/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NavBarButtonBuilder {
    
    func getAddButton(_ target: NavBarButtonDelegate) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: target, action: #selector(addButtonPressed))
    }
    
    func getCancelButton(_ target: NavBarButtonDelegate) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: #selector(cancelButtonPressed))
    }
    
    func getDoneButton(_ target: NavBarButtonDelegate) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: target, action: #selector(doneButtonPressed))
    }
    
    func getEditButton(_ target: NavBarButtonDelegate) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .edit, target: target, action: #selector(editButtonPressed))
    }
    
    func getSaveButton(_ target: NavBarButtonDelegate) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .save, target: target, action: #selector(saveButtonPressed))
    }
    
    @objc func addButtonPressed() {
    }
    @objc func cancelButtonPressed() {
    }
    @objc func doneButtonPressed() {
    }
    @objc func editButtonPressed() {
    }
    @objc func saveButtonPressed() {
    }
}

protocol NavBarButtonDelegate {

}

