//
//  ProfileView.swift
//  W2WMatch
//
//  Created by Floron on 16.06.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var mainVm: MainViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("It's Profile View")
            
            Spacer()
            
            Button("Logout") {
                mainVm.logout()
            }
            
            Spacer()
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


#Preview {
    ProfileView()
        //.environmentObject(MainViewModel())
}
