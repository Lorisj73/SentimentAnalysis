//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by Loris JACOB on 1/26/24.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
    
    func color() -> Color {
        switch self {
        case .positive:
                Color.green
        case .negative:
            Color.red
        case .mixed:
            Color.purple
        case .neutral:
            Color.gray
        }
    }
    
    func emoji() -> String {
        switch self {
        case .positive:
            "😊"
        case .negative:
            "😡"
        case .mixed:
            "🤨"
        case .neutral:
            "😑"
        }
    }
}

struct ContentView: View {
    @State var modelOutput: Sentiment?
    @State var modelInput: String = "Entrez une phrase ici"
    
    func classify() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try SentimentsAnalitycs_1(configuration: .init())
            let prediction = try model.prediction(text: modelInput)
            modelOutput = Sentiment(rawValue: prediction.label)
            
            // A vous de travailler la suite
        } catch {
            modelOutput = nil
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Text("Entrez une phrase, l'IA va deviner votre sentiment")
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                    TextEditor(text: $modelInput)
                        .cornerRadius(12)
                        .padding()
                        .frame(height: 150)
                    Button(action: {
                            classify()
                    }, label: {
                        Text("Deviner le sentiment")
                    })
                    .buttonStyle(.borderedProminent)
                    .padding(20)
                    
                }
                .background(Color.purple)
                .cornerRadius(18)
                .padding(15)
                
                if let modelOutput {
                    Text(modelOutput.emoji() + "\n" + modelOutput.rawValue)
                        .frame(width: 360, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .background(Color(modelOutput.color()))
                        .cornerRadius(12)
                        .padding()
                        .multilineTextAlignment(.center)
                }
               
                
                
                Spacer()
            }
            .navigationBarTitle("🧠 IA du futur")
            
        }
    }
}

#Preview {
    ContentView()
}
