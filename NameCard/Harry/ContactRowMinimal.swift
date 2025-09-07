//
//  ContactRowMinimal.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI

struct ContactRowMinimal: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .regular))
            .foregroundColor(.gray)
            .tracking(0.5)
    }
}