//
//  Reachability.swift
//  FashionConnect
//
//  Created by Schnell on 22/11/2017.
//  Copyright © 2017 Sprint Solutions. All rights reserved.
//

import Foundation

var baseURL = "http://sprintsols.com/advancr/api/v1"

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
