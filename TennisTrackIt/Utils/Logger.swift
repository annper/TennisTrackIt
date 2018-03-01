//
//  Logger.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation

class Logger {
  
  // MARK - Shared instance
  
  static let shared = Logger()
  
  // MARK: - Public methods
  
  public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    logMessage(type: .debug, message: message, file: file, function: function, line: line)
  }
  
  public func info(_ message: String) {
    logMessage(type: .info, message: message)
  }
  
  public func warn(_ message: String) {
    logMessage(type: .warning, message: message)
  }
  
  public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    logMessage(type: .error, message: message, file: file, function: function, line: line)
  }
  
  // MARK: - Private methods
  
  private func logMessage(type: LogType, message: String, file: String = #file, function: String = #function, line: Int = #line) {
    
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
