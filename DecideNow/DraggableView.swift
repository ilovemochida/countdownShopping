//
//  TinderUIView.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import Foundation
import UIKit
let ACTION_MARGIN  = 120 //画面中央からどれだけ離れたらカードが自動的に画面から消えるかを決める。
let SCALE_STRENGTH  = 4 //カードがシュリンクするスピードを決める。
let SCALE_MAX = 0.93 //カードがどれだけ縮小するかを決める。
let ROTATION_MAX = 1 //カードの回転する大きさを決める。
let ROTATION_STRENGTH = 320
let ROTATION_ANGLE  = M_PI/8


// 後に出てくるDraggableViewBackground.swiftで使用する。カードが左右にスワイプされたときのアクションのためのプロトコル。
protocol DraggableViewDelegate  {
    func cardSwipedLeft(card: UIView)
    func cardSwipedRight(card: UIView)
}



class DraggableView: UIView {
    
    var delegate: DraggableViewDelegate?
    var information: UILabel = UILabel()
    var overlayView: OverlayView?
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPoint: CGPoint = CGPoint()
    
    var xFromCenter: CGFloat = CGFloat()
    var yFromCenter: CGFloat = CGFloat()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        information = UILabel(frame:CGRect(x: 0, y: 50, width: self.frame.size.width, height: 100))
        information.text = "no info given"
        information.textAlignment = NSTextAlignment.center
        information.textColor = UIColor.black
        
        self.backgroundColor = UIColor.black
        
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector(("beingDragged:")))
        self.addGestureRecognizer(panGestureRecognizer!)
        self.addSubview(information)
        
        overlayView = OverlayView(frame: CGRect(x: self.frame.size.width/2-100, y: 0, width: 100, height: 100))
        overlayView!.alpha = 0
        self.addSubview(overlayView!)
        
    }
    
    func setupView() {
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let xFromCenter = gestureRecognizer.translation(in: self).x
        let yFromCenter = gestureRecognizer.translation(in: self).y
        
        switch (gestureRecognizer.state) {
        case UIGestureRecognizerState.began:
            self.originalPoint = self.center;
            break;
        case UIGestureRecognizerState.changed:
            let rotationStrength: CGFloat = min(xFromCenter / CGFloat(ROTATION_STRENGTH), CGFloat(ROTATION_MAX))
            let rotationAngel: CGFloat = CGFloat(ROTATION_ANGLE) * rotationStrength
            let scale: CGFloat = max(1 - CGFloat(fabsf(Float(rotationStrength))) / CGFloat(SCALE_STRENGTH), CGFloat(SCALE_MAX))
            self.center = CGPoint(x: self.originalPoint.x + xFromCenter, y: self.originalPoint.y + yFromCenter)
            let transform: CGAffineTransform = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transform.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            self.updateOverlay(distance: xFromCenter)
            break
            
        case UIGestureRecognizerState.ended:
            self.afterSwipeAction(xFromCenter: xFromCenter)
            break
        case UIGestureRecognizerState.possible:
            break
        case UIGestureRecognizerState.cancelled:
            break
        case UIGestureRecognizerState.failed:
            break
        }
    }
    
    func updateOverlay(distance: CGFloat) {
        if distance > 0 {
            overlayView!.setMode(mode: GGOverlayViewMode.Right)
        } else {
            overlayView!.setMode(mode: GGOverlayViewMode.Left)
        }
        
        overlayView!.alpha = min(CGFloat(fabsf(Float(distance))/100), 0.4)
    }
    
    func afterSwipeAction(xFromCenter: CGFloat) {
        if xFromCenter > CGFloat(ACTION_MARGIN) {
            self.rightAction()
        } else if xFromCenter < CGFloat(-ACTION_MARGIN) {
            self.leftAction()
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.overlayView!.alpha = 0
            })
        }
        
    }
    
    func rightAction() {
        let finishPoint: CGPoint = CGPoint(x: 500, y: 2*yFromCenter + self.originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(card: self)
        NSLog("YES")
    }
    
    func leftAction() {
        let finishPoint: CGPoint = CGPoint(x: -500, y: 2*yFromCenter + self.originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedLeft(card: self)
        NSLog("NO")
    }
    
    func rightClickAction() {
        let finishPoint: CGPoint = CGPoint(x: 600, y: self.center.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: 1)
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(card: self)
        NSLog("YES")
    }
    func leftClickAction() {
        let finishPoint: CGPoint = CGPoint(x: -600, y: self.center.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: -1)
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(card: self)
        NSLog("NO")
    }
    
}
