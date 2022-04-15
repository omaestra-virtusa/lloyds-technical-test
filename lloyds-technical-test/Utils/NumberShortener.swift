//
//  NumberShortener.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

struct NumberShortener {
    func shorten(from value: String) -> String? {
        let formatter = NumberFormatter()
        guard let value = formatter.number(from: value)?.intValue else { return nil }

        if value < 1000 {
            return "\(value)"
        }
        if value < 100_000 {
            return string(from: value, divisor: 1000, suffix: "K")
        }
        if value < 100_000_000 {
            return string(from: value, divisor: 1_000_000, suffix: "M")
        }

        return string(from: value, divisor: 1_000_000_000, suffix: "B")
    }

    private func string(from value: Int, divisor: Double, suffix: String) -> String? {
        let formatter = NumberFormatter()
        let dividedValue = Double(value) / divisor

        formatter.positiveSuffix = suffix
        formatter.negativeSuffix = suffix
        formatter.allowsFloats = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        return formatter.string(from: NSNumber(value: dividedValue))
    }
}
