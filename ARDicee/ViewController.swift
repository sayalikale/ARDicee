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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
//        let earth = SCNSphere(radius: 0.1)
//        //give material to cube
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "art.scnassets/8k_earth.jpg")
//
//        earth.materials = [material]
//
//        //create node
//        let node = SCNNode()
//        node.position = SCNVector3Make(0, 0.1, -0.5)
//        node.geometry = earth
//
//        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//
        
        
        
        // Create a new scene
//        let DiceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
//       if let DiceNode = DiceScene.rootNode.childNode(withName: "Dice", recursively: true)
//       {
//        DiceNode.position = SCNVector3Make(0, 0, -0.1)
//        sceneView.scene.rootNode.addChildNode(DiceNode)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
//delegate methode fromARCSNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
     
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
    }
 
    
    //detect the touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as! UITouch
        if(touch.view == self.sceneView){
           // print("touch working")
            let TouchLocation:CGPoint = touch.location(in: sceneView)
             let result = sceneView.hitTest(TouchLocation, types: .existingPlaneUsingExtent)
            
            if let hitResult = result.first
            {
                // Create a new scene
                        let DiceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
                       if let DiceNode = DiceScene.rootNode.childNode(withName: "Dice", recursively: true)
                       {
                        DiceNode.position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + DiceNode.boundingSphere.radius, hitResult.worldTransform.columns.3.z)
                        sceneView.scene.rootNode.addChildNode(DiceNode)
                        }
            }
            else{
                print("touch outside!")
            }
        }
    }
}
