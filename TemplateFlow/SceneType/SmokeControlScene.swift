//
//  SmokeControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class SmokeControlScene: NSObject, ControlScene {

    var normalImageName: String {
        "motion_smoke_n"
    }

    var selectedImageName: String {
        "motion_smoke_p"
    }

    var title: String {
        "烟雾"
    }

    let allControlGroups: [ControlGroup] = {
        let onOffModel = SwitchControlModel(isOn: true)
        var ret: [ControlGroup] = [
            ControlGroup(kind: .smokeWind, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
                SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "风量"),
                onOffModel
            ]),
            ControlGroup(kind: .smokeFog, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
                SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "烟雾"),
                onOffModel
            ]),
            ControlGroup(kind: .smokeTime, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
                SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "间隔"),
                onOffModel
            ])
        ]
        return ret
    }()

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
        for groupModel in allControlGroups {
            if capabilities.smokeCapability > 0 {
                supportedControlGroups.append(groupModel)
            }
        }
        self.supportedControlGroups = supportedControlGroups
    }
}
