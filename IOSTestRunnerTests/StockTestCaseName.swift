//
//  StockTestcaseName.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/25.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

#if !swift(>=4.2)
    public protocol CaseIterable {
        associatedtype AllCases: Collection where AllCases.Element == Self
        static var allCases: AllCases { get }
    }
    extension CaseIterable where Self: Hashable {
        static var allCases: [Self] {
            return [Self](AnySequence { () -> AnyIterator<Self> in
                var raw = 0
                var first: Self?
                return AnyIterator {
                    let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                    if raw == 0 {
                        first = current
                    } else if current == first {
                        return nil
                    }
                    raw += 1
                    return current
                }
            })
        }
    }
#endif

enum StockTestCaseName: String, CaseIterable {
    case QUOTE_REQUEST_EXAMPLE = "TESTCASE_0"
    case QUOTE_REQUEST_EXAMPLE2 = "TESTCASE_1"
    
    static func fromString(_ str: String) -> StockTestCaseName? {
        return self.allCases.first{ "\($0)" == str }
    }
}
