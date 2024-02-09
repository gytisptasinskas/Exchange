//
//  Country.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import Foundation

struct Currency: Codable, Hashable {
    let code: String
    let name: String
    let country: String
    let countryCode: String
    let flag: String?
}



