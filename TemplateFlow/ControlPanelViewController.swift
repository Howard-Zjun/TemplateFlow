//
//  ControlPanelViewController.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import UIKit

class ControlPanelViewController: UIViewController {

    let deviceCapabilities: DeviceCapabilities = .init()

    let factory: ControlViewFactory = .init()

    var allScenes: [ControlScene] = []

    var supportedScenes: [ControlScene] = []

    var sceneTabViews: [(UIButton, UILabel)] = []

    var selectedScene: ControlScene!

    var controlGroupSegmentedControl: UISegmentedControl?

    var sceneButtonTagOffset: Int {
        100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureScenes()
        var minX = (view.width - 65 * CGFloat(supportedScenes.count)) * 0.5
        var sceneTabViews: [(UIButton, UILabel)] = []
        for (index, scene) in supportedScenes.enumerated() {
            let btn = UIButton(frame: .init(x: minX, y: 100, width: 65, height: 30))
            btn.tag = sceneButtonTagOffset + index
            btn.setImage(.init(named: scene.normalImageName), for: .normal)
            btn.setImage(.init(named: scene.selectedImageName), for: .selected)
            btn.isSelected = scene === selectedScene
            btn.addTarget(self, action: #selector(didSelectScene(_:)), for: .touchUpInside)

            let lab = UILabel(frame: .init(x: minX, y: btn.maxY + 1, width: btn.width, height: 11))
            lab.font = .systemFont(ofSize: 10)
            lab.textColor = .init(hexValue: (scene === selectedScene ? 0x46AA5F : 0x787878))
            lab.text = scene.title
            lab.textAlignment = .center
            lab.adjustsFontSizeToFitWidth = true

            view.addSubview(btn)
            view.addSubview(lab)
            sceneTabViews.append((btn, lab))
            minX = btn.maxX
        }
        self.sceneTabViews = sceneTabViews
        rebuildControlGroupSelector()
        reloadControlPanel()
    }

    func configureScenes() {
        allScenes = [
            ZoomControlScene(capabilities: deviceCapabilities),
            CutControlScene(capabilities: deviceCapabilities),
            BarndoorControlScene(capabilities: deviceCapabilities),
            GoboControlScene(capabilities: deviceCapabilities),
            SmokeControlScene(capabilities: deviceCapabilities)
        ]
        var availableScenes: [ControlScene] = []
        for scene in allScenes {
            if scene.supportedControlGroups.count > 0 {
                availableScenes.append(scene)
            }
        }
        supportedScenes = availableScenes
        selectedScene = supportedScenes[0]
    }

    func rebuildControlGroupSelector() {
        controlGroupSegmentedControl?.removeFromSuperview()
        let controlGroupSegmentedControl = UISegmentedControl(items: selectedScene.supportedControlGroups.map({$0.kind.rawValue}))
        controlGroupSegmentedControl.selectedSegmentIndex = 0
        controlGroupSegmentedControl.backgroundColor = .init(hexValue: 0xC3C3C3)
        controlGroupSegmentedControl.tintColor = .white
        let segmentWidth: CGFloat = CGFloat(selectedScene.supportedControlGroups.count) * 65
        controlGroupSegmentedControl.frame = .init(x: sceneTabViews[0].1.minX + (65 * CGFloat(supportedScenes.count) - segmentWidth) * 0.5, y: sceneTabViews[0].1.maxY + 20, width: segmentWidth, height: 30)
        controlGroupSegmentedControl.addTarget(self, action: #selector(didSelectControlGroup), for: .valueChanged)
        view.addSubview(controlGroupSegmentedControl)
        self.controlGroupSegmentedControl = controlGroupSegmentedControl
    }

    @objc func didSelectScene(_ sender: UIButton) {
        for (index, (btn, lab)) in sceneTabViews.enumerated() {
            btn.isSelected = false
            lab.textColor = .init(hexValue: 0x787878)
            if btn == sender {
                btn.isSelected = true
                lab.textColor = .init(hexValue: 0x46AAa5F)
                selectedScene = supportedScenes[index]
            }
        }
        rebuildControlGroupSelector()
        reloadControlPanel()
    }

    @objc func didSelectControlGroup() {
        reloadControlPanel()
    }

    func reloadControlPanel() {
        guard let controlGroupSegmentedControl = controlGroupSegmentedControl else {
            return
        }
        let groupModel = selectedScene.supportedControlGroups[controlGroupSegmentedControl.selectedSegmentIndex]
        factory.recycleAllViews()
        let startPoint = CGPoint(x: 0, y: controlGroupSegmentedControl.maxY + 30)
        let endPoint = CGPoint(x: view.width, y: view.height - 30)
        for (index, controlModel) in groupModel.supportedControls.enumerated() {
            if let controlBaseView = factory.makeOrReuseView(for: controlModel, in: view) {
                groupModel.layoutTemplate.layout(controlView: controlBaseView, index: index, startPoint: startPoint, endPoint: endPoint)
            }
        }
    }
}

