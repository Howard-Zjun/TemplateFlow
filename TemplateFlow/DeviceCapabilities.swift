//
//  DeviceCapabilities.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import UIKit

/// 设备功能能力值；当前以大于 0 表示支持，保留原始整数语义。
class DeviceCapabilities: NSObject {

    var lateralRotationCapability: Int = 1

    var pitchRotationCapability: Int = 1

    var zoomAngleCapability: Int = 1

    var zoomBlurCapability: Int = 1

    var cutAngleCapability: Int = 1

    var zoomMin: Int = 1

    var zoomMax: Int = 1

    var cutPositionCapability: Int = 1

    var barndoorCapability: Int = 1

    var goboPatternCapability: Int = 1

    var goboSpeedCapability: Int = 1

    var smokeCapability: Int = 1

    var lateralLockCapability: Int = 1

    var pitchLockCapability: Int = 1
}
