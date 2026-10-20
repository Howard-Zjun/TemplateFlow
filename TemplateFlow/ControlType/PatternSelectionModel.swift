//
//  PatternSelectionModel.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class PatternSelectionModel: ControlModel {

    /// 当前选中的图案索引，从 0 开始。
    var value: Int = 0

    var reuseIdentifier: String {
        NSStringFromClass(Self.self)
    }

    var patternCount: Int

    init(value: Int, patternCount: Int) {
        self.value = value
        self.patternCount = patternCount
    }
}
