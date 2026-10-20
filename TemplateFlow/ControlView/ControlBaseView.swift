//
//  ControlBaseView.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import UIKit

class ControlBaseView: UIView {

    var isInUse: Bool = false {
        didSet {
            isHidden = !isInUse
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = !isInUse
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
