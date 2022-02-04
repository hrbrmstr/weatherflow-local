import SwiftUI

var m = AppModel()

struct ContentView: View {
  
  @ObservedObject var model = m
  
  var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
  var columnsFixed: [GridItem] = Array(repeating: .init(.fixed(90)), count: 2)
  var columnsOne: [GridItem] = Array(repeating: .init(.fixed(100)), count: 1)
  
  var body: some View {
    
    VStack {
      
      HStack {
        
        VStack(alignment: .center) {
          LazyVGrid(columns: columnsOne) {
            ForEach(model.rapidWind?.windVals ?? [], id: \.self) { txt in
              Text("\(txt)")
                .multilineTextAlignment(.center)
                .frame(width: 90, height: 90, alignment: .center)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                    .fill(.tertiary)
                )
                .padding(5)
            }
          }
        }
        
        Divider()
        
        VStack(alignment: .center) {
          LazyVGrid(columns: columnsFixed) {
            ForEach(model.stationObservation?.observations ?? [], id: \.self) { txt in
              Text("\(txt)")
                .multilineTextAlignment(.center)
                .frame(width: 100, height: 100, alignment: .center)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                    .fill(.tertiary)
                .padding(5)
                )
            }
          }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(width:300, height: 340)
        
      }
      
      Text(model.hubStatus?.hubLine ?? "Hub: || Uptime: | Rev:")
        .font(.caption2)
        .frame(width: 500)
        .padding(6)
      
    }
    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    
  }
  
}

