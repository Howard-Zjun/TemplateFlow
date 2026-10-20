//
//  BarndoorControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import Foundation

class BarndoorControlScene: NSObject, ControlScene {

    var normalImageName: String {
        "motion_barndoor_n"
    }

    var selectedImageName: String {
        "motion_barndoor_p"
    }

    var title: String {
        "遮光板"
    }

    let allControlGroups: [ControlGroup] = [
        ControlGroup(kind: .cutUp, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "上")
        ]),
        ControlGroup(kind: .cutDown, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "下")
        ]),
        ControlGroup(kind: .cutLeft, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "左")
        ]),
        ControlGroup(kind: .cutRight, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "右")
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
        for controlModel in allControlGroups {
            if capabilities.barndoorCapability > 0 {
                supportedControlGroups.append(controlModel)
            }
        }
        self.supportedControlGroups = supportedControlGroups
    }
}
