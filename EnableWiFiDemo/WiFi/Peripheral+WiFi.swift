//
//  Peripheral+Camera.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/21/23.
//

import NetworkExtension
import os.log


extension Peripheral {
    func joinWiFi(with SSID: String, password: String) {
        os_log("Joining WiFi %@...", type: .info, SSID)
        let configuration = NEHotspotConfiguration(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: SSID)
        configuration.joinOnce = false
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            guard let error = error else {
                os_log("Joining WiFi succeeded", type: .info)
                return
            }
            os_log("Joining WiFi failed: %@", type: .error, error as CVarArg)
        }
    }
}
