//
//  ContentView.swift
//  Tut5_SwiftUIAnimation
//
//  Created by ZEUS on 9/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? Color(.systemGray) : .red)

            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        //.animation(.default, value: circleColorChanged)
       // .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3) ,value: heartSizeChanged)

        //.animation(.default, value: circleColorChanged)

        .onTapGesture {
//            withAnimation(.default) {
//                circleColorChanged.toggle()
//                heartColorChanged.toggle()
//                heartSizeChanged.toggle()
//            }
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)){
                circleColorChanged.toggle()
                heartSizeChanged.toggle()
            }
            heartColorChanged.toggle()
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
