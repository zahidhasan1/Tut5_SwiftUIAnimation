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
    @State private var isLoading = false
    var body: some View {
        VStack {
            HeartFillAnimation(circleColorChanged: $circleColorChanged, heartColorChanged: $heartColorChanged, heartSizeChanged: $heartSizeChanged)
            CircleLoaderAnimation(isLoading: $isLoading)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeartFillAnimation: View {
    
    @Binding var circleColorChanged: Bool
    @Binding var heartColorChanged: Bool
    @Binding var heartSizeChanged: Bool
    
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

struct CircleLoaderAnimation: View{
    @Binding var isLoading: Bool
    var body: some View{
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.green, lineWidth: 15)
            .frame(width: 150, height: 150)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            //.animation(.default.repeatForever(autoreverses: false), value: isLoading)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: false), value: isLoading)
            .onAppear(){
                isLoading = true
            }
    }
}
