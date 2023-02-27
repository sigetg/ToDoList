//
//  DetailView.swift
//  ToDoList
//
//  Created by George Sigety on 2/26/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    var passedValue: String
    
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundColor(.orange)
            Text("You are a swifty legend!\nAnd you passed over the value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Get Back") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(passedValue: "Item 1")
    }
}
