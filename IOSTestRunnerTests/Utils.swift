//
//  Helper.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import os.log

struct Log {
    static var normal = OSLog(subsystem: "com.chi.ssetest", category: "log")
    static var record = OSLog(subsystem: "com.chi.ssetest", category: "record")
}

class Utils {
    static func log(tag: String, str: String) {
        os_log("<%{public}@> %{public}@", log: Log.normal, type: OSLogType.default, tag, str)
    }
    static func record(data: Data) {
        os_log("%{public}@", log: Log.record, type: OSLogType.default, String(data: data, encoding: String.Encoding.utf8) as String!)
    }
}
