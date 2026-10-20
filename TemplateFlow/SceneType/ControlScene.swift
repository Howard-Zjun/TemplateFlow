//
//  ControlScene.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import Foundation

protocol ControlScene: AnyObject {

    var normalImageName: String { get }

    var selectedImageName: String { get }

    var title: String { get }

    var allControlGroups: [ControlGroup] { get }

    var supportedControlGroups: [ControlGroup] { get set }

    init(capabilities: DeviceCapabilities)

    func updateSupportedControls(using capabilities: DeviceCapabilities)
}
