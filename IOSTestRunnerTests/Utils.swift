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
    private static let LOG_LINE_LIMIT = 900
    
    static func log(tag: String, str: String) {
        os_log("<%{public}@> %{public}@", log: Log.normal, type: OSLogType.default, tag, str)
    }
    static func record(recordID: String, data: Data) {
        if let recordStr = String(data: data, encoding: String.Encoding.utf8) as String! {
            if recordStr.count < LOG_LINE_LIMIT {
                os_log("%{public}@", log: Log.record, type: OSLogType.default, recordStr)
                return
            }
            let dataLen = recordStr.count
            var chunkOffset = 0
            var logChunkIdx: Int = dataLen / LOG_LINE_LIMIT
            repeat {
                let chunkTag = "Chunk.\(recordID).\(logChunkIdx):"
                let startRangeIdx = recordStr.index(recordStr.startIndex, offsetBy: chunkOffset)
                var endRangeIdx = recordStr.index(startRangeIdx, offsetBy: LOG_LINE_LIMIT, limitedBy: recordStr.endIndex)
                if endRangeIdx == nil {
                    endRangeIdx = recordStr.endIndex
                }
                os_log("%{public}@", log: Log.record, type: OSLogType.default, chunkTag + recordStr[startRangeIdx ..< endRangeIdx!])
                chunkOffset += LOG_LINE_LIMIT;
                logChunkIdx -= 1;
            } while chunkOffset < dataLen
        }
    }
}
