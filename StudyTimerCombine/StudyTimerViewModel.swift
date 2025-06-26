//
//  StudyTimerViewModel.swift
//  StudyTimerCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import Foundation
import Combine

class StudyTimerViewModel: ObservableObject {
    @Published var elapsedTime: Int = 0
    @Published var isRunning: Bool = false
    
    private var timerSubscription: AnyCancellable?
    private var startStopSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // throttleで多重タップを防止（1秒以内の重複タップを無視）
        startStopSubject
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: false)
            .sink { [weak self] in
                self?.toggleTimer()
            }
            .store(in: &cancellables)
    }
    
    func toggleButtonTapped() {
        startStopSubject.send(())
    }
    
    func reset() {
        stopTimer()
        elapsedTime = 0
    }
    
    private func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        
        // Timer.publish で1秒ごとにイベントを発行
        timerSubscription = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.elapsedTime += 1
            }
    }
    
    private func stopTimer() {
        isRunning = false
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}
