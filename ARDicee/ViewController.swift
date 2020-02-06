//
//  ViewController.swift
//  ARDicee
//
//  Created by sayali on 06/02/20.
//  Copyright © 2020 sayali. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        let earth = SCNSphere(radius: 0.1)
        //give material to cube
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/8k_earth.jpg")
       
        earth.materials = [material]
        
        //create node
        let node = SCNNode()
        node.position = SCNVector3Make(0, 0.1, -0.5)
        node.geometry = earth
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

 
 
}
