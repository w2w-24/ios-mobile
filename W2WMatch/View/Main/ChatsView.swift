//
//  ChatsView.swift
//  W2WMatch
//
//  Created by Floron on 16.06.2024.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject var mainVm: MainViewModel
    
    var body: some View {
        VStack {
            Text("It's Chats View")
            
            Button("Запросить анкету") {
                mainVm.getAnketa()
            }
        }
    }
}

#Preview {
    ChatsView()
        .environmentObject(MainViewModel())
}
