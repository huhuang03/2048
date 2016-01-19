//
//  GameView.swift
//  2048
//
//  Created by 文凡胡 on 1/16/16.
//  Copyright © 2016 Th. All rights reserved.
//
import UIKit
extension UIColor {
    // don't conside edage cases
    convenience init(string: String) {
        var str = string
        if string.hasPrefix("#") {
            str = string.substringFromIndex(string.startIndex.advancedBy(1))
        }
        
        let rString = str.substringToIndex(str.startIndex.advancedBy(2))
        let gString = str.substringWithRange(Range(start: str.startIndex.advancedBy(2), end: str.startIndex.advancedBy(4)))
        let bString = str.substringWithRange(Range(start: str.startIndex.advancedBy(4), end: str.startIndex.advancedBy(6)))
        
        let aInt = UInt8(strtoul(rString, nil, 16))
        let gInt = UInt8(strtoul(gString, nil, 16))
        let bInt = UInt8(strtoul(bString, nil, 16))
        
        
        self.init(
            red: CGFloat(aInt) / CGFloat(255),
            green: CGFloat(gInt) / CGFloat(255),
            blue: CGFloat(bInt) / CGFloat(255),
            alpha: CGFloat(1)
        )
    }
}

class GameView: UIView {
    let gapWidth = 10;
    
    var backGroundViews = [UIView]()
    
    var dimmentions = 4
    
    var manager: GameManager!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init from frame")
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init from aDecoder")
        setup()
    }
    
    func setup() {
        manager = GameManager(dimention: 4, rootView: self)
        self.backgroundColor = UIColor(string: "#BBAD9F")
        initBackGround()
        manager.createNew()
        manager.createNew()
        let leftGesture = UISwipeGestureRecognizer(target: self, action: "leftSwipe")
        leftGesture.direction = .Left
        self.addGestureRecognizer(leftGesture)
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: "rightSwipe")
        rightGesture.direction = .Right
        self.addGestureRecognizer(rightGesture)
        
        let upGesture = UISwipeGestureRecognizer(target: self, action: "upSwipe")
        upGesture.direction = .Up
        self.addGestureRecognizer(upGesture)
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: "downSwipe")
        downGesture.direction = .Down
        self.addGestureRecognizer(downGesture)
    }
    
    func initBackGround() {
        for _ in 0...3 {
            for _ in 0...3 {
                let view = UIView()
                view.backgroundColor = UIColor(string: "#CDC1B3")
                view.layer.cornerRadius = 8
                view.clipsToBounds = true
                self.backGroundViews.append(view)
                self.addSubview(view)
            }
        }
    }
    
    override func layoutSubviews() {
        for i in 0...3 {
            for j in 0...3 {
                let view = self.backGroundViews[i * 4 + j]
                view.frame = getPositionFor(i, col: j)
            }
        }
        refreshCardsUI()
    }
    
    func getColumnWidth() -> Int {
        let width = Int((self.frame.width - CGFloat(5 * gapWidth)) / 4)
        return width;
    }
    
    func getPositionFor(row: Int, col: Int) -> CGRect {
        let width = getColumnWidth()
        return CGRect(
            x: col * (gapWidth + width) + gapWidth,
            y: row * (gapWidth + width) + gapWidth,
            width: width,
            height: width
        );
    }
    
    func getIndexPath(index: Int) -> (row: Int, col: Int) {
        return (index / dimmentions, index % dimmentions)
    }
    
    //MARK private
    func refreshCardsUI() {
        let cards = manager.cardViews
        for i in 0..<cards.count {
            if let c = cards[i] {
                let (row, col) = getIndexPath(i)
                c.frame = getPositionFor(row, col: col)
            }
        }
    }
    
    func leftSwipe() {
        print("leftSwipe()")
        self.manager.handleLeft()
    }

    func rightSwipe() {
        print("rightSwipe()")
        self.manager.handleRight()
    }
    
    func upSwipe() {
        print("upSwipe()")
        self.manager.handleTop()
    }
    
    func downSwipe() {
        print("downSwipe()")
        self.manager.handleBottom()
    }
}
