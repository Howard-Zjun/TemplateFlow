//
//  SliderControlModel.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class SliderControlModel: ControlModel {

    var value: Int = 0

    var reuseIdentifier: String {
        NSStringFromClass(Self.self)
    }

    var minValue: Int = 0

    var maxValue: Int = 100

    var name: String = ""

    init(minValue: Int, maxValue: Int, value: Int, name: String) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.value = value
        self.name = name
    }
}
