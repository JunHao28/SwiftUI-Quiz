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
            Text(pass ? "You got \(score)/\(totalNumberOfQn)! Pass!🎉🎉🎉" : "You got \(score)/\(totalNumberOfQn)! Fail!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            CircularProgressView(progress: CGFloat(score) / CGFloat(totalNumberOfQn))
                            .frame(width: 90, height: 90)
                .padding()
//            Text(pass ? "Hurray! You managed to pass the test! Here's a bubble tea for you! 🧋" : "Haiya... How can you fail the test! No bubble tea for you!")
//                .multilineTextAlignment(.center)
//                .padding()
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
        ScoreSheet(pass: true, score: 4, totalNumberOfQn: 5)
        ScoreSheet(pass: false, score: 2, totalNumberOfQn: 5)
    }
}
