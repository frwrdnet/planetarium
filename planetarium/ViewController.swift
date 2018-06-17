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
	
	struct Planet {
		var name: String = "sun"
		var distance: Float = 0.0
		var radius: CGFloat = 0.2
		var image: String = "art.scnassets/8k_sun.jpg"
		var duration: Double = 14.0
		var orbit: Double = 14.0
	}
	
	let speedOfEarthsOrbit = 29.78
	let durationOfEarthsDay = 60.0
	
	let switchPlanetsOnTouch = false
	var movePlanets = true
	
	let planets: [Planet] = [
		Planet(name: "sun", distance: 0.0, radius: 0.2, image: "art.scnassets/8k_sun.jpg", duration: 36, orbit: 0.0),
		Planet(name: "mercury", distance: 0.4, radius: 0.006, image: "art.scnassets/8k_mercury.jpg", duration: 87.97, orbit: 1.607),
		Planet(name: "venus", distance: 0.7, radius: 0.015, image: "art.scnassets/8k_venus_atmosphere.jpg", duration: 243, orbit: 1.175),
		Planet(name: "earth", distance: 1.0, radius: 0.016, image: "art.scnassets/8k_earth_day_map.jpg", duration: 1, orbit: 1),
		Planet(name: "mars", distance: 1.62, radius: 0.008, image: "art.scnassets/8k_mars.jpg", duration: 24.6, orbit: 0.808),
		Planet(name: "jupiter", distance: 5.30, radius: 0.175, image: "art.scnassets/8k_jupiter.jpg", duration: 9.8, orbit: 0.438),
		Planet(name: "saturn", distance: 9.68, radius: 0.147, image: "art.scnassets/8k_saturn.jpg", duration: 0.416, orbit: 0.325),
		Planet(name: "uranus", distance: 19.3, radius: 0.062, image: "art.scnassets/2k_uranus.jpg", duration: 0.708, orbit: 0.228),
		Planet(name: "neptune", distance: 30.2, radius: 0.06, image: "art.scnassets/2k_neptune.jpg", duration: 0.666, orbit: 0.182),
		]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
		sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
		sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin
		// sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
		
		// Lighting
		sceneView.autoenablesDefaultLighting = true
		
		// Camera control
		sceneView.allowsCameraControl = true
		
		// Add background
		sceneView.backgroundColor = UIColor.black

		arrangePlanets()
	
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if switchPlanetsOnTouch {
			let location = touches.first!.location(in: sceneView)
			var hitTestOptions = [SCNHitTestOption: Any]()
			let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
			if let hit = hitResults.first {
					switchPlanets()
					return
			}
		}
	}
	
	func arrangePlanets() {
		for planet in planets {
			print("----\nplanet.name: \(planet.name)")
			print("planet.distance: \(planet.distance)")
			print("planet.radius: \(planet.radius)")
			print("planet.image: \(planet.image)")
			print("planet.duration: \(planet.duration)")
			print("planet.orbit: \(planet.orbit)")
			
			let sphere = SCNSphere(radius: planet.radius/2)
			let material = SCNMaterial()
			material.diffuse.contents = UIImage(named: planet.image)
			sphere.materials = [material]
			
			let node = SCNNode()
			//let pos = planet.distance // + Float(-1.1)
			node.position = SCNVector3(x: 0.0, y: 0.0, z: planet.distance)
			print("node.position: \(node.position)")
			node.geometry = sphere
			node.name = planet.name
			
			let helperNode = SCNNode()
			helperNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0) //-1.1)
			print("helperNode.position: \(helperNode.position)")
			helperNode.addChildNode(node)
			
			node.addAnimation(rotate(duration: planet.duration*durationOfEarthsDay), forKey: "planetSpin")
			helperNode.addAnimation(rotate(duration: planet.orbit*speedOfEarthsOrbit), forKey: "planetOrbit")
			
			if planet.name == "sun" {
				sceneView.scene.rootNode.addChildNode(node)
			} else {
				sceneView.scene.rootNode.addChildNode(helperNode)
			}
		}
	}
	
	func stopPlanets() {
		let nodes = sceneView.scene.rootNode.childNodes
		for index in 1...nodes.count-1 {
			nodes[index].isPaused = true //.pauseAnimation(forKey: "planetOrbit")
			//nodes[index].removeAnimation(forKey: "planetOrbit")
			//nodes[index].position = SCNVector3(x: 0.0, y: 0.0, z: planets[nodes.filter{$0.name==nodes[index].name}[0]].distance)
		}
	}
	
	func startPlanets() {
		let nodes = sceneView.scene.rootNode.childNodes
		for index in 1...nodes.count-1 {
			nodes[index].isPaused = false //.resumeAnimation(forKey: "planetOrbit")
			//nodes[index].addAnimation(rotate(duration: planets[index].orbit*speedOfEarthsOrbit), forKey: "planetOrbit")
			//nodes[index].position = SCNVector3(x: 0.0, y: 0.0, z: planets[index].distance)
		}
	}
	
	func switchPlanets() {
		if movePlanets {
			stopPlanets()
			movePlanets = false
		} else {
			startPlanets()
			movePlanets = true
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
