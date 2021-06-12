//
//  ScoreSheet.swift
//  SwiftUIQuiz
//
//  Created by sap on 5/6/21.
//

import SwiftUI

struct ScoreSheet: View {
    var pass:Bool
    var score:Int
    var totalNumberOfQn:Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Image(pass ? "happy" : "sad")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(pass ? "Pass!" : "Fail!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("You got \(score)/\(totalNumberOfQn)")
            Text(pass ? "Hurray! You managed to pass the test! Here's a bubble tea for you! 🧋" : "Haiya... How can you fail the test! No bubble tea for you!")
                .multilineTextAlignment(.center)
                .padding()
            Button("Dismiss Me") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10.0)
        }
    }
}

struct ScoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSheet(pass: true, score: 2, totalNumberOfQn: 3)
        ScoreSheet(pass: false, score: 2, totalNumberOfQn: 3)
    }
}
