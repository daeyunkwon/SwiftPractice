//
//  CircleImage.swift
//  SwiftUI Tutorial
//
//  Created by 권대윤 on 11/30/23.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("Gyeongbokgung")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
