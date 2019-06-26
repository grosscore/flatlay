//
//  Main+SCNViewDelegate.swift
//  flatlay
//
//  Created by Gross on 5/3/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import SceneKit

extension MainViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        interactionManager?.updateObjectToCurrentTrackingPosition()
    }
    
}

