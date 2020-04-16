/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Authors:
 HOANG, Quang Huy (s3623383)
 DUONG, Huu Khang (s3635116)
 NGUYEN, Tan Thanh (s3634815)
 Created date: 21/09/2018
 Acknowledgment: 
 */

import UIKit

class GraphView: UIView {
    // declare variables
    var rawData : [Float]!
    var processed : [Float]!
    var touchPoint : Int?
    
    func setGarphValues(values: [Float]) {
        self.rawData = values
        ratioConverter()
        print(rawData[0])
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        graphLine()
        
        
    }
    
    func ratioConverter () {
        self.processed = [Float]()
        let delta = (rawData.max())! - (rawData.min())!
        for data in rawData {
            let temp = data - (rawData.min())!
            let result = temp / delta
            self.processed.append(result)
        }
    }
    func graphLine(){
        let graph = UIBezierPath()
        graph.move(to: .init(x: 10, y: 10 + Double((1 - processed[0])) * Double(bounds.height - 20)))
        for index in 1...processed.count - 1 {
            let x = 10 + (Double(bounds.width - 20) / Double (processed.count - 1)) * Double(index)
            let y = 10 + (1 - Double(processed[index])) * Double(bounds.height - 20)
            
            graph.addLine(to: .init(x: x, y: y))
            
            let yLine = UIBezierPath()
            yLine.move(to: .init(x: x, y: 0))
            yLine.addLine(to: .init(x: x, y: Double(bounds.height)))
            yLine.lineWidth = 1
            UIColor.white.setStroke()
            yLine.stroke(with: .copy, alpha: 0.15)
        }
        
        if let touched = self.touchPoint {
            let x = 10 + (Double(bounds.width - 20) / Double (processed.count - 1)) * Double(touched)
            let y = 10 + (1 - Double(processed[touched])) * Double(bounds.height - 20)
            let dot = UIBezierPath(arcCenter: .init(x: x, y: y), radius: 3, startAngle: 0, endAngle: 360, clockwise: true)
            UIColor.white.setFill()
            dot.fill(with: .copy, alpha: 0.8)
            
            let line = UIBezierPath()
            line.move(to: .init(x: x, y: 0))
            line.addLine(to: .init(x: x, y: Double(bounds.height)))
            line.lineWidth = 1
            UIColor.white.setStroke()
            line.stroke(with: .copy, alpha: 0.7)
        }
        // draw
        UIColor.white.setStroke()
        graph.lineWidth = 0.8
        graph.stroke()
    }
    
}
