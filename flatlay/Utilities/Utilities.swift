import SceneKit

// MARK: - SCNREFERENCENODE EXTENSION

extension SCNReferenceNode {
    
    var modelName: String {
        return referenceURL.lastPathComponent.replacingOccurrences(of: ".scn", with: "")
    }
    
    // Enumerates all the 3D objects
    static let availableObjects: [Preview] = {
        let modelsURL = Bundle.main.url(forResource: "art.scnassets", withExtension: nil)!
        let fileEnumerator = FileManager().enumerator(at: modelsURL, includingPropertiesForKeys: [])!
        
        return fileEnumerator.compactMap { element in
            let url = element as! URL
            guard url.pathExtension == "scn", url.lastPathComponent != "scene.scn" else { return nil }
            return Preview(SCNReferenceNode(url: url)!)
        }
    }()
    
}

// MARK: - CGPOINT EXTENSION

extension CGPoint {
    /// Extracts the screen space point from a vector returned by SCNView.projectPoint(_:).
    init(_ vector: SCNVector3) {
        self.init(x: CGFloat(vector.x), y: CGFloat(vector.y))
    }
    
/// Returns the length of a point when considered as a vector. (Used with gesture recognizers.)
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
}


