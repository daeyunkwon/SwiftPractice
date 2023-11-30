//
//  ContentView.swift
//  SwiftUI Tutorial
//
//  Created by 권대윤 on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("경복궁").font(.title)
                HStack {
                    Text("서울특별시 종로구 사직로 161")
                        .font(.subheadline)
                    Spacer()
                    Text("대한민국")
                        .font(.subheadline)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("경복궁에 대해서")
                    .font(.title2)
                Text("조선시대의 궁궐 중 하나이자 조선의 정궁(법궁)이다. 사적 제117호로 지정받았다. 태조가 조선을 건국하고 한양 천도를 단행하면서 조선 시대에 가장 먼저 지은 궁궐이다.")
            }
            .padding()
            
            Spacer()
        }
        
        
    }
    
    
    
    
    
}

#Preview {
    ContentView()
}
