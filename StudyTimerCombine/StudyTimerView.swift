//
//  StudyTimerView.swift
//  StudyTimerCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import SwiftUI

struct StudyTimerView: View {
    @StateObject private var viewModel = StudyTimerViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("📚 勉強タイマー")
                .font(.title)
            
            Text("\(viewModel.elapsedTime) 秒経過")
                .font(.largeTitle)
            
            Button(action: {
                viewModel.toggleButtonTapped()
            }) {
                Text(viewModel.isRunning ? "⏸ 停止" : "▶️ 開始")
                    .frame(minWidth: 100)
            }
            .buttonStyle(.borderedProminent)
            
            Button("🔁 リセット") {
                viewModel.reset()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
