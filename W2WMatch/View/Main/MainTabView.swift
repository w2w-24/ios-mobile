//
//  TabView.swift
//  W2WMatch
//
//  Created by Floron on 16.06.2024.
//


import Foundation
import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case partners = 0
    case match = 1
    case main = 2
    case chat = 3
    case profile = 4
    
    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .partners:
            return "Партнеры"
        case .match:
            return "Мэтч"
        case .chat:
            return "Чаты"
        case .profile:
            return "Профиль"
        }
    }
    
    var iconName: String {
        switch self {
        case .main:
            return "iconMain"
        case .partners:
            return "iconPartners"
        case .match:
            return "iconMatch"
        case .chat:
            return "iconChats"
        case .profile:
            return "iconProfile"
        }
    }
}


struct MainTabView: View {
    @State var selectedTab = 2
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                PartnersView()
                    .tag(0)
                MatchView()
                    .tag(1)
                MainScreen()
                    .tag(2)
                ChatsView()
                    .tag(3)
                ProfileView()
                    .tag(4)
            }
            
            HStack(spacing: 25) {
                    
                ForEach((TabbedItems.allCases), id: \.self) { item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                    }
                }
                
            }
        }
    }
    
    
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 0){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? Color("W2wBlueColor") : .gray)
                .frame(width: 30, height: 30)
           
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(isActive ? Color("W2wBlueColor") : .gray)
        }
    }
}

#Preview {
    MainTabView()
}

