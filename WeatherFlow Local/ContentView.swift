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
    if (txt != nil) {
      Text(txt!)
        .frame(alignment: .leading)
        .font(.system(size: size, weight: .light, design: .monospaced))
    } else {
      Image(systemName: "hourglass.circle")
        .foregroundColor(.gray)
    }
  }
  
}

struct WindRow: View {
  
  var speed: String?
  var time: String?
  
  var body: some View {
    HStack{
      Image(systemName: "wind")
        .foregroundColor(.green)
      OptionalText(txt: speed)
      NonOptionalText(txt: "@").foregroundColor(.yellow)
      OptionalText(txt: time).foregroundColor(.blue)
    }
    Divider()
  }
  
}

struct LuxRow: View {
  
  var uv: String?
  var illuminance: String?
  var solar: String?
  
  var body: some View {
    HStack {
      Image(systemName: "waveform.circle.fill")
        .foregroundColor(.green)
      OptionalText(txt: uv)
      Divider()
      Image(systemName: "light.max")
        .foregroundColor(.green)
      OptionalText(txt: illuminance)
      Divider()
      Image(systemName: "sun.max.circle")
        .foregroundColor(.green)
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
      Image(systemName: "thermometer")
        .foregroundColor(.green)
      OptionalText(txt: temp)
      Divider()
      Image(systemName: "humidity.fill")
        .foregroundColor(.green)
      OptionalText(txt: humid)
      Divider()
      Image(systemName: "rectangle.compress.vertical")
        .foregroundColor(.green)
      OptionalText(txt: pressure)
      NonOptionalText(txt: "@").foregroundColor(.yellow)
      OptionalText(txt: time).foregroundColor(.blue)
    }
    Divider()
  }
  
}

struct StrikeRainRow: View {
  
  var strikeCount: String?
  var strikeDistance: String?

  var body: some View {
    HStack {
      
      Image(systemName: "cloud.bolt")
        .foregroundColor(.green)
      OptionalText(txt: strikeCount)
      Divider()
      OptionalText(txt: strikeDistance)
    }
    Divider()
  }
  
}

struct RainRow: View {
  var rain: String?

  var body: some View {
    HStack {
      Image(systemName: "cloud.rain.fill")
        .foregroundColor(.green)
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
      
      Image(systemName: "sensor.tag.radiowaves.forward.fill")
        .foregroundColor(.green)
      
      OptionalText(txt: serial, size: 9)
      
      Divider()
      
      OptionalText(txt: uptime, size: 9)
      
      Divider()
      
      Image(systemName: "battery.100.bolt")
        .foregroundColor(.green)
      
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
      
      Image(systemName: "badge.plus.radiowaves.right")
        .foregroundColor(.green)
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
      
      WindRow(
        speed: model.rapidWind?.speedString,
        time: model.rapidWind?.timeString
      )
      
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
        strikeDistance: model.stationObservation?.strikeDistanceString
      )
                
      RainRow(
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
