//
//  ViewController.swift
//  planetarium
//
//  Created by Victor Zambrano on 6/2/18.
//  Copyright © 2018 Victor Zambrano. All rights reserved.
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
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
		
		// MARK: - Planets
		
		/*
		Relative sizes and distances:
		Sun: 1,377,648 kilometers (Ratio: 1:1)
		
		Mercury: 4,880 kilometers (Ratio: 1:277)
		Venus: 12,104 kilometers (Ratio: 1:113)
		Earth: 12,756 kilometers (Ratio: 1:108)
		Mars: 6,788 kilometers (Ratio: 1:208)
		Jupiter: 142,740 kilometers (Ratio: 1:9.68)
		Saturn: 120,034 kilometers (Ratio: 1:11.4)
		Uranus: 51,152 kilometers (Ratio: 1:26.8)
		Neptune: 49,620 kilometers (Ratio: 1:27.7)
		*/
		
		// Sun
		let sunSphere = SCNSphere(radius: 0.2)
		let sunMaterial = SCNMaterial()
		sunMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_sun.jpg")
		sunSphere.materials = [sunMaterial]
		
		let sunNode = SCNNode()
		sunNode.position = SCNVector3(x: 0, y: 0, z: -1.1)
		sunNode.geometry = sunSphere
		
		sceneView.scene.rootNode.addChildNode(sunNode)
		
		// Mercury
		let mercurySphere = SCNSphere(radius: 0.006)
		let mercuryMaterial = SCNMaterial()
		mercuryMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_mercury.jpg")
		mercurySphere.materials = [mercuryMaterial]
		
		let mercuryNode = SCNNode()
		mercuryNode.position = SCNVector3(x: 0, y: 0, z: -1*(1-0.487))
		mercuryNode.geometry = mercurySphere
		
		sceneView.scene.rootNode.addChildNode(mercuryNode)
		
		// Venus
		let venusSphere = SCNSphere(radius: 0.015)
		let venusMaterial = SCNMaterial()
		venusMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_venus_atmosphere.jpg")
		venusSphere.materials = [venusMaterial]
		
		let venusNode = SCNNode()
		venusNode.position = SCNVector3(x: 0, y: 0, z: -1*(1-0.822))
		venusNode.geometry = venusSphere
		
		sceneView.scene.rootNode.addChildNode(venusNode)
		
		// Earth
		let earthSphere = SCNSphere(radius: 0.016)
		let earthMaterial = SCNMaterial()
		earthMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_earth_daymap.jpg")
		earthSphere.materials = [earthMaterial]
		
		let earthNode = SCNNode()
		earthNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
		earthNode.geometry = earthSphere
		
		sceneView.scene.rootNode.addChildNode(earthNode)
		
		// Mars
		let marsSphere = SCNSphere(radius: 0.008)
		let marsMaterial = SCNMaterial()
		marsMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_mars.jpg")
		marsSphere.materials = [marsMaterial]
		
		let marsNode = SCNNode()
		marsNode.position = SCNVector3(x: 0, y: 0, z: 1.62)
		marsNode.geometry = marsSphere
		
		sceneView.scene.rootNode.addChildNode(marsNode)
		
		// Jupiter
		let jupiterSphere = SCNSphere(radius: 0.175)
		let jupiterMaterial = SCNMaterial()
		jupiterMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_jupiter.jpg")
		jupiterSphere.materials = [jupiterMaterial]
		
		let jupiterNode = SCNNode()
		jupiterNode.position = SCNVector3(x: 0, y: 0, z: 5.30)
		jupiterNode.geometry = jupiterSphere
		
		sceneView.scene.rootNode.addChildNode(jupiterNode)
		
		// Saturn
		let saturnSphere = SCNSphere(radius: 0.147)
		let saturnMaterial = SCNMaterial()
		saturnMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k/8k_saturn.jpg")
		saturnSphere.materials = [saturnMaterial]
		
		let saturnNode = SCNNode()
		saturnNode.position = SCNVector3(x: 0, y: 0, z: 9.68)
		saturnNode.geometry = saturnSphere
		
		sceneView.scene.rootNode.addChildNode(saturnNode)
		
		// Uranus
		let uranusSphere = SCNSphere(radius: 0.062)
		let uranusMaterial = SCNMaterial()
		uranusMaterial.diffuse.contents = UIImage(named: "art.scnassets/2k/2k_uranus.jpg")
		uranusSphere.materials = [uranusMaterial]
		
		let uranusNode = SCNNode()
		uranusNode.position = SCNVector3(x: 0, y: 0, z: 19.3)
		uranusNode.geometry = uranusSphere
		
		sceneView.scene.rootNode.addChildNode(uranusNode)
		
		// Neptune
		let neptuneSphere = SCNSphere(radius: 0.06)
		let neptuneMaterial = SCNMaterial()
		neptuneMaterial.diffuse.contents = UIImage(named: "art.scnassets/2k/2k_neptune.jpg")
		neptuneSphere.materials = [neptuneMaterial]
		
		let neptuneNode = SCNNode()
		neptuneNode.position = SCNVector3(x: 0, y: 0, z: 30.2)
		neptuneNode.geometry = neptuneSphere
		
		sceneView.scene.rootNode.addChildNode(neptuneNode)
		
		
		// Lighting
		sceneView.autoenablesDefaultLighting = true
		
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
