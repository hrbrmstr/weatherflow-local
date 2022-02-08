import SwiftUI

@main
struct WeatherFlow_LocalApp: App {
  
  var body: some Scene {
    WindowGroup {
      
      WeatherView()
        .navigationTitle("WeatherFlow Local")
        .frame(
          minWidth: 386,
          minHeight: 197,
          alignment: .center
        )
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
          hideButtons()
        })

    }
    .windowStyle(DefaultWindowStyle())
    .commands {
    }
    
  }
  
  func hideButtons() {
    
    for window in NSApplication.shared.windows {
      
      if (window.title == "WeatherFlow Local") {
        window.isMovableByWindowBackground = true
        window.collectionBehavior.insert(.fullScreenAuxiliary)
        window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
        window.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
        window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
      }
      
    }
    
  }
  
}
