//
//  MainViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation
import Combine
import UIKit

class MainViewPresenter: ObservableObject{
    
    func getUsername() -> String{
        return UserDefaults.standard.string(forKey: UserSettingKey.name) ?? ""
    }

    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor( .white )
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor( AppColors.darkBlueColor )], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
}
