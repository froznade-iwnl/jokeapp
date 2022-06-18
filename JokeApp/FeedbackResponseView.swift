//
//  FeedbackResponseView.swift
//  JokeApp
//
//  Created by CTSS Students on 11/6/22.
//

import SwiftUI

struct FeedbackResponseView: View {
    
    var isPositive: Bool
    @State var pictRotation: Angle = .zero
    
    var body: some View {
        
        VStack{
            Text(isPositive ? "Here's a cookie for you 🍪":"Very mean... I will bite you nya!")
                .padding()

            Image(isPositive ? "happy" : "sad")
                .resizable()
                .scaledToFit()
                .rotationEffect(pictRotation)
                .onAppear(){
                    withAnimation(.easeInOut(duration: 0.5)) {
                        pictRotation = Angle(degrees: 360*5)
                    }
                }
                .onDisappear(){
                    pictRotation = .zero
                }
            
            
            Text("Swipe down to close")
                .italic()
                .bold()
                .font(.caption)
                .padding()
        }
        
    }
}

struct FeedbackResponseView_Previews: PreviewProvider {
    static var previews: some View {

        FeedbackResponseView(isPositive: false)
        FeedbackResponseView(isPositive: true)
    }
}
