//
//  ControlSliderView.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import UIKit

class ControlSliderView: ControlBaseView {

    var controlModel: SliderControlModel {
        didSet {
            slider.minimumValue = Float(controlModel.minValue)
            slider.maximumValue = Float(controlModel.maxValue)
            slider.value = Float(controlModel.value)
        }
    }

    lazy var titleLab: UILabel = {
        let titleLab = UILabel(frame: .init(x: 20, y: slider.minY - 20 - 20, width: 100, height: 20))
        titleLab.font = .systemFont(ofSize: 18)
        titleLab.textColor = .black
        titleLab.text = controlModel.name
        titleLab.textAlignment = .left
        return titleLab
    }()

    lazy var valueLab: UILabel = {
        let valueLab = UILabel(frame: .init(x: width - 20 - 100, y: slider.minY - 20 - 20, width: 100, height: 20))
        valueLab.font = .systemFont(ofSize: 18)
        valueLab.textColor = .black
        valueLab.text = "\(controlModel.value)"
        valueLab.textAlignment = .right
        return valueLab
    }()

    lazy var slider: UISlider = {
        let slider = UISlider(frame: .init(x: 20, y: (height - 10) * 0.5, width: width - 40, height: 10))
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return slider
    }()

    override var frame: CGRect {
        didSet {
            slider.frame = .init(x: 20, y: (height - 10) * 0.5, width: width - 40, height: 10)
            titleLab.frame = .init(x: 20, y: slider.minY - 20 - 20, width: 100, height: 20)
            valueLab.frame = .init(x: width - 20 - 100, y: slider.minY - 20 - 20, width: 100, height: 20)
        }
    }

    init(frame: CGRect, controlModel model: SliderControlModel) {
        controlModel = model
        super.init(frame: frame)
        backgroundColor = .init(hexValue: 0xC3C3C3)

        addSubview(slider)
        addSubview(titleLab)
        addSubview(valueLab)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func sliderValueDidChange() {
        controlModel.value = Int(slider.value)
        valueLab.text = "\(Int(slider.value))"
    }
}
