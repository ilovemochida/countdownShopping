//
//  DraggableViewBackground.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import Foundation
import UIKit

class DraggableViewBackground: UIView, DraggableViewDelegate{
    
    var cardsLoadedIndex:Int = Int()
    var loadedCards: NSMutableArray = NSMutableArray()
    
    var menuButton: UIButton = UIButton()
    var messageButton: UIButton = UIButton()
    var xButton: UIButton = UIButton()
    var checkButton: UIButton = UIButton()
    
    let MAX_BUFFER_SIZE: Int = 2
    let CARD_HEIGHT: CGFloat = 260
    let CARD_WIDTH: CGFloat = 260
    
    var exampleCardLabels: NSArray = NSArray()
    var allCards: NSMutableArray = NSMutableArray()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        
        exampleCardLabels = ["hoge1", "hoge2", "hoge3", "hoge4", "hoge5"]
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }
    
    func setupView() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1.0);
        menuButton = UIButton(frame: CGRect(x: 17, y: 34, width: 22, height: 15))
        messageButton = UIButton(frame: CGRect(x: 284, y: 34, width: 18, height: 18))
        xButton = UIButton(frame:CGRect(x: 60, y: 485, width: 18, height: 18))
        checkButton = UIButton(frame: CGRect(x: 200, y: 485, width: 59, height: 59))
        let menuButtonImage = UIImage(named: "menuButton")
        let messageButtonImage = UIImage(named: "messageButton")
        let xButtonImage = UIImage(named: "xButton")
        let checkButtonImage = UIImage(named: "checkButton")
        menuButton.setImage(menuButtonImage, for: .normal)
        messageButton.setImage(messageButtonImage, for: UIControlState.normal)
        xButton.setImage(xButtonImage, for: UIControlState.normal)
        checkButton.setImage(checkButtonImage, for: UIControlState.normal)
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), for: .touchUpInside)
        self.addSubview(menuButton)
        self.addSubview(messageButton)
        self.addSubview(xButton)
        self.addSubview(checkButton)
    }
    
    func createDraggableViewWithDataAtIndex(index: Int) -> DraggableView {
        let draggableView: DraggableView = DraggableView(frame: CGRect(x: 30, y: 100, width: CARD_WIDTH, height: CARD_HEIGHT))
        draggableView.information.text = exampleCardLabels.object(at: index) as? String
        draggableView.backgroundColor = UIColor.white
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() {
        if (exampleCardLabels.count > 0) {
            let numLoadedCardsCap = ((exampleCardLabels.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : exampleCardLabels.count )
            
            for i in 0..<exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(index: i)
                allCards.add(newCard)
                if (i < numLoadedCardsCap) {
                    loadedCards.add(newCard)
                }
            }
            
            for i in 0..<loadedCards.count {
                if (i > 0) {
                    self.insertSubview(loadedCards.object(at: i) as! UIView, belowSubview: loadedCards.object(at: i-1) as! UIView)
                } else {
                    self.addSubview(loadedCards.object(at: i) as! UIView)
                }
                cardsLoadedIndex += 1
            }
        }
    }
    
    func cardSwipedLeft(card: UIView) {
        loadedCards.removeObject(at: 0)
        if ( cardsLoadedIndex < allCards.count ) {
            loadedCards.add(allCards.object(at: cardsLoadedIndex))
            cardsLoadedIndex += 1
            self.insertSubview(loadedCards.object(at: MAX_BUFFER_SIZE-1) as! UIView, belowSubview: loadedCards.object(at: MAX_BUFFER_SIZE-2) as! UIView)
        }
    }
    
    
    func cardSwipedRight(card: UIView) {
        loadedCards.removeObject(at: 0)
        if ( cardsLoadedIndex < allCards.count ) {
            loadedCards.add(allCards.object(at: cardsLoadedIndex))
            cardsLoadedIndex += 1
            self.insertSubview(loadedCards.object(at: MAX_BUFFER_SIZE-1) as! UIView, belowSubview: loadedCards.object(at: MAX_BUFFER_SIZE-2) as! UIView)
        }
    }
    
    func swipeRight() {
        let dragView: DraggableView = loadedCards.firstObject as! DraggableView
        dragView.overlayView!.mode = GGOverlayViewMode.Right
        UIView.animate(withDuration: 0.2, animations: {
            dragView.overlayView!.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() {
        let dragView: DraggableView = loadedCards.firstObject as! DraggableView
        dragView.overlayView!.mode = GGOverlayViewMode.Left
        UIView.animate(withDuration: 0.2, animations: {
            dragView.overlayView!.alpha = 1
        })
        dragView.leftClickAction()
    }
}
