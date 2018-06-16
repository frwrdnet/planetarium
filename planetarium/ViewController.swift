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
	
	struct Planet {
		var name: String = "sun"
		var distance: Float = 0.0
		var radius: CGFloat = 0.2
		var image: String = "art.scnassets/2k/2k_sun.jpg"
		var duration: Double = 14.0
		var orbit: Double = 14.0
	}
	
	/*
	Planet(name: "sun", distance: -1.1, radius: 0.2, image: UIImage(named: "art.scnassets/2k/2k_sun.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "mercury", distance: -0.513, radius: 0.006, image: UIImage(named: "art.scnassets/2k/2k_mercury.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "venus", distance: -0.178, radius: 0.015, image: UIImage(named: "art.scnassets/2k/2k_venus_atmosphere.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "earth", distance: -0.1, radius: 0.016, image: UIImage(named: "art.scnassets/2k/2k_earth_daymap.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "mars", distance: 1.62, radius: 0.008, image: UIImage(named: "art.scnassets/2k/2k_mars.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "jupiter", distance: 5.30, radius: 0.175, image: UIImage(named: "art.scnassets/2k/2k_jupiter.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "saturn", distance: 9.68, radius: 0.147, image: UIImage(named: "art.scnassets/2k/2k_saturn.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "uranus", distance: 19.3, radius: 0.062, image: UIImage(named: "art.scnassets/2k/2k_uranus.jpg")!, duration: 14.0, orbit: 14.0),
	Planet(name: "neptune", distance: 30.2, radius: 0.06, image: UIImage(named: "art.scnassets/2k/2k_neptune.jpg")!, duration: 14.0, orbit: 14.0),
	*/
	
	let planets: [Planet] = [
		Planet(name: "sun", distance: 0.0, radius: 0.2, image: "art.scnassets/2k/2k_sun.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "mercury", distance: 0.4, radius: 0.006, image: "art.scnassets/2k/2k_mercury.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "venus", distance: 0.7, radius: 0.015, image: "art.scnassets/2k/2k_venus_atmosphere.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "earth", distance: 1.0, radius: 0.016, image: "art.scnassets/2k/2k_earth_day_map.jpg", duration: 14.0, orbit: 14.0),
		//Planet(name: "earth", distance: 1.0, radius: 0.016, image: "art.scnassets/2k/2k_earth_nightmap.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "mars", distance: 1.62, radius: 0.008, image: "art.scnassets/2k/2k_mars.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "jupiter", distance: 5.30, radius: 0.175, image: "art.scnassets/2k/2k_jupiter.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "saturn", distance: 9.68, radius: 0.147, image: "art.scnassets/2k/2k_saturn.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "uranus", distance: 19.3, radius: 0.062, image: "art.scnassets/2k/2k_uranus.jpg", duration: 14.0, orbit: 14.0),
		Planet(name: "neptune", distance: 30.2, radius: 0.06, image: "art.scnassets/2k/2k_neptune.jpg", duration: 14.0, orbit: 14.0),
		]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
		
		// Lighting
		sceneView.autoenablesDefaultLighting = true
		
		// Camera control
		sceneView.allowsCameraControl = true

		arrangePlanets()
	
    }
	
	func arrangePlanets() {
		for planet in planets {
			print("----\nplanet.name: \(planet.name)")
			print("planet.distance: \(planet.distance)")
			print("planet.radius: \(planet.radius)")
			print("planet.image: \(planet.image)")
			print("planet.duration: \(planet.duration)")
			print("planet.orbit: \(planet.orbit)")
			
			let sphere = SCNSphere(radius: planet.radius)
			let material = SCNMaterial()
			material.diffuse.contents = UIImage(named: planet.image)
			sphere.materials = [material]
			
			let node = SCNNode()
			let pos = planet.distance + Float(-1.1)
			node.position = SCNVector3(x: 0, y: 0, z: pos)
			print("node.position: \(node.position)")
			node.geometry = sphere
			
			let helperNode = SCNNode()
			helperNode.position = SCNVector3(x: 0, y: 0, z: -1.1)
			print("helperNode.position: \(helperNode.position)")
			helperNode.addChildNode(node)
			
			node.addAnimation(rotate(duration: planet.duration), forKey: "planetSpin")
			helperNode.addAnimation(rotate(duration: planet.orbit), forKey: "planetOrbit")
			
			if planet.name == "sun" {
				sceneView.scene.rootNode.addChildNode(node)
			} else {
				sceneView.scene.rootNode.addChildNode(helperNode)
			}
		}
	}
	
	
	// Animations
	func rotate(duration: Double) -> CABasicAnimation {
		let spin = CABasicAnimation(keyPath: "rotation")
		// Use from-to to explicitly make a full rotation around z
		spin.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
		spin.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(CGFloat(2 * Double.pi))))
		spin.duration = duration
		spin.repeatCount = .infinity
		return spin
	}
	
	// traslate node
	func orbit(radius: Float, duration: Double) -> CABasicAnimation {
		let traslate = CABasicAnimation(keyPath: "rotation")
		traslate.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
		traslate.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(CGFloat(2 * Double.pi))))
		traslate.duration = duration
		traslate.repeatCount = .infinity
		return traslate
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
