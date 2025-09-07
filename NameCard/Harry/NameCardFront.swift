//
//  NameCardFront.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI
import SafariServices

struct NameCardFront: View {
    let contact: Contact
    @State private var showingSafari = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section with name and title
            VStack(alignment: .leading, spacing: 8) {
                Text(contact.displayName)
                    .font(.system(size: 24, weight: .light, design: .default))
                    .foregroundColor(.white)
                    .tracking(2)
                    .padding(.top, 20)

                Text(contact.title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                    .tracking(1)
            }
            .padding(.horizontal, 30)

            Spacer()

            // Bottom section with contact info
            VStack(alignment: .leading, spacing: 6) {
                ContactRowMinimal(text: contact.email)
                ContactRowMinimal(text: contact.phone)
                ContactRowMinimal(text: contact.address)

                // Tappable website
                Button(action: {
                    showingSafari = true
                }) {
                    Text(contact.website)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.blue.opacity(0.8))
                        .tracking(0.5)
                        .underline()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: "https://\(contact.website)") ?? URL(string: "https://google.com")!)
        }
    }
}