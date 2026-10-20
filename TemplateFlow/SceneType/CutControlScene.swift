//
//  CutControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import Foundation

class CutControlScene: NSObject, ControlScene {

    var normalImageName: String {
        "motion_cut_n"
    }

    var selectedImageName: String {
        "motion_cut_p"
    }

    var title: String {
        "切割"
    }

    let allControlGroups: [ControlGroup] = [
        ControlGroup(kind: .cutUp, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "上"),
            SliderControlModel(minValue: 0, maxValue: 100, value: 50, name: "角度")
        ]),
        ControlGroup(kind: .cutDown, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "下"),
            SliderControlModel(minValue: 0, maxValue: 100, value: 50, name: "角度")
        ]),
        ControlGroup(kind: .cutLeft, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "左"),
            SliderControlModel(minValue: 0, maxValue: 100, value: 50, name: "角度")
        ]),
        ControlGroup(kind: .cutRight, layoutTemplate: VerticalLayoutTemplate.defaultTemplate, controls: [
            SliderControlModel(minValue: 0, maxValue: 10, value: 5, name: "右"),
            SliderControlModel(minValue: 0, maxValue: 100, value: 50, name: "角度")
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
            if capabilities.cutPositionCapability == 0 && capabilities.cutAngleCapability == 0 {
                continue
            }
            var supportedControls: [ControlModel] = []
            if capabilities.cutPositionCapability > 0 {
                supportedControls.append(groupModel.allControls[0])
            }
            if capabilities.cutAngleCapability > 0 {
                supportedControls.append(groupModel.allControls[1])
            }
            groupModel.supportedControls = supportedControls
            supportedControlGroups.append(groupModel)
        }
        self.supportedControlGroups = supportedControlGroups
    }
}
