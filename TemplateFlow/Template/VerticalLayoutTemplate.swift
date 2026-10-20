//
//  VerticalLayoutTemplate.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import Foundation

class VerticalLayoutTemplate: NSObject, LayoutTemplate {

    struct LayoutMetrics {

        let topMargin: CGFloat

        let leftMargin: CGFloat

        let rightMargin: CGFloat

        let verticalSpacing: CGFloat

        let height: CGFloat

        init(topMargin: CGFloat, leftMargin: CGFloat, rightMargin: CGFloat, verticalSpacing: CGFloat, height: CGFloat) {
            self.topMargin = topMargin
            self.leftMargin = leftMargin
            self.rightMargin = rightMargin
            self.verticalSpacing = verticalSpacing
            self.height = height
        }

        static let defaultMetrics: LayoutMetrics = .init(topMargin: 0, leftMargin: 0, rightMargin: 0, verticalSpacing: 30, height: 100)
    }

    static let defaultTemplate: VerticalLayoutTemplate = .init()

    func layout(controlView: ControlBaseView, index: Int, startPoint: CGPoint, endPoint: CGPoint) {
        layout(controlView: controlView, index: index, startPoint: startPoint, endPoint: endPoint, metrics: .defaultMetrics)
    }

    func layout(controlView: ControlBaseView, index: Int, startPoint: CGPoint, endPoint: CGPoint, metrics: LayoutMetrics) {
        controlView.frame = .init(x: startPoint.x + metrics.leftMargin,
                                  y: startPoint.y + metrics.topMargin + CGFloat(index) * (metrics.height + metrics.verticalSpacing),
                                  width: endPoint.x - startPoint.x - metrics.leftMargin - metrics.rightMargin,
                                  height: metrics.height)
    }
}
