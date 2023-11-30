//
//  MapView.swift
//  SwiftUI Tutorial
//
//  Created by 권대윤 on 11/30/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(initialPosition: .region(region))
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.57861, longitude: 126.97722), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    
    
    
    
    
}

#Preview {
    MapView()
}
