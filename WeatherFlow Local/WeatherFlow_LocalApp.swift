import SwiftUI

@main
struct WeatherFlow_LocalApp: App {
  
  var body: some Scene {
    WindowGroup {
      
      WeatherView()
        .navigationTitle("WeatherFlow Local")
        .frame(
//          minWidth: 500,
//          maxWidth: 500,
//          minHeight: 380,
//          maxHeight: 380,
          alignment: .center
        )
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
          hideButtons()
        })

//      ContentView()
//        .navigationTitle("WeatherFlow Local")
//        .frame(
//          minWidth: 500,
//          maxWidth: 500,
//          minHeight: 380,
//          maxHeight: 380,
//          alignment: .center
//        )
      
    }
    .windowStyle(DefaultWindowStyle())
    .commands {
    }
    
  }
  
  func hideButtons() {
    for window in NSApplication.shared.windows {
      window.isMovableByWindowBackground = true
      window.collectionBehavior.insert(.fullScreenAuxiliary)
      window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
      window.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
      window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
    }
  }
  
}
