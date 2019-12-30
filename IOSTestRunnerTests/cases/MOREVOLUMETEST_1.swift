//
//  VolumeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/11/28.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class MOREVOLUMETEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MOREVOLUMETEST_1
    }
    
    func testVolume() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MVolumeRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let volumeResponse = resp as! MVolumeResponse
        XCTAssertNotNil(volumeResponse.buyVolumes)
        XCTAssertNotNil(volumeResponse.sellVolumes)
        XCTAssertNotNil(volumeResponse.volumes)
        var resultJSON : JSON = [
            "buyVolumes": volumeResponse.buyVolumes,
            "sellVolumes": volumeResponse.sellVolumes,
            "volumes": volumeResponse.volumes
        ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        
    }
}
