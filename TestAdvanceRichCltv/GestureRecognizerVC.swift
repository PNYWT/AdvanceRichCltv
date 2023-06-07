//
//  GestureRecognizerVC.swift
//  TestAdvanceRichCltv
//
//  Created by Dev on 7/6/2566 BE.
//

import UIKit

class GestureRecognizerVC: UIViewController {

    private let imageView = UIImageView()
    var imagePassing = UIImage.init()
    var panGestureRecognizer: UIPanGestureRecognizer!
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    var initialTransform: CGAffineTransform!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = self.view.center
        imageView.backgroundColor = .blue
        imageView.image = imagePassing
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled  = true
        self.view.addSubview(imageView)
        
        self.setupGesture()
    }
    
    func setupGesture(){
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        imageView.addGestureRecognizer(panGestureRecognizer)

        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    //move view
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        
        if recognizer.state == .began {
            initialTransform = view.transform
        }
        
        let translation = recognizer.translation(in: view.superview)
        view.transform = initialTransform.translatedBy(x: translation.x, y: translation.y)
    }

    //zoom view
    @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let view = recognizer.view else { return }
        
        if recognizer.state == .began {
            initialTransform = view.transform
        }
        
        let scale = recognizer.scale
        view.transform = initialTransform.scaledBy(x: scale, y: scale)
    }

}
