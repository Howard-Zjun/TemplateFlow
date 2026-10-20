//
//  LayoutTemplate.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

protocol LayoutTemplate {

    func layout(controlView: ControlBaseView, index: Int, startPoint: CGPoint, endPoint: CGPoint)
}
