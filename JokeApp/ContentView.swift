//
//  ContentView.swift
//  JokeApp
//
//  Created by CTSS Students on 11/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var jokeCount = 0
    @State var jokeStat = false //Summon alert
    @State var feedbackStat = false //alert result
    
    @State var sheetPresented = false //show sheet is summoned or not
    @State var sheetResponse = true //show + or - resp.
    
    @State var punchlineSize = 0.1
    @State var punchlineAngle : Angle = .zero
    @State var punchlineOpacity = 0.0
    @State var tapToContinueOffset = 50.0
    
    var jokes = [Joke(setup: "Why did the chicken cross the road?", punchline: "To get to the other side!"),
        Joke(setup: "Why couldn't the bicycle stand up?", punchline: "It was two tired!"),
        Joke(setup: "Is this pool safe for diving?", punchline: "It deep ends"),
        Joke(setup: "Where do you learn to make ice cream?", punchline: "Sunday School"),
        Joke(setup: "Did you hear about the cheese factory that exploded in France?", punchline: "There was nothing left but de Brie"),
        Joke(setup: "Dad, can you put my shoes one?", punchline: "I dont think they'll fit me"),
                 Joke(setup: "Tell me a joke", punchline: "you")]
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.teal, .indigo]), startPoint: .top, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if jokeStat {
                        jokeStat = false
                        jokeCount += 1
                        feedbackStat = true
                    }
                }
            
            VStack{
                Text(jokes[jokeCount%jokes.count].setup)
                    .padding()
                
                Button {
                    jokeStat = true
                }label:{
                    
                    Text("What? **_Tell me_**")
                        .foregroundColor(.white)
                        .padding()
                    .background(Color.blue)
                    
                }
                
                .padding()
                
                if jokeStat {
                    Text(jokes[jokeCount%jokes.count].punchline)
                        .scaleEffect(punchlineSize)
                        .rotationEffect(punchlineAngle)
                        .opacity(punchlineOpacity)
                        .padding()
                        .onAppear(){
                            withAnimation(.easeInOut(duration: 0.5)) {
                                punchlineSize = 2
                                punchlineAngle = Angle(degrees: 360*4)
                                punchlineOpacity = 1
                                tapToContinueOffset = 0
                            }
                        }
                        .onDisappear(){
                            punchlineSize = 0.1
                            punchlineAngle = .zero
                            punchlineOpacity = 0
                            tapToContinueOffset = 50
                        }
                
                
                    Divider()
                    
                    Text("Tap to continue")
                        .italic()
                        .font(.caption)
                        .opacity(punchlineOpacity)
                        .offset(x: 0, y: tapToContinueOffset)
                    
                }
            }
        }
        .alert("Did you like that joke?", isPresented: $feedbackStat){
            Button("Yes"){
                sheetResponse = true
                sheetPresented = true
            }
            Button(role: .cancel){
                sheetResponse = false
                sheetPresented = true
            }label: {
                Text("No")
            }
        }
        .sheet(isPresented: $sheetPresented){
            FeedbackResponseView(isPositive: sheetResponse)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
