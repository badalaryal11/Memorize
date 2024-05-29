//
//  ContentView.swift
//  Memorize
//
//  Created by Badal  Aryal on 27/05/2024.
//


import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🎃", "🕷", "👹", "👹"]
    
    var body: some View {
        HStack{
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
            
           
        }
        
        .foregroundColor(.green)
        .padding()
    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp = true
    
    var body: some View{
       
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
                if isFaceUp {
                
                   base.fill(.white)
                   base.strokeBorder(lineWidth: 2)
                   Text(content).font(.largeTitle)
            }else {
                base.fill()
                   
                
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
