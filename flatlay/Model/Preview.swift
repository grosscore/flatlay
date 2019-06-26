//
//  Preview.swift
//  flatlay
//
//  Created by Gross on 20/3/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import SceneKit

struct Preview {
    
    let image: UIImage!
    let name: String!
    let model: SCNReferenceNode!
    
    init(_ node: SCNReferenceNode) {
        
        self.image = UIImage(named: node.modelName) ?? UIImage(named: "scenekit")
        self.name = node.name
        self.model = node
    }
    
}
