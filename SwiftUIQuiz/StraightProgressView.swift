//
//  StraightProgressView.swift
//  SwiftUIQuiz
//
//  Created by sap on 20/6/21.
//

import SwiftUI

struct StraightProgressView: View {
    
    var totalQuestions:Int
    var currentQuestions:Int
//    var progress: CGFloat
    
    var body: some View {
      HStack(spacing: 4) {
        ForEach(0 ..< totalQuestions) { index in
          Rectangle()
            .foregroundColor(index < currentQuestions ? .accentColor
                                          : Color.secondary.opacity(0.3))
        }
      }
      .frame(maxHeight: 20)
      .clipShape(Capsule())
    }
}

struct StraightProgressView_Previews: PreviewProvider {
    static var previews: some View {
        StraightProgressView(totalQuestions: 5, currentQuestions: 1)
    }
}
