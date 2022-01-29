import Foundation
import Network

class AppModel: NSObject, ObservableObject {
  
  @Published var message: String = ""
  
  @Published var hubSn: String = ""
  @Published var hubFirmware: String = ""
  @Published var hubUptime: String = ""
  @Published var hubTimestamp: String = ""
  
  @Published var rapidWindTimestamp: String = ""
  @Published var rapidWindSpeed: String = ""
  @Published var rapidWindDirection: String = ""
  
  @Published var obsTimestamp: String = ""
  @Published var obsTemp: String = ""
  @Published var obsHumid: String = ""
  @Published var obsPressure: String = ""
  @Published var obsGust: String = ""

  var conn: NWConnection?
  var listener: NWListener?
  
  let dateFormatter = DateFormatter()
  
  override init() {
    
    super.init()
    
    dateFormatter.timeZone = TimeZone(abbreviation: "EST5EDT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Specify your format that you want
    
    startReceiver()
    
  }
  
  func startReceiver() {
    
    do {
      
      let params: NWParameters = .udp
      params.allowLocalEndpointReuse = true
      params.includePeerToPeer = true
      
      listener = try NWListener(using: params, on: 50222)
      
      listener?.stateUpdateHandler = { update in }
      
      self.listener?.newConnectionHandler = { conn in
        
        conn.stateUpdateHandler = { state in
          
          switch state {
          case .ready:
            
            conn.receiveMessage { (data, context, isComplete, error) in
              
              let d = data!
              
              // closing the connection this close to the beginning of receive processing
              // still isn't fast enough but only a tiny fraction of UDP messages are missed
              conn.cancel()

              let result = try? JSONDecoder().decode(JSON.self, from: d)
              
              if (result != nil) {
                
                DispatchQueue.main.async {
                  
                  if (result!.type.stringValue == "hub_status") {
                    
                    let date = Date(timeIntervalSince1970: result!.timestamp.doubleValue!)

                    self.hubSn = result!.serial_number.stringValue!
                    self.hubFirmware = result!.firmware_revision.stringValue!
                    self.hubUptime = String(result!.uptime.intValue!)
                    self.hubTimestamp = self.dateFormatter.string(from: date)
                    
                  } else if (result!.type.stringValue == "rapid_wind") {
                    
                    let date = Date(timeIntervalSince1970: result!.ob[0]!.doubleValue!)

                    self.rapidWindTimestamp = self.dateFormatter.string(from: date)
                    self.rapidWindSpeed = String(format: "%4.1f", result!.ob[1]!.doubleValue! / 0.44704)
                    self.rapidWindDirection = String(result!.ob[2]!.intValue!)
                    
                  } else if (result!.type.stringValue == "obs_st") {
                    
                    let date = Date(timeIntervalSince1970: result!.obs[0]![0]!.doubleValue!)

                    self.obsTimestamp = self.dateFormatter.string(from: date)
                    self.obsTemp = String(format: "%3.1f", (((result!.obs[0]![7]!.doubleValue!) * 9/5)) + 32.0)
                    self.obsHumid = String(format: "%3.1f", result!.obs[0]![8]!.doubleValue!)
                    self.obsPressure = String(format: "%4.1f", result!.obs[0]![6]!.doubleValue!)
                    self.obsGust = String(format: "%4.1f", result!.obs[0]![3]!.doubleValue! / 0.44704)
                    
                  }
                  
                }
                
              }
                            
            }
            
          default: break
            
          }
          
        }
        
        conn.start(queue: DispatchQueue(label: "is.rud.weatherflow.found"))
        
      }
    
        
    } catch {
      
      
    }
    
    listener?.start(queue: .main)
    
  }
    
}

