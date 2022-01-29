import SwiftUI

struct ContentView: View {
  
  @ObservedObject var model = AppModel()
  
  var body: some View {
    
    VStack {
      
      HStack {
        
        VStack {
          Text("Timestamp: \(model.rapidWindTimestamp)").padding()
          Text("Speed: \(model.rapidWindSpeed) mph").padding()
          Text("Direction: \(model.rapidWindDirection)°").padding()
        }.padding()
        
        Divider()
        
        VStack {
          Text("Timestamp: \(model.obsTimestamp)").padding()
          Text("Temperature: \(model.obsTemp)°F").padding()
          Text("Humidity: \(model.obsHumid)%").padding()
          Text("Pressure: \(model.obsPressure) mb").padding()
          Text("Wind Gust: \(model.obsGust) mph").padding()
        }.padding()
        
      }
      
      HStack {
        Text("\(model.hubSn) | \(model.hubTimestamp) | \(model.hubUptime) | \(model.hubFirmware)")
      }.padding()
      
    }
    
  }
  
}
