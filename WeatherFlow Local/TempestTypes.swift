import Foundation

//{
//  "serial_number": "SK-00008453",
//  "type":"rapid_wind",
//  "hub_sn": "HB-00000001",
//  "ob":[1493322445,2.3,128]
//}

public struct RapidWind {
  
  var serialNumber: String
  var hubSerialNumber: String
  var timeEpoch: Date
  var windSpeed: Double // mps
  var windDirection: Double // degrees
  
  var windVals: [String] {
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST5EDT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd\nHH:mm:ss"
    
    return([
      dateFormatter.string(from: timeEpoch),
      String(format: "💨%.1f\nmph", windSpeed / 0.44704),
      String(format: "🧭%3.1f°", windDirection)
    ])
    
  }
  
}

//{
//  "serial_number": "ST-00000512",
//  "type": "obs_st",
//  "hub_sn": "HB-00013030",
//  "obs": [
//    [1588948614,0.18,0.22,0.27,144,6,1017.57,22.37,50.26,328,0.03,3,0.000000,0,0,0,2.410,1]
//  ],
//  "firmware_revision": 129
//}
//0  TimeEpoch  Seconds
//1  WindLull (minimum 3 second sample)  m/s
//2  WindAvg (average over report interval)  m/s
//3  WindGust (maximum 3 second sample)  m/s
//4  WindDirection  Degrees
//5  WindSample Interval  seconds
//6  StationPressure  MB
//7  AirTemperature  C
//8  RelativeHumidity  %
//9  Illuminance  Lux
//10  UV  Index
//11  SolarRadiation  W/m^2
//12  Rain amount over previous minute  mm
//13  PrecipitationType  0 = none, 1 = rain, 2 = hail, 3 = rain + hail (experimental)
//14  LightningStrikeAvgDistance  km
//15  LightningStrikeCount
//16  Battery  Volts
//17  ReportInterval  Minutes

public struct StationObservation {
  
  var serialNumber: String
  var hubSerialNumber: String
  var timeEpoch: Date
  var windLull: Double // m/s
  var windAvg: Double // m/s
  var windGust: Double // m/s
  var windDirection: Double
  var windSampleInterval: Double
  var stationPressure: Double
  var airTemperature: Double
  var relativeHumidity: Double
  var illuminance: Double
  var UV: Double
  var solarRadiation: Double
  var rain: Double
  var precipitationType: Int
  var lightningStrikeAvgDistance: Double
  var lightningStrikeCount: Int
  var battery: Double
  var reportInterval: Double
  var firmwareRevision: Int
  
  var observations: [String] {
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST5EDT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd\nHH:mm:ss"
    
    return([
      dateFormatter.string(from: timeEpoch),
      String(format: "🌡%.1f°F", ((airTemperature * 9/5)) + 32.0),
      String(format: "💦%.1f%%\nHumidity", relativeHumidity),
      String(format: "⍖%.1f\nmb", stationPressure),
      String(format: "🌬%.1f\nmph", windGust / 0.44704),
      String(format: "⚡️%2.1f\nvolts", battery)
    ])
    
  }
  
}

//{
//  "serial_number":"HB-00000001",
//  "type":"hub_status",
//  "firmware_revision":"35",
//  "uptime":1670133,
//  "rssi":-62,
//  "timestamp":1495724691,
//  "reset_flags": "BOR,PIN,POR",
//  "seq": 48,
//  "fs": [1, 0, 15675411, 524288],
//  "radio_stats": [2, 1, 0, 3, 2839],
//  "mqtt_stats": [1, 0]
//}

public struct HubStatus {
  
  var serialNumber: String
  var firmwareRevision: String
  var uptime: TimeInterval
  var RSSI: Double
  var timestamp: Date
  var resetFlags: String
  var seq: Double
  var radioVersion: Double
  var rebootCount: Int
  var i2cBusErrorCount: Int
  var radioStatus: Int
  var radioNetworkId: Int
  
  var hubUptime: String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .brief
    formatter.zeroFormattingBehavior = .pad
    
    return(String(formatter.string(from: TimeInterval(uptime))!))
  }
  
  var hubTimestamp: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST5EDT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return(dateFormatter.string(from: timestamp))
  }
  
  var hubLine: String {
    return("Hub: \(serialNumber) | \(hubTimestamp) | Uptime: \(hubUptime) | Rev: \(firmwareRevision)")
  }
  
}

