//
//  Helper.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import os.log

class Utils {
    static func log(tag: String, str: String) {
        os_log("<%{public}@> %{public}@", log: OSLog.default, type: OSLogType.error, tag, str)
    }
}
