//
//  ContentView.swift
//  Memorize
//
//  Created by Badal  Aryal on 27/05/2024.
//


import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷", "👹", "👹", "😍", "🤑", "😡", "😃", "😛","😜"]
   
    var body: some View {
        
            ScrollView {
                cards
            }
            
        
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
   
}
    
    
    
    
    struct CardView: View{
        let content: String
        @State var isFaceUp = true
        
        var body: some View{
            
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1: 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
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

