//
//  SwitchControlModel.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class SwitchControlModel: ControlModel {

    var value: Int = 0

    var reuseIdentifier: String {
        NSStringFromClass(Self.self)
    }

    init(isOn: Bool) {
        value = isOn ? 1 : 0
    }
}
