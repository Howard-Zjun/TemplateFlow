//
//  FillLayoutTemplate.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class FillLayoutTemplate: NSObject, LayoutTemplate {

    static let defaultTemplate: FillLayoutTemplate = .init()

    func layout(controlView: ControlBaseView, index: Int, startPoint: CGPoint, endPoint: CGPoint) {
        if index == 0 {
            controlView.frame = .init(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
        }
    }
}
