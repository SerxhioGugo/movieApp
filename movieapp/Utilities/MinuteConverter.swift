//
//  MinuteConverter.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/5/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
