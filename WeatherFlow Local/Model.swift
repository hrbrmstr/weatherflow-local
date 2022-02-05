import Foundation
import Network
import SwiftUI
import Darwin 
import CocoaAsyncSocket

class AppModel: NSObject, ObservableObject, GCDAsyncUdpSocketDelegate {
  
  @Published var message: String = ""
  
  @Published var rapidWind: RapidWind?
  @Published var stationObservation: StationObservation?
  @Published var hubStatus: HubStatus?
  @Published var deviceStatus: DeviceStatus?
  
  var conn: NWConnection?
  var listener: NWListener?
  
  var udpSocket: GCDAsyncUdpSocket?
  var error: NSError?
  
  override init() {
    super.init()
    startReceiver()
  }
  
  func startReceiver() {
    
    do {
      
      udpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: .main)
      
      try udpSocket?.bind(toPort: 50222)
      try udpSocket?.beginReceiving()
      
    } catch {
      print("\(error)")
    }
    
  }
    
  func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
    processResult(data)
  }
  
  func processResult(_ data: Data) {
    
    let result = try? JSONDecoder().decode(JSON.self, from: data)
    
    if (result != nil) {
      
      if (result!.type.stringValue == "device_status") {
                
        DispatchQueue.main.async {
          
          self.deviceStatus = DeviceStatus(
            serialNumber: result!.serial_number.stringValue!,
            hubSerialNumber: result!.hub_sn.stringValue!,
            timestamp: Date(timeIntervalSince1970: result!.timestamp.doubleValue!),
            uptime: TimeInterval(result!.uptime.intValue!),
            voltage: result!.voltage.doubleValue!,
            firmwareRevision: result!.firmware_revision.intValue!,
            RSSI: result!.rssi.doubleValue!,
            hubRSSI: result!.hub_rssi.doubleValue!,
            sensorStatus: result!.sensor_status.intValue!,
            debug: result!.debug.intValue!
          )
          
        }
        
      } else if (result!.type.stringValue == "hub_status") {
        
        DispatchQueue.main.async {
          
          self.hubStatus = HubStatus(
            serialNumber: result!.serial_number.stringValue!,
            firmwareRevision: result!.firmware_revision.stringValue!,
            uptime: TimeInterval(result!.uptime.intValue!),
            RSSI: result!.rssi.doubleValue!,
            timestamp: Date(timeIntervalSince1970: result!.timestamp.doubleValue!),
            resetFlags: result!.reset_flags.stringValue!,
            seq: result!.seq.doubleValue!,
            radioVersion: result!.radio_stats[0]!.doubleValue!,
            rebootCount: result!.radio_stats[1]!.intValue!,
            i2cBusErrorCount: result!.radio_stats[2]!.intValue!,
            radioStatus: result!.radio_stats[3]!.intValue!,
            radioNetworkId: result!.radio_stats[4]!.intValue!
          )
          
        }
        
      } else if (result!.type.stringValue == "rapid_wind") {
        
        DispatchQueue.main.async {
          
          self.rapidWind = RapidWind(
            serialNumber: result!.serial_number.stringValue!,
            hubSerialNumber: result!.hub_sn.stringValue!,
            timeEpoch: Date(timeIntervalSince1970: result!.ob[0]!.doubleValue!),
            windSpeed: result!.ob[1]!.doubleValue!,
            windDirection: result!.ob[2]!.doubleValue!
          )
          
        }
        
      } else if (result!.type.stringValue == "obs_st") {
        
        DispatchQueue.main.async {
          
          self.stationObservation = StationObservation(
            serialNumber: result!.serial_number.stringValue!,
            hubSerialNumber: result!.hub_sn.stringValue!,
            timeEpoch: Date(timeIntervalSince1970: result!.obs[0]![0]!.doubleValue!),
            windLull: result!.obs[0]![1]!.doubleValue!,
            windAvg: result!.obs[0]![2]!.doubleValue!,
            windGust: result!.obs[0]![3]!.doubleValue!,
            windDirection: result!.obs[0]![4]!.doubleValue!,
            windSampleInterval: result!.obs[0]![5]!.doubleValue!,
            stationPressure: result!.obs[0]![6]!.doubleValue!,
            airTemperature: result!.obs[0]![7]!.doubleValue!,
            relativeHumidity: result!.obs[0]![8]!.doubleValue!,
            illuminance: result!.obs[0]![9]!.doubleValue!,
            UV: result!.obs[0]![10]!.doubleValue!,
            solarRadiation: result!.obs[0]![11]!.doubleValue!,
            rain: result!.obs[0]![12]!.doubleValue!,
            precipitationType: result!.obs[0]![13]!.intValue!,
            lightningStrikeAvgDistance: result!.obs[0]![14]!.doubleValue!,
            lightningStrikeCount: result!.obs[0]![15]!.intValue!,
            battery: result!.obs[0]![16]!.doubleValue!,
            reportInterval: result!.obs[0]![17]!.doubleValue!,
            firmwareRevision: result!.firmware_revision.intValue!
          )
          
        }
        
      }
      
    }
    
  }
  
}
