//
//  Root.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import SwiftyJSON

class BaseTestCaseRun : XCTestCaseRun {
    
}

class BaseTestCase : ParametrizedTestCase {
    static let runnerSetup: RunnerSetup = RunnerSetup.sharedInstance
    
    open var stockTestCaseName: StockTestCaseName {
        fatalError("Must be overridden by subclasses.")
    }
    
    open override var testName: String {
        get {
            return self.stockTestCaseName.rawValue
        }
        set {
            fatalError("Must be overridden by subclasses.")
        }
    }
    
    open override var testRunClass: AnyClass? {
        return BaseTestCaseRun.self
    }
    
    override func _allowedTestNames() -> [_SelectedTestCase] {
        var names = [_SelectedTestCase]()
        let casesCfg = RunnerSetup.sharedInstance.runnerConfig.casesConfig
        for item in casesCfg {
            names.append(_SelectedTestCase(name: item.testcaseID))
        }
        return names
    }
    
//    override class func _qck_testMethodSelectors() -> [_QuickSelectorWrapper] {
//        return ["a", "b", "c"].map { parameter in
//            let block: @convention(block) (BaseTestCase) -> Void = { $0.doTest(JSON()) }
//            let implementation = imp_implementationWithBlock(block)
//            let selectorName = "test_\(parameter)"
//            let selector = NSSelectorFromString(selectorName)
//            class_addMethod(self, selector, implementation, "v@:")
//            return _QuickSelectorWrapper(selector: selector)
//        }
//    }
}
