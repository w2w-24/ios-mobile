//
//  Partners.swift
//  W2WMatch
//
//  Created by Floron on 16.06.2024.
//

import SwiftUI

struct PartnersView: View {
    
    @EnvironmentObject var mainVm: MainViewModel
    
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
            Text("It's Partners View")
            
            Spacer()
            
            Button("Запросить зарегистрированные бренды") {
                mainVm.getBrands()
            }
            
            Spacer()
        }
        
        
    }
}

#Preview {
    PartnersView()
        .environmentObject(MainViewModel())
}
