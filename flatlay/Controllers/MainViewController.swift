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
            return .portrait
        } else {
            return .all
        }
    }
    
    
    // MARK: - OUTLETS & VARIABLES
    
    @IBOutlet var sceneView: SceneView!
    
    var interactionManager: InteractionManager?
    var menuLauncher: MenuLauncher?
    
    var homePod: SCNReferenceNode {
        let url = Bundle.main.url(forResource: "/art.scnassets/HomePod/HomePod", withExtension: ".scn")
    
        let object = SCNReferenceNode(url: url!)
        return object!
    }

    
    // MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactionManager = InteractionManager(sceneView: sceneView)
        menuLauncher = MenuLauncher(view: sceneView)
        
        let scene = SCNScene(named: "scene.scn", inDirectory: "art.scnassets/Scene/", options: nil)
        sceneView.delegate = self
        sceneView.scene = scene
        sceneView.configureScene()
        sceneView.configureLighting()
        
        let homepod = homePod
        homepod.load()
        homepod.position = SCNVector3(-0.1, 0, -0.2)
        sceneView.scene?.rootNode.addChildNode(homepod)
        
    }


    // MARK: - ACTIONS
    
    @IBAction func showMenu(_ sender: UIButton) {
        guard let menuLauncher = self.menuLauncher else { return }
        menuLauncher.showMenu()
    }
    
    
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
