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
    @State private var progress: CGFloat = 0.0
    
    //MARK: TransformingRectangleIntoCircle ANimation
    @State private var recordBegin = false
    @State private var recording = false
    
    var body: some View {
        VStack {
            HeartFillAnimation(circleColorChanged: $circleColorChanged, heartColorChanged: $heartColorChanged, heartSizeChanged: $heartSizeChanged)
                .padding()
//            CircleLoaderAnimation(isLoading: $isLoading)
//                .padding()
//            CircularProgressIndicator(progress: $progress)
//                .padding()
            
            //BarLoadingAnimation(isLoading: $isLoading)
               // .padding()
            
           // DotAnimation(isLoading: $isLoading)
            
            TransformingRectangleIntoCircleAnimation(recordBegin: $recordBegin, recording: $recording)
            Spacer()
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
                .frame(width: 150, height: 150)
                .foregroundColor(circleColorChanged ? Color(.systemGray) : .red)
            
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
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
        ZStack {
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 20)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(Color.green, lineWidth: 12)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                //.animation(.default.repeatForever(autoreverses: false), value: isLoading)
                .animation(.linear(duration: 0.5).repeatForever(autoreverses: false), value: isLoading)
                .onAppear(){
                    isLoading = false
            }
        }
    }
}

struct CircularProgressIndicator: View{
    @Binding var progress: CGFloat
    var body: some View{
        ZStack{
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded, weight: .bold))
            
            Circle()
                .stroke( Color(.systemGray4), lineWidth: 20)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.green, lineWidth: 20)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
                .onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        self.progress += 0.05
                        if self.progress >= 1.0{
                            timer.invalidate()
                        }
                    }
                }
        }

    }
}

struct BarLoadingAnimation: View{
    @Binding var isLoading: Bool
    var body: some View{
        ZStack{
            Text("Loading").font(.system(.title, weight: .bold))
                .foregroundColor(.accentColor)
                .offset(y:-25)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250,height: 3)
            
//            RoundedRectangle(cornerRadius: 3)
//            .stroke(Color(.systemGray5), lineWidth: 3)
//            .frame(width: 250, height: 3)
            
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.accentColor, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(.linear(duration: 0.5).repeatForever(autoreverses: false), value: isLoading)
                .onAppear(){
                    isLoading = false
                }
            

        }
    }
}

struct DotAnimation: View{
    @Binding var isLoading: Bool
    var body: some View{
        HStack{
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10,height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1.5)
                    .animation(.linear(duration: 0.8).repeatForever().delay(0.3 * Double(index)), value: isLoading)
            }
        }
        .onAppear(){
            isLoading = true
        }
    }
}

struct TransformingRectangleIntoCircleAnimation: View{
    @Binding var recordBegin: Bool
    @Binding var recording: Bool
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )
            RoundedRectangle(cornerRadius: recordBegin ? 35: 10)
                .trim(from: 0, to: recordBegin ? 0.001 : 1.0)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(recordBegin ? .red : .green)
        }
        .onTapGesture {
            withAnimation(Animation.spring()){
                self.recordBegin.toggle()
            }
            
            withAnimation(Animation.spring().repeatForever().delay(0.5)){
                self.recording.toggle()
            }
        }
    }
}
