//
//  GameViewController.swift
//  flatlay
//
//  Created by Gross on 18/2/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class MainViewController: UIViewController {
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
    // MARK: - OUTLETS & VARIABLES
    
    @IBOutlet var sceneView: SceneView!
    
    var homePod: SCNReferenceNode {
        let url = Bundle.main.url(forResource: "/art.scnassets/HomePod/HomePod", withExtension: ".scn")
    
        let object = SCNReferenceNode(url: url!)
        return object!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene(named: "art.scnassets/Scene/scene.scn")!
        sceneView.scene = scene
        sceneView.configureScene()
        sceneView.configureLighting()
        
        
        let homepod = homePod
        homepod.load()
        homepod.position = SCNVector3(0, 0, 0)
        sceneView.scene?.rootNode.addChildNode(homepod)
        
    }

    

}
