//
//  ContentView.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isFlipped = false
    @State private var startTime = Date()

    private let contact = Contact(
        firstName: "Harry",
        lastName: "Ng",
        title: "iOS Developer",
        organization: "Feng Chia University",
        email: "contact@buildwithharry.com",
        phone: "+886-909-007-162",
        address: "Taichung, Taiwan",
        website: "buildwithharry.com",
        department: "AI Coding"
    )

    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            // Name Card
            ZStack {
                if !isFlipped {
                    // Front of card
                    NameCardFront(contact: contact)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                    // Back of card
                    NameCardBack(contact: contact)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 350, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(
                // Dark minimalist background
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 8)
            .rotation3DEffect(
                .degrees(isFlipped ? -180 : 0),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.3
            )
            .onTapGesture {
                withAnimation(.spring(response: 1.2, dampingFraction: 0.6, blendDuration: 0.2)) {
                    isFlipped.toggle()
                }
            }
            .onAppear {
                startTime = Date()
            }
        }
    }
}

#Preview {
    ContentView()
}
