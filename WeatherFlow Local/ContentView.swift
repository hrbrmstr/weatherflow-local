import SwiftUI

var m = AppModel()

struct WeatherView: View {
  
  @ObservedObject var model = m
  
  var body: some View {
    
    VStack {

      Text(model.rapidWind?.windString ?? "")
        .frame(alignment: .leading)
        .font(.system(size: 12, weight: .light, design: .monospaced))
      
      Divider()

      HStack {
        
        Text(model.stationObservation?.tempString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))
        
        Text(model.stationObservation?.humidString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))

        Text(model.stationObservation?.pressureString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))
        
        Text("@")
          .font(.system(size: 12, weight: .light, design: .monospaced))
        
        Text(model.stationObservation?.timeString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))

      }
      
      Divider()

      HStack {
        
        Text(model.stationObservation?.uvString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))
        
        Text(model.stationObservation?.illuminanceString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))
        
        Text(model.stationObservation?.solarString ?? "")
          .frame(alignment: .leading)
          .font(.system(size: 12, weight: .light, design: .monospaced))

      }
      
      Divider()
      
      HStack {

        Text("🛰")
          .font(.system(size: 9, weight: .light, design: .monospaced))

        Text(model.deviceStatus?.serialNumber ?? "")
          .font(.system(size: 9, weight: .light, design: .monospaced))
        
        Divider()
        
        Text(model.deviceStatus?.uptimeString ?? "")
          .font(.system(size: 9, weight: .light, design: .monospaced))
        
        Divider()
        
        Text("🔋")
          .font(.system(size: 9, weight: .light, design: .monospaced))
        
        Text(model.deviceStatus?.voltageString ?? "")
          .font(.system(size: 9, weight: .light, design: .monospaced))

      }
      .frame(alignment: .leading)

      Divider()
      
      HStack {
        
        Text("🎛")
          .font(.system(size: 9, weight: .light, design: .monospaced))
        
        Text(model.hubStatus?.serialNumber ?? "")
          .font(.system(size: 9, weight: .light, design: .monospaced))

        Divider()
        
        Text(model.hubStatus?.hubUptime ?? "")
          .font(.system(size: 9, weight: .light, design: .monospaced))
        
      }
      .frame(alignment: .leading)
      
    }
    .frame(alignment: .leading)
    .padding()
    .fixedSize(horizontal: true, vertical: true)
    
  } 

  
}

//struct ContentView: View {
//  
//  @ObservedObject var model = m
//  
//  var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//  var columnsFixed: [GridItem] = Array(repeating: .init(.fixed(90)), count: 2)
//  var columnsOne: [GridItem] = Array(repeating: .init(.fixed(100)), count: 1)
//  
//  var body: some View {
//    
//    VStack {
//      
//      HStack {
//        
//        VStack(alignment: .center) {
//          LazyVGrid(columns: columnsOne) {
//            ForEach(model.rapidWind?.windVals ?? [], id: \.self) { txt in
//              Text("\(txt)")
//                .multilineTextAlignment(.center)
//                .frame(width: 90, height: 90, alignment: .center)
//                .background(
//                  RoundedRectangle(cornerRadius: 10)
//                    .fill(.tertiary)
//                )
//                .padding(5)
//            }
//          }
//        }
//        
//        Divider()
//        
//        VStack(alignment: .center) {
//          LazyVGrid(columns: columnsFixed) {
//            ForEach(model.stationObservation?.observations ?? [], id: \.self) { txt in
//             Text("\(txt)")
//                .multilineTextAlignment(.center)
//                .frame(width: 100, height: 100, alignment: .center)
//                .background(
//                  RoundedRectangle(cornerRadius: 10)
//                    .fill(.tertiary)
//                .padding(5)
//                )
//            }
//          }
//        }
//        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        .frame(width:300, height: 340)
//        
//      }
//      
//      Text(model.hubStatus? .hubLine ?? "Hub: || Uptime: | Rev:")
//        .font(.caption2)
//        .frame(width: 500)
//        .padding(6)
//      
//    }
//    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//    
//  }
//  
//}

