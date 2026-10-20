//
//  ControlViewFactory.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import UIKit

class ControlViewFactory: NSObject {

    private var reusableViewsByIdentifier: [String : [ControlBaseView]] = [:]

    private let lock = NSLock()

    func recycleAllViews() {
        lock.lock()
        for cachedControlViews in reusableViewsByIdentifier.values {
            for controlView in cachedControlViews {
                controlView.isInUse = false
            }
        }
        lock.unlock()
    }

    func makeOrReuseView(for controlModel: ControlModel, in containerView: UIView, size: CGSize? = nil) -> ControlBaseView? {
        var ret: ControlBaseView!
        var cachedControlViews = cachedViews(controlModel: controlModel)
        for controlBaseView in cachedControlViews {
            if !controlBaseView.isInUse {
                ret = controlBaseView
            }
        }
        if ret == nil {
            if let sliderModel = controlModel as? SliderControlModel {
                let size = size ?? .init(width: 300, height: 75)
                ret = ControlSliderView(frame: .init(origin: .zero, size: size), controlModel: sliderModel)
            } else if let switchModel = controlModel as? SwitchControlModel {
                let size = size ?? .init(width: 40, height: 40)
                ret = ControlOnOffView(frame: .init(origin: .zero, size: size), controlModel: switchModel)
            } else if let patternModel = controlModel as? PatternSelectionModel {
                let size = size ?? .init(width: 520, height: 782)
                ret = ControlFigureView(frame: .init(origin: .zero, size: size), controlModel: patternModel)
            } else {

            }
            DispatchQueue.main.async {
                containerView.addSubview(ret)
            }
        }
        if let ret = ret {
            cachedControlViews.append(ret)
            cacheViews(controlModel: controlModel, cachedControlViews: cachedControlViews)
        }
        ret.isInUse = true
        if let sliderView = ret as? ControlSliderView, let sliderModel = controlModel as? SliderControlModel {
            sliderView.controlModel = sliderModel
        } else if let controlOnOffView = ret as? ControlOnOffView, let switchModel = controlModel as? SwitchControlModel {
            controlOnOffView.controlModel = switchModel
        } else if let controlFigureView = ret as? ControlFigureView, let patternModel = controlModel as? PatternSelectionModel {
            controlFigureView.controlModel = patternModel
        } else {

        }
        return ret
    }

    private func cachedViews(controlModel: ControlModel) -> [ControlBaseView] {
        lock.lock()
        let ret = reusableViewsByIdentifier[controlModel.reuseIdentifier]
        lock.unlock()
        return ret ?? []
    }

    private func cacheViews(controlModel: ControlModel, cachedControlViews: [ControlBaseView]) {
        lock.lock()
        reusableViewsByIdentifier[controlModel.reuseIdentifier] = cachedControlViews
        lock.unlock()
    }
}
