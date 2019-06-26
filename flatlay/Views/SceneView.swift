//
//  SceneView.swift
//  flatlay
//
//  Created by Gross on 4/3/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import SceneKit

class SceneView: SCNView {
    
    // MARK: - SCENE CONFIGURATION
    
    
    func configureScene() {
        
        self.antialiasingMode = .multisampling4X
        self.allowsCameraControl = true
        
        self.showsStatistics = true
    }
    
     func configureLighting() {
        
        guard let scene = self.scene else { print("No scene found in SceneView"); return }
        
        self.autoenablesDefaultLighting = false
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.castsShadow = true
        directionalLight.shadowMode = .deferred
        directionalLight.shadowColor = UIColor.black.withAlphaComponent(0.85)
        directionalLight.shadowSampleCount = 64
        directionalLight.shadowRadius = 50
        directionalLight.automaticallyAdjustsShadowProjection = true
        directionalLight.intensity = 10
        let directionalNode = SCNNode()
        directionalNode.light = directionalLight
        directionalNode.worldPosition = SCNVector3(-10, 100, -10)
        directionalNode.eulerAngles.x = -.pi/2
        directionalNode.eulerAngles.z = 0.26
        directionalNode.name = "directional"
        
        
        let spotLight = SCNLight()
        spotLight.type = .spot
        spotLight.spotOuterAngle = 80
        spotLight.automaticallyAdjustsShadowProjection = true
        spotLight.castsShadow = true
        spotLight.shadowMode = .deferred
        spotLight.shadowSampleCount = 16
        spotLight.shadowColor = UIColor.black.withAlphaComponent(0.7)
        spotLight.intensity = 10
        let spotNode = SCNNode()
        spotNode.light = spotLight
        spotNode.worldPosition = SCNVector3(-10, 100, 10)
        spotNode.eulerAngles.x = -.pi/2
        spotNode.name = "spot"
        
        let omniLight = SCNLight()
        omniLight.intensity = 0
        omniLight.type = .omni
        let omniNode = SCNNode()
        omniNode.light = omniLight
        omniNode.worldPosition = SCNVector3(-10, 30, -10)
        omniNode.eulerAngles.x = -1
        omniNode.name = "omni"
        
        scene.rootNode.addChildNode(directionalNode)
        //scene.rootNode.addChildNode(spotNode)
        //scene.rootNode.addChildNode(omniNode)
    }
    
    
    // MARK: - NODE MANAGEMENT
    
    func  node(at point: CGPoint) -> SCNReferenceNode? {
        let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResults = hitTest(point, options: hitTestOptions)
        
        return hitTestResults.lazy.compactMap { result in
            self.existingObjectContainingNode(result.node)
            }.first
    }
    
    func existingObjectContainingNode(_ node: SCNNode) -> SCNReferenceNode? {
        if let virtualObjectRoot = node as? SCNReferenceNode {
            return virtualObjectRoot
        }
        
        guard let parent = node.parent else { return nil }
        return existingObjectContainingNode(parent)
    }
    
    
    
}
