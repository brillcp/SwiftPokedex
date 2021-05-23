//
//  ProgressBar.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-22.
//

import UIKit

final class StatBar: UIView {
    
    //MARK: Private properties
    var color: UIColor? = .clear { didSet { setNeedsDisplay() } }
    var value: Int = 0 { didSet { setNeedsDisplay() }}
    var maxValue: Int = 0 { didSet { setNeedsDisplay() }}
    
    //MARK: - Init
    init(frame: CGRect = .zero, maxValue: Int = 100) {
        self.maxValue = maxValue
        
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Draw
    override func draw(_ rect: CGRect) {
        let radius = rect.height / 2.0
        drawWhitePath(in: rect, radius: radius)
        
        var newRect = rect
        let maxVal: CGFloat = CGFloat(max(value, maxValue))
        newRect.size.width = (CGFloat(value) / maxVal) * rect.width
        drawProgress(in: newRect, radius: radius)
        drawText(in: newRect)
    }
    
    //MARK: - Private functions
    private func drawWhitePath(in rect: CGRect, radius: CGFloat) {
        let whitePath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        UIColor.darkGray.setFill()
        whitePath.fill()
    }
    
    private func drawProgress(in rect: CGRect, radius: CGFloat) {
        let progressPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        color?.setFill()
        progressPath.fill()
    }
    
    private func drawText(in rect: CGRect) {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.pixel12, .foregroundColor: UIColor.white]
        let string = NSAttributedString(string: "\(value)/\(max(value, maxValue))", attributes: attrs)
        let labelWidth: CGFloat = 55.0
        
        var textFrame = CGRect(x: 0.0, y: 1.0, width: labelWidth, height: rect.height)
        
        if rect.width >= labelWidth {
            textFrame.origin.x = rect.width - labelWidth
        } else {
            textFrame.origin.x = rect.width + 5.0
        }
        
        string.draw(in: textFrame)
    }
}
