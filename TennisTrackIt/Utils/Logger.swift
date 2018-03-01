//
//  Logger.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation

class Logger {
  
  // MARK: - Public methods
  
  static public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    logMessage(type: .debug, message: message, file: file, function: function, line: line)
  }
  
  static public func info(_ message: String) {
    logMessage(type: .info, message: message)
  }
  
  static public func warn(_ message: String) {
    logMessage(type: .warning, message: message)
  }
  
  static public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    logMessage(type: .error, message: message, file: file, function: function, line: line)
  }
  
  // MARK: - Private methods
  
  static private func logMessage(type: LogType, message: String, file: String = #file, function: String = #function, line: Int = #line) {
    
    let icon = type.icon()
    var message = "[\(icon)] - \(message)"
    
    if type == .error || type == .debug {
      message = """
      /* -------------------
      \(message)
      file: \(file)
      function: \(function)
      line: \(line)
      ------------------- */
      """
    }
    
    print(message)
  }
  
  private enum LogType: String {
    case debug = "🔎"
    case info = "💡"
    case warning = "⚠️"
    case error = "❌"
    
    func icon() -> String {
      return self.rawValue
    }
  }
  
}
