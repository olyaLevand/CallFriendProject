//
//  SplashView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.05.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("bluePhoneIcon")
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.main.bounds.height)
            .background(AppColors.darkBlueColor)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
