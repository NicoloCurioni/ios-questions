import Foundation
import PlaygroundSupport
import SwiftUI

struct FetchView1: View {
    
    @State private var rotation: Double = 0
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotation))
                .animation(.linear)
            Button("Button1", action: {
                rotation = (rotation < 360 ? rotation + 60 : 0)
            })
            Text("Rotate me")
        }
        .padding(10)
    }
}

let url = URL(string: "https://apple.com")!
let task = URLSession.shared.dataTask(with: url) {
    data, response, error in
    if let data = data {
        print(data)
    }
    if let response = response {
        print(response)
    }
    if let error = error {
        print(error)
    }
}
task.resume()

PlaygroundPage.current.setLiveView(FetchView1().padding(5))
