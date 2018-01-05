/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public protocol LogDelegate: class {

    /**
        Forwards the latest log line.
        This method is called from logging queue, dispatch to main queue if needed.

        - parameter line: latest logged line.
    */
    func didLog(line: Line)

}

/// Handles logging from top level functions
open class Log {
    
    // MARK: Singleton
    
    public static let shared = Log()

    // MARK: Properties
    
    public weak var delegate: LogDelegate?
    public let settings = Settings()

    let queue = DispatchQueue(label: "AELog", attributes: [])
    
    // MARK: API
    
    func log(thread: Thread, path: String, lineNumber: Int, function: String, message: String) {
        queue.async { [unowned self] in
            guard self.settings.isEnabled else {
                return
            }
            let name = self.getFileName(for: path)
            if self.isLogEnabledForFile(with: name) {
                let line = Line(thread: thread, file: name, number: lineNumber, function: function, message: message)
                self.log(line: line)
            }
        }
    }
    
    // MARK: Helpers
    
    private func getFileName(for path: String) -> String {
        guard let
            fileName = NSURL(fileURLWithPath: path).deletingPathExtension?.lastPathComponent
        else { return "Unknown" }
        return fileName
    }
    
    private func isLogEnabledForFile(with fileName: String) -> Bool {
        guard let fileEnabled = settings.files[fileName] else {
            return true
        }
        return fileEnabled
    }

    private func log(line: Line) {
        print(line.description)
        self.delegate?.didLog(line: line)
    }
    
}
