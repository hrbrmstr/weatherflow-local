import Foundation
import Network
import SwiftUI
import Darwin 
import CocoaAsyncSocket

class AppModel: NSObject, ObservableObject, GCDAsyncUdpSocketDelegate {
  
  @Published var message: String = ""
  
  @Published var hubSn: String = ""
  @Published var hubFirmware: String = ""
  @Published var hubUptime: String = ""
  @Published var hubTimestamp: String = ""
  
  @Published var wind: [String] = []
  @Published var observations: [String] = []
  
  var conn: NWConnection?
  var listener: NWListener?
  
  var udpSocket: GCDAsyncUdpSocket?
  var error: NSError?
  
  let dateFormatter = DateFormatter()
  let dateFormatter2 = DateFormatter()
  let formatter = DateComponentsFormatter()
  
  override init() {
    
    super.init()
    
    dateFormatter.timeZone = TimeZone(abbreviation: "EST5EDT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd\nHH:mm:ss"
    
    dateFormatter2.timeZone = TimeZone(abbreviation: "EST5EDT")
    dateFormatter2.locale = NSLocale.current
    dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .brief
    formatter.zeroFormattingBehavior = .pad
    
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
    
    let result = try? JSONDecoder().decode(JSON.self, from: data)
    
    if (result != nil) {
      
      if (result!.type.stringValue == "hub_status") {
        
        let date = Date(timeIntervalSince1970: result!.timestamp.doubleValue!)
        
        DispatchQueue.main.async {
          self.hubSn = result!.serial_number.stringValue!
          self.hubFirmware = result!.firmware_revision.stringValue!
          self.hubUptime = String(self.formatter.string(from: TimeInterval(result!.uptime.intValue!))!)
          self.hubTimestamp = self.dateFormatter2.string(from: date)
        }
        
      } else if (result!.type.stringValue == "rapid_wind") {
        
        let date = Date(timeIntervalSince1970: result!.ob[0]!.doubleValue!)
        
        DispatchQueue.main.async {
          
          self.wind = [self.dateFormatter.string(from: date),
                       String(format: "%.1f\nmph", result!.ob[1]!.doubleValue! / 0.44704),
                       String(format: "%3.1f°", result!.ob[2]!.doubleValue!)]
        }
        
      } else if (result!.type.stringValue == "obs_st") {
        
        let date = Date(timeIntervalSince1970: result!.obs[0]![0]!.doubleValue!)
        
        DispatchQueue.main.async {
          
          self.observations = [self.dateFormatter.string(from: date),
                               String(format: "%.1f°F", (((result!.obs[0]![7]!.doubleValue!) * 9/5)) + 32.0),
                               String(format: "%.1f%%\nHumidity", result!.obs[0]![8]!.doubleValue!),
                               String(format: "%.1f\nmb", result!.obs[0]![6]!.doubleValue!),
                               String(format: "%.1f\nmph", result!.obs[0]![3]!.doubleValue! / 0.44704)]
        }
        
      }
      
    }

  }

}
