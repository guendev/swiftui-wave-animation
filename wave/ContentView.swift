//
//  ContentView.swift
//  wave
//
//  Created by Guen on 31/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            WaveForm(color: .purple.opacity(0.4), amplify: 150, isResverd: false)
            
            WaveForm(color: .purple.opacity(0.2), amplify: 200, isResverd: true)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WaveForm: View {
    
    var color: Color
    var amplify: CGFloat
    var isResverd: Bool
    
    var body: some View {
        TimelineView(.animation) { timeLine in
                    
            Canvas { context, size in
                
                let timeNow = timeLine.date.timeIntervalSinceReferenceDate
                
                let angle = timeNow.remainder(dividingBy: 2)
                
                let offset = angle * size.width
                            
                context.translateBy(x: isResverd ? offset : -offset, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: -size.width, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: size.width * 2, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
            }
        }
    }
    
    func getPath(size: CGSize) -> Path {
        Path { path in
            
            let midHeight = size.height / 2
            let width = size.width
            
            // moving the content to topLeading
            path.move(to: CGPoint(x: 0, y: midHeight))
            
            // drawing curve
            path.addCurve(to: CGPoint(x: width, y: midHeight), control1: CGPoint(x: width * 0.4, y: midHeight + amplify), control2: CGPoint(x: width * 0.65, y: midHeight - amplify))
            
            // filling bottom
            path.addLine(to: CGPoint(x: width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
        }
    }
}
