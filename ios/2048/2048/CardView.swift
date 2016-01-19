//
//  CardView.swift
//  2048
//
//  Created by 文凡胡 on 1/16/16.
//  Copyright © 2016 Th. All rights reserved.
//

import UIKit

class CardView: UIView {
    var label: UILabel

    var bgColors: [UIColor] = [
        UIColor(string: "#EEE4D9"), //2
        UIColor(string: "#EDE0C7"), //4
        UIColor(string: "#F3B274"), //8
        UIColor(string: "#F7955D"), //16
        UIColor(string: "#F87C5A"), //32
        UIColor(string: "#F95D31"), //64
        UIColor(string: "#EED06B"), //128
        UIColor(string: "#EECD58"), //256
        UIColor(string: "#EEC943"), //512
        UIColor(string: "#EEC62C"), //1024
        UIColor(string: "#FF0000") //2048
    ]
    
    var fgColors: [UIColor] = [
        UIColor(string: "#776E64"), //2
        UIColor(string: "#776E64"), //4
        UIColor(string: "#F9F6F2"), //8
        UIColor(string: "#F9F6F2"), //16
        UIColor(string: "#F9F6F2"), //32
        UIColor(string: "#F9F6F2"), //64
        UIColor(string: "#F9F6F2"), //128
        UIColor(string: "#F9F6F2"), //256
        UIColor(string: "#F9F6F2"), //512
        UIColor(string: "#F9F6F2"), //1024
        UIColor(string: "#F9F6F2") //2048
    ]

    var value:Int? {
        didSet {
            self.backgroundColor = bgColors[value! - 1]
            self.label.text = "\(1 << value!)"
            self.label.textColor = fgColors[value! - 1]
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init() {
        label = UILabel()
        super.init(frame: CGRectZero)
        addSubview(label)
        layer.cornerRadius = 8
        clipsToBounds = true
        label.textAlignment = .Center
        label.font =  UIFont.boldSystemFontOfSize(36)
    }
    
    override func layoutSubviews() {
        print("frame: \(self.frame)")
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}