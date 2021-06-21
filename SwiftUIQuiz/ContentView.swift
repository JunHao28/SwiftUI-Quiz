//
//  ContentView.swift
//  SwiftUIQuiz
//
//  Created by sap on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    var questions = [Question(title: "When is WWDC?",
                              option1: "It has passed",
                              option2: "7th June",
                              option3: "Tommorrow",
                              option4: "Next Saturday",
                              correctAnswer: 1),
                     Question(title: "What framework are we using?",
                              option1: "UIKit",
                              option2: "SwiftUI",
                              option3: "React Native",
                              option4: "Flutter",
                              correctAnswer: 2),
                     Question(title: "Which company created Swift?",
                              option1: "Orange",
                              option2: "Apple",
                              option3: "Google",
                              option4: "Tinkercademy",
                              correctAnswer: 2),
                     Question(title: "How many jars of nutella can YJ eat",
                              option1: "2 only",
                              option2: "Depends but can eat a lot",
                              option3: "100",
                              option4: "Cannot eat",
                              correctAnswer: 2),
                     Question(title: "Did Jia Chen sleep last night?",
                              option1: "Yes",
                              option2: "No",
                              option3: "IDK",
                              option4: "Maybe",
                              correctAnswer: 2)]
    @State private var questionNumber = 0
    @State private var alertShown = false
    @State private var alertPositive = true
    @State private var numberOfCorrectQuestions = 0
    @State private var showScore = false
    @State var progressValue: Float = 0.0
    
    @State private var timeRemaining = 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var answeringQuestion = true
    
    
    
    fileprivate func nextQuestion() {
        alertShown = true
        answeringQuestion = false
    }
    fileprivate func checkAnswer(answer: Int) {
        if answer == questions[questionNumber].correctAnswer {
            alertPositive = true
            numberOfCorrectQuestions += 1
        } else {
            alertPositive = false
        }
    }
    
    var body: some View {
        VStack{
            Text("Question Number \(questionNumber + 1)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.trailing, 100.0)
            StraightProgressView(totalQuestions: questions.count, currentQuestions: questionNumber+1)
            Spacer()
                .frame(height: 100)
            Text("\(timeRemaining)")
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(100.0)
            Text(questions[questionNumber].title)
                .font(.title2)
                .padding()
            HStack {
                VStack {
                    Button(action: {
                        nextQuestion()
                        checkAnswer(answer: 1)
                    }){
                        HStack {
                            Image(systemName: "triangle.fill")
                            Text(questions[questionNumber].option1)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10.0)
                    .padding(1.0)
                    Button(action: {
                        nextQuestion()
                        checkAnswer(answer: 2)
                    }) {
                        HStack {
                            Image(systemName: "circle.fill")
                            Text(questions[questionNumber].option2)
                                .fontWeight(.semibold)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.yellow
                    )
                    .cornerRadius(10.0)
                    .padding(1.0)
                }
                VStack {
                    Button(action: {
                        nextQuestion()
                        checkAnswer(answer: 3)
                    }) {
                        HStack {
                            Image(systemName: "diamond.fill")
                            Text(questions[questionNumber].option3)
                                .fontWeight(.semibold)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .padding(1.0)
                    Button(action: {
                        nextQuestion()
                        checkAnswer(answer: 4)
                    }) {
                        HStack {
                            Image(systemName: "square.fill")
                            Text(questions[questionNumber].option4)
                                .fontWeight(.semibold)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10.0)
                    .padding(1.0)
                }
            }
            .alert(isPresented: $alertShown) {
                Alert(
                    title: Text(alertPositive ? "✅Correct!" : "❌Wrong!"),
                    message: Text(alertPositive ? "Congrats! You are kinda smart" : "This is outrageous! Such an easy question and you can still get it wrong? What's wrong with you?"),
                    dismissButton: .default(Text(alertPositive ? "Yay!" : "Sorry!")){
                        questionNumber += 1
                        progressValue += 1
                        if (questionNumber == questions.count){
                            showScore = true
                            questionNumber = 0
                        }
                        timeRemaining = 20
                        answeringQuestion = true
                        
                        
                    }
                )
            }
            Spacer()
                .frame(height: 200)
        }
        .onReceive(timer){ time in
            if answeringQuestion == true {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else if self.timeRemaining == 0{
                    alertShown = true
                    alertPositive = false
                }}
        }
        .padding(5.0)
        .sheet(isPresented: $showScore, onDismiss: {
            numberOfCorrectQuestions = 0
            timeRemaining = 20
            answeringQuestion = true
        }) {
            if (numberOfCorrectQuestions >= questions.count/2) {
                ScoreSheet(pass: true, score: numberOfCorrectQuestions, totalNumberOfQn: questions.count)
                
            } else {
                ScoreSheet(pass: false, score: numberOfCorrectQuestions, totalNumberOfQn: questions.count)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
