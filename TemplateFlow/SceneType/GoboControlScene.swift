//
//  GoboControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import Foundation

class GoboControlScene: NSObject, ControlScene {

    var normalImageName: String {
        "motion_gobo_n"
    }

    var selectedImageName: String {
        "motion_gobo_p"
    }

    var title: String {
        "图案"
    }

    let allControlGroups: [ControlGroup] = [
        ControlGroup(kind: .goboFigure, layoutTemplate: FillLayoutTemplate.defaultTemplate, controls: [
            PatternSelectionModel(value: 0, patternCount: 10)
        ]),
        ControlGroup(kind: .goboSpeed, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 100, value: 50, name: "速度设置"),
            SwitchControlModel(isOn: true)
        ])
    ]

    var supportedControlGroups: [ControlGroup] = []

    override init() {
        super.init()
        supportedControlGroups = allControlGroups
    }

    required init(capabilities: DeviceCapabilities) {
        super.init()
        updateSupportedControls(using: capabilities)
    }

    func updateSupportedControls(using capabilities: DeviceCapabilities) {
        var supportedControlGroups: [ControlGroup] = []
        if capabilities.goboPatternCapability > 0 {
            supportedControlGroups.append(allControlGroups[0])
        }
        if capabilities.goboSpeedCapability > 0 {
            supportedControlGroups.append(allControlGroups[1])
        }
        self.supportedControlGroups = supportedControlGroups
    }
}
