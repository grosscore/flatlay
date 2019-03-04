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
    
    // MARK: - VARIABLES
    
    var sceneView: SceneView
    var selectedObject: SCNReferenceNode?
    var currentTrackingPosition: CGPoint?
    
    // MARK: - INITIALIZING
    
    init(sceneView: SceneView) {
        self.sceneView = sceneView
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
            }
            
        case .changed where gesture.isThresholdExceeded:
            guard let object = selectedObject else { return }
            let translation = gesture.translation(in: sceneView)
            let currentPosition = currentTrackingPosition ?? CGPoint(sceneView.projectPoint(object.position))
            currentTrackingPosition = CGPoint(x: currentPosition.x + translation.x, y: currentPosition.y + translation.y)
            gesture.setTranslation(.zero, in: sceneView)
            
        case .changed: break
        case .ended:
            selectedObject = nil
            fallthrough
        default:
            selectedObject = nil
            currentTrackingPosition = nil
        }
        
        
        
    }
    
    // MARK: - TAP GESTURE FUNCTIONS
    
    @objc func didTap(with gesture: UITapGestureRecognizer) {
        
    }
    
    // MARK: - ROTATE GESTURE FUNCTIONS
    
    @objc func didRotate(with gesture: UIRotationGestureRecognizer) {
        
    }
    
}
