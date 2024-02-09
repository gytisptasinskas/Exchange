//
//  String.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

extension Image {
    init?(base64Str: String) {
        guard let data = Data(base64Encoded: base64Str) else { return nil }
        guard let uiImg = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImg)
    }
}
