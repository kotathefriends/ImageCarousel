//
//  ContentView.swift
//  Image Carousel
//
//  Created by KOTA TAKAHASHI on 2024/03/14.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let images: [String] = ["image1", "image2", "image3", "image4", "image5"]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index])
                            .frame(width: 300, height: 500)
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y : 0)
                    }
                }
                .gesture(
                DragGesture()
                    .onEnded({ value in
                        let thrshould: CGFloat = 50
                        if value.translation.width > thrshould {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -thrshould {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        }
                    })
                )
            }
            .navigationTitle("Image Carousel")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(.title)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
