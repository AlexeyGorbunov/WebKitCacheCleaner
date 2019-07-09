//
//  WebCacheCleaner.swift
// 
//
//  Created by Алексей Горбунов on 09/07/2019.
//  Copyright © 2019 Алексей Горбунов. All rights reserved.
//

import Foundation
import WebKit

final class WebCacheCleaner {
    
    class func clean(domen: [String]? = nil) {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            if let name = domen {
                let arrayDataSite = records.filter { name.contains($0.displayName)}
                deleteData(records: arrayDataSite)
            } else {
                deleteData(records: records)
            }
        }
    }
    
    static private func deleteData(records: [WKWebsiteDataRecord]) {
        records.forEach { record in
            WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            print("[WebCacheCleaner] Record \(record) deleted")
        }
    }
    
}
