//
//  OtisApp.swift
//  Otis
//
//  Created by Clemens Sageder on 5/2/23.
//

import SwiftUI

@main
struct OtisApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GlobalEnvironment())
        }
#if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
#endif
    }
    
#if os(macOS)
    func hideZoomButton() {
        for window in NSApplication.shared.windows {
            window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isEnabled = false
        }
    }
#endif
}
