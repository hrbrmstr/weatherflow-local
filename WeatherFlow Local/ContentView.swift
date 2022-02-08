import SwiftUI

struct NonOptionalText: View {
  
  var txt: String
  var size: Double = 12
  
  var body: some View {
    Text(txt)
      .frame(alignment: .leading)
      .font(.system(size: size, weight: .light, design: .monospaced))
  }
  
}

struct OptionalText: View {
  
  var txt: String?
  var size: Double = 12
  
  var body: some View {
    Text(txt ?? "⏳")
      .frame(alignment: .leading)
      .font(.system(size: size, weight: .light, design: .monospaced))
  }
  
}

struct LuxRow: View {
  
  var uv: String?
  var illuminance: String?
  var solar: String?
  
  var body: some View {
    HStack {
      OptionalText(txt: uv)
      Divider()
      OptionalText(txt: illuminance)
      Divider()
      OptionalText(txt: solar)
    }
    Divider()
  }
  
}

struct StationRow: View {
  
  var temp: String?
  var humid: String?
  var pressure: String?
  var time: String?

  var body: some View {
    HStack {
      OptionalText(txt: temp)
      Divider()
      OptionalText(txt: humid)
      Divider()
      OptionalText(txt: pressure)
      NonOptionalText(txt: "@")
      OptionalText(txt: time)
    }
    Divider()
  }
  
}

struct StrikeRainRow: View {
  
  var strikeCount: String?
  var strikeDistance: String?
  var rain: String?

  var body: some View {
    HStack {
      OptionalText(txt: strikeCount)
      Divider()
      OptionalText(txt: strikeDistance)
      Divider()
      OptionalText(txt: rain)
    }
    Divider()
  }
  
}

struct DeviceRow: View {
  
  var serial: String?
  var uptime: String?
  var voltage: String?

  var body: some View {
    HStack {
      
      NonOptionalText(txt: "🛰", size: 9)
      OptionalText(txt: serial, size: 9)
      
      Divider()
      
      OptionalText(txt: uptime, size: 9)
      
      Divider()
      
      NonOptionalText(txt: "🔋", size: 9)
      OptionalText(txt: voltage, size: 9)
      
    }
    .frame(alignment: .leading)
    
    Divider()
  }
  
}

struct HubRow: View {
  
  var serial: String?
  var uptime: String?
  
  var body: some View {
    HStack {
      
      NonOptionalText(txt: "🎛", size: 9)
      OptionalText(txt: serial, size: 9)
      
      Divider()

      OptionalText(txt: uptime, size: 9)
      
    }
    .frame(alignment: .leading)

  }
}

var m = AppModel()

struct WeatherView: View {
  
  @ObservedObject var model = m
  
  var body: some View {
    
    VStack {

      OptionalText(txt: model.rapidWind?.windString)
      
      Divider()

      StationRow(
        temp: model.stationObservation?.tempString,
        humid: model.stationObservation?.humidString,
        pressure: model.stationObservation?.pressureString,
        time: model.stationObservation?.timeString
      )
      
      LuxRow(
        uv: model.stationObservation?.uvString,
        illuminance: model.stationObservation?.illuminanceString,
        solar: model.stationObservation?.solarString
      )
      
      StrikeRainRow(
        strikeCount: model.stationObservation?.strikeCountString,
        strikeDistance: model.stationObservation?.strikeDistanceString,
        rain: model.stationObservation?.rainString
      )
                
      DeviceRow(
        serial: model.deviceStatus?.serialNumber,
        uptime: model.deviceStatus?.uptimeString,
        voltage: model.deviceStatus?.voltageString
      )
      
      HubRow(
        serial: model.hubStatus?.serialNumber,
        uptime: model.hubStatus?.hubUptime
      )
            
    }
    .frame(alignment: .leading)
    .padding()
    .fixedSize(horizontal: true, vertical: true)
    
  } 

  
}
