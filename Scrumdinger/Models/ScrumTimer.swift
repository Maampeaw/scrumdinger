//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 24/07/2025.
//

import SwiftUI

@Observable class ScrumTimer {
    
    public struct Speaker: Identifiable {
        var name: String
        var isCompleted: Bool
        let id: UUID = UUID()
        
        init(name: String, isCompleted: Bool) {
            self.name = name
            self.isCompleted = isCompleted
        }
        
    }
    
    public var activeSpeaker: String = "";
    public var secondsElapsed = 0;
    public var secondsRemaining = 0;
    private var _speakers: [Speaker] = [];
    
    var speakers: [Speaker] {
        _speakers
    }
    
    var speakerChangedAction: (()->Void)?
    
    private var lengthInMinutes: Int
    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
           (lengthInMinutes * 60) / _speakers.count
       }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
           return "Speaker \(speakerIndex + 1): " + _speakers[speakerIndex].name
       }
    private var startDate: Date?
    
    public init(lengthInMinutes: Int = 0, attendeeNames: [String] = []) {
           print(lengthInMinutes)
           self.lengthInMinutes = lengthInMinutes
           self._speakers = Self.generateSpeakersList(with: attendeeNames)
           secondsRemaining = lengthInSeconds
           activeSpeaker = speakerText
       }
    
    //Start the timer
    public func startScrum() {
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
                self?.update()
            }
            timer?.tolerance = 0.1
            changeToSpeaker(at: 0)
        }
       
    /// Stop the timer.
        public func stopScrum() {
            timer?.invalidate()
            timerStopped = true
        }
        
    /// Advance the timer to the next speaker.
       nonisolated public func skipSpeaker() {
           Task { @MainActor in
               changeToSpeaker(at: speakerIndex + 1)
           }
       }
    
    public func reset(lengthInMinutes: Int, attendeeNames: [String]) {
          self.lengthInMinutes = lengthInMinutes
          self._speakers = Self.generateSpeakersList(with: attendeeNames)
          secondsRemaining = lengthInSeconds
          activeSpeaker = speakerText
      }


      private func changeToSpeaker(at index: Int) {
          if index > 0 {
              let previousSpeakerIndex = index - 1
              _speakers[previousSpeakerIndex].isCompleted = true
          }
          secondsElapsedForSpeaker = 0
          guard index < _speakers.count else { return }
          speakerIndex = index
          activeSpeaker = speakerText


          secondsElapsed = index * secondsPerSpeaker
          secondsRemaining = lengthInSeconds - secondsElapsed
          startDate = Date()
      }


      nonisolated private func update() {

          Task { @MainActor in
              guard let startDate,
                    !timerStopped else { return }
              let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
              secondsElapsedForSpeaker = secondsElapsed
              self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
              guard secondsElapsed <= secondsPerSpeaker else {
                  return
              }
              secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)


              if secondsElapsedForSpeaker >= secondsPerSpeaker {
                  changeToSpeaker(at: speakerIndex + 1)
                  speakerChangedAction?()
              }
          }
      }


      /**
       Generates a speaker list from a list of names.

       - Parameters:
          - names: An array of `String`s representing people's names

       - Returns: An array of `Speaker`s, or a single generic `Speaker` if the `names` parameter is empty
       */
      private static func generateSpeakersList(with names: [String]) -> [Speaker] {
          guard !names.isEmpty else { return [Speaker(name: "Speaker 1", isCompleted: false)] }
          return names.map { Speaker(name: $0, isCompleted: false) }
      }

    
    
}
