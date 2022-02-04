import SwiftUI

@main
struct WeatherFlow_LocalApp: App {
  
  var body: some Scene {
    WindowGroup {
      
      ContentView()
        .navigationTitle("WeatherFlow Local")
        .frame(
          minWidth: 500,
          maxWidth: 500,
          minHeight: 380,
          maxHeight: 380,
          alignment: .center
        )
      
    }.commands {
      CommandGroup(replacing: .newItem, addition: { })
    }
    
  }
  
  
}
