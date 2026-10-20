//
//  ControlFigureView.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/18.
//

import UIKit

class ControlFigureView: ControlBaseView {

    var controlModel: PatternSelectionModel {
        didSet {
            reloadPatterns()
        }
    }

    lazy var lab: UILabel = {
        let lab = UILabel(frame: .init(x: (width - 76) * 0.5, y: 30, width: 76, height: 40))
        lab.layer.cornerRadius = lab.height * 0.5
        lab.backgroundColor = .init(hexValue: 0x101010)
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .init(hexValue: 0x9B9B9B)
        lab.text = "图案"
        lab.textAlignment = .center
        return lab
    }()

    lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        return contentView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .init(x: 10, y: lab.maxY + 15, width: width - 20, height: height - lab.maxY - 15))
        return scrollView
    }()

    override var frame: CGRect {
        didSet {
            lab.frame = .init(x: (width - 76) * 0.5, y: 30, width: 76, height: 40)
            scrollView.frame = .init(x: 10, y: lab.maxY + 15, width: width - 20, height: height - lab.maxY - 15)
            reloadPatterns()
        }
    }

    init(frame: CGRect, controlModel model: PatternSelectionModel) {
        controlModel = model
        super.init(frame: frame)
        backgroundColor = .init(hexValue: 0xC3C3C3)

        addSubview(lab)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var patternButtonTagOffset: Int {
        1000
    }

    @objc func didSelectPattern(_ sender: UIButton) {
        if let btn = contentView.viewWithTag(controlModel.value + patternButtonTagOffset) as? UIButton {
            btn.isSelected = false
            btn.backgroundColor = .init(hexValue: 0x232323)
        }
        sender.isSelected = true
        sender.backgroundColor = .init(hexValue: 0x666666)
        controlModel.value = sender.tag - patternButtonTagOffset
    }

    func reloadPatterns() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        let colCount: Int = Int(floor(scrollView.width / 60))
        let colSpan: CGFloat = (scrollView.width - CGFloat(colCount * 60)) / CGFloat(colCount + 1)
        let rowCount: Int = controlModel.patternCount / colCount
        let cellHeight: CGFloat = (30 + 60 + 5 + 13)
        let totalHeight: CGFloat = cellHeight * CGFloat(rowCount)
        contentView.frame = .init(x: 0.0, y: 0.0, width: scrollView.width, height: totalHeight < scrollView.height ? scrollView.height : totalHeight)
        var minX = colSpan
        for index in 0..<controlModel.patternCount {
            let cellBtn = UIButton(frame: .init(x: minX, y: CGFloat(index / colCount) * cellHeight, width: 60, height: 60))
            cellBtn.layer.cornerRadius = cellBtn.height * 0.5
            if controlModel.value == index {
                cellBtn.backgroundColor = .init(hexValue: 0x666666)
                cellBtn.isSelected = true
            } else {
                cellBtn.backgroundColor = .init(hexValue: 0x232323)
            }
            cellBtn.addTarget(self, action: #selector(didSelectPattern(_:)), for: .touchUpInside)
            cellBtn.tag = patternButtonTagOffset + index

            let cellLab = UILabel(frame: .init(x: cellBtn.minX, y: cellBtn.maxY + 5, width: cellBtn.width, height: 13))
            cellLab.font = .systemFont(ofSize: 12)
            cellLab.textColor = .init(hexValue: 0x3A3A3A)
            cellLab.text = "图案\(index + 1)"
            cellLab.textAlignment = .center

            contentView.addSubview(cellBtn)
            contentView.addSubview(cellLab)

            minX = cellBtn.maxX + colSpan
            if (index + 1) % colCount == 0 {
                minX = colSpan
            }
        }
    }
}
