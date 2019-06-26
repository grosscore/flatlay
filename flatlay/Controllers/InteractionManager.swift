//
//  InteractionManager.swift
//  flatlay
//
//  Created by Gross on 4/3/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import SceneKit


class InteractionManager: NSObject, UIGestureRecognizerDelegate {
    
    // MARK: - PROPERTIES
    
    var sceneView: SceneView
    var selectedObject: SCNReferenceNode?
    var currentTrackingPosition: CGPoint?
    var zDepth: Float?
    
    var menuLauncher: MenuLauncher
    
    // MARK: - INITIALIZING
    
    init(sceneView: SceneView) {
        
        self.sceneView = sceneView
        self.menuLauncher = MenuLauncher(view: sceneView)
        
        super.init()
        
        
        let panGesture = ThresholdPanGesture(target: self, action: #selector(didPan(with:)))
        panGesture.delegate = self
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(with:)))
        rotationGesture.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(with:)))
        tapGesture.delegate = self
        
        sceneView.addGestureRecognizer(panGesture)
        sceneView.addGestureRecognizer(rotationGesture)
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - PAN GESTURE FUNCTIONS
    
    @objc func didPan(with gesture: ThresholdPanGesture) {
        
        switch  gesture.state {
        case .began:
            let location = gesture.location(in: sceneView)
            if let object = sceneView.node(at: location) {
                selectedObject = object
                zDepth = sceneView.projectPoint(object.position).z
            }
            
        case .changed:
            guard let object = selectedObject else { return }
            let translation = gesture.translation(in: sceneView)
            let currentPosition = currentTrackingPosition ?? CGPoint(sceneView.projectPoint(object.position))
            currentTrackingPosition = CGPoint(x: currentPosition.x + translation.x, y: currentPosition.y + translation.y)
            gesture.setTranslation(.zero, in: sceneView)
            
            updateObjectToCurrentTrackingPosition()
        //case .changed: break
        case .ended:
            selectedObject = nil
            zDepth = nil
            fallthrough
        default:
            selectedObject = nil
            currentTrackingPosition = nil
            zDepth = nil
        }
        
    }
    
    // MARK: - TAP GESTURE FUNCTIONS
    
    @objc func didTap(with gesture: UITapGestureRecognizer) {
            menuLauncher.hideMenu()
    }
    
    // MARK: - ROTATE GESTURE FUNCTIONS
    
    @objc func didRotate(with gesture: UIRotationGestureRecognizer) {
        guard let rotatingNode = sceneView.node(at: gesture.location(in: sceneView)) else { return }
        switch gesture.state {
        case .began: gesture.rotation = CGFloat(rotatingNode.eulerAngles.y)
        case .changed:
            rotatingNode.eulerAngles.y = Float(-gesture.rotation) * 1.5
        default: return
        }
    }
    
    
    // MARK: - ADDITIONAL FUNCTIONS
    
    @objc func updateObjectToCurrentTrackingPosition() {
        guard let object = selectedObject, let location = currentTrackingPosition, let zDepth = zDepth else { return }
        let position = sceneView.unprojectPoint(SCNVector3Make(Float(location.x), Float(location.y), zDepth))
        object.position = position
        
    }
    
}
