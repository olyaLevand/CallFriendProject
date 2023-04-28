//
//  VideoSwiftUIView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 28.04.2023.
//

import Foundation
import SinchRTC
import SwiftUI


struct VideoSwiftUIView: UIViewRepresentable {
    
    var client: SinchClient

    func makeUIView(context: Context) -> UIView {
        return client.videoController.remoteView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
//        uiView.view =
    }
}
