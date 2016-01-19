//
//  Data.swift
//  2048
//
//  Created by 文凡胡 on 1/18/16.
//  Copyright © 2016 Th. All rights reserved.
//

import Foundation
import UIKit

class GameManager {
    var dimention: Int
    var rootView: UIView
    var cardViews: [CardView?]
    
    init(dimention: Int, rootView: UIView) {
        self.dimention = dimention
        self.rootView = rootView
        cardViews = [CardView?](count: dimention * dimention, repeatedValue: nil)
    }
    
    func createNew() {
        if (isFull()) {
            print("full")
            return
        }
        if (isFinish()) {
            print("finish")
            return
        }
        let c = CardView()
        c.value = randomValue()
        self.rootView.addSubview(c)
        cardViews[randomIndex()] = c
    }
    
    func randomValue() -> Int {
        let r = Int(arc4random_uniform(10))
        if r == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func randomIndex() -> Int {
        let count = emptyCount()
        let r = Int(arc4random_uniform(UInt32(count)))
        return emptyPositions()[r]
    }
    
    func emptyCount() -> Int {
        return emptyPositions().count
    }
    
    func emptyPositions() -> [Int] {
        var rst = [Int]()
        for i in 0..<cardViews.count {
            if cardViews[i] == nil {
                rst.append(i)
            }
        }
        return rst
    }
    
    func isFull() -> Bool {
        return emptyPositions().count == 0
    }
    
    func isFinish() -> Bool {
        for i in 0..<cardViews.count {
            if let c = cardViews[i] {
                if c.value ==  10 {
                    return true
                }
            }
        }
        return false
    }
    
    func handleLeft() {
        printSubViews()
        let col = 0
        for row in 0..<self.dimention {
            var oriView = [CardView?]()
            for i in 0..<self.dimention {
               oriView.append(self.cardViews[getIndexFor(row, col: col + i)])
            }
            let newView = press(oriView)
            for i in 0..<self.dimention {
                self.cardViews[getIndexFor(row, col: col + i)] = newView[i]
            }
        }
        print("after handleLeft")
        self.rootView.setNeedsLayout()
        printSubViews()
        self.createNew()
    }
    
    func handleRight() {
        printSubViews()
        let col = self.dimention - 1
        for row in self.dimention..<0 {
            var oriView = [CardView?]()
            for i in 0..<self.dimention {
               oriView.append(self.cardViews[getIndexFor(row, col: col + i)])
            }
            let newView = press(oriView)
            for i in 0..<self.dimention {
                self.cardViews[getIndexFor(row, col: col + i)] = newView[i]
            }
        }
        print("after handleLeft")
        self.rootView.setNeedsLayout()
        printSubViews()
        self.createNew()
    }
    
    
    func handleTop() {
        printSubViews()
        let row = 0
        for col in 0..<self.dimention {
            var oriView = [CardView?]()
            for i in 0..<self.dimention {
               oriView.append(self.cardViews[getIndexFor(row + i, col: col)])
            }
            let newView = press(oriView)
            for i in 0..<self.dimention {
                self.cardViews[getIndexFor(row + i, col: col)] = newView[i]
            }
        }
        print("after handleLeft")
        self.rootView.setNeedsLayout()
        printSubViews()
        self.createNew()
        
    }
    
    func handleBottom() {
        printSubViews()
        let row = self.dimention - 1
        for col in self.dimention..<0 {
            var oriView = [CardView?]()
            for i in 0..<self.dimention {
               oriView.append(self.cardViews[getIndexFor(row + i, col: col)])
            }
            let newView = press(oriView)
            for i in 0..<self.dimention {
                self.cardViews[getIndexFor(row + i, col: col)] = newView[i]
            }
        }
        print("after handleLeft")
        self.rootView.setNeedsLayout()
        printSubViews()
        self.createNew()
    }
    
    func getIndexFor(row: Int, col: Int) -> Int {
        return row * dimention + col;
    }
   
    func press(views: [CardView?]) -> [CardView?] {
        var rst = [CardView?](count: views.count, repeatedValue: nil)
        var index = 0
        for v in views {
            if v != nil {
                rst[index++] = v
            }
        }
        for i in 0..<rst.count {
            if i < rst.count - 1 {
                if let c = rst[i], nc = rst[i + 1] {
                    if c.value! == nc.value! {
                        c.value = c.value! + 1
                        rst[i + 1]?.removeFromSuperview()
                        rst[i + 1] = nil
                        
                        if i + 1 < rst.count - 2 {
                            for j in i + 1..<rst.count - 2 {
                                rst[j] = rst[j + 1]
                            }
                        }
                    }
                }
            }
        }
        
        var rst1 = [CardView?](count: views.count, repeatedValue: nil)
        
        for v in rst {
            if v != nil {
                rst1[index++] = v
            }
        }
        return rst
    }
   
    
    func printSubViews() {
        for r in 0..<self.dimention {
            for c in 0..<self.dimention {
                let index = getIndexFor(r, col: c)
                if let v = self.cardViews[index] {
                    print(v.value!, terminator: "")
                } else {
                    print("0", terminator: "")
                }
                print("\t", terminator: "")
            }
            print("\n", terminator: "")
        }
    }
    
}