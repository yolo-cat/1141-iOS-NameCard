//
//  NameCardBack.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI

struct NameCardBack: View {
    let contact: Contact

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Company/University info
            VStack(spacing: 12) {
                Text(contact.organization)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                    .tracking(1.5)

                Text(contact.department)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .tracking(1)
            }

            Spacer()

            // QR Code section
            VStack(spacing: 12) {
                QRCodeView(contactInfo: contact.toVCard())
                    .frame(width: 80, height: 80)

                Text("SCAN TO CONNECT")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.gray)
                    .tracking(1)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaleEffect(x: -1, y: 1) // Flip horizontally so text reads correctly when card is flipped
    }
}