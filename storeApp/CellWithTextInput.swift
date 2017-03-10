//
//  CellWithTextInput.swift
//  storeApp
//
//  Created by Kyle Smith on 3/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class CellWithTextInput: BaseTVCell {
    
    let textField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Test"
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .default
        return textField
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textField)
        
        _ = textField.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
