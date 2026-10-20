//
//  ControlGroup.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

enum ControlGroupKind: String {
    case zoomAngle = "变焦角度"
    case zoomBlur = "变焦模糊"
    case cutUp = "上"
    case cutDown = "下"
    case cutLeft = "左"
    case cutRight = "右"
    case goboFigure = "图案"
    case goboSpeed = "速度设置"
    case smokeWind = "风量"
    case smokeFog = "烟雾"
    case smokeTime = "间隔"
}

class ControlGroup: NSObject {

    var kind: ControlGroupKind

    var layoutTemplate: LayoutTemplate

    var allControls: [ControlModel]

    var supportedControls: [ControlModel]

    init(kind: ControlGroupKind, layoutTemplate: LayoutTemplate, controls: [ControlModel]) {
        self.kind = kind
        self.layoutTemplate = layoutTemplate
        self.allControls = controls
        self.supportedControls = controls
    }

    func setValue(_ value: Int, atAllControlsIndex index: Int) {
        allControls[index].value = value
    }

    func setValue(_ value: Int, atSupportedControlsIndex index: Int) {
        supportedControls[index].value = value
    }

    func supportedValues() -> [Int] {
        return supportedControls.map({$0.value})
    }
}
