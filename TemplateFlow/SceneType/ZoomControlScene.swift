//
//  ZoomControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import Foundation

class ZoomControlScene: NSObject, ControlScene {

    var normalImageName: String {
        "motion_zoom_n"
    }

    var selectedImageName: String {
        "motion_zoom_p"
    }

    var title: String {
        "变焦"
    }

    let allControlGroups: [ControlGroup] = [
        ControlGroup(kind: .zoomAngle, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 1, maxValue: 90, value: 45, name: "变焦")
        ]),
        ControlGroup(kind: .zoomBlur, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 1, maxValue: 10, value: 5, name: "模糊")
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
        for groupModel in allControlGroups {
            if capabilities.zoomAngleCapability > 0 && groupModel.kind == .zoomAngle {
                supportedControlGroups.append(groupModel)
            }
            if capabilities.zoomBlurCapability > 0 && groupModel.kind == .zoomBlur {
                supportedControlGroups.append(groupModel)
            }
        }
        self.supportedControlGroups = supportedControlGroups
    }
}
