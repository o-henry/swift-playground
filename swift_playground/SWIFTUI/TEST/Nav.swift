//
//  Nav.swift
//  swift_playground
//
//  Created by Henry on 9/13/24.
//

import Foundation
import SwiftUI

struct Nav: View {
    @State private var navToTarget = false
    @State private var enabled = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    Text("첫 화면 1")

                    Button { enabled = true } label: { Text("체크버튼 ") }
                }
                ReusableButton(enabled: enabled) {
                    navToTarget = true
                }
            }
            .navigationDestination(isPresented: $navToTarget) {
                Target()
            }
        }
    }
}

/// 네비게이션 도착 뷰
struct Target: View {
    var body: some View {
        VStack {
            Text("WELCOME TARGET VIEW")
        }
    }
}

struct ReusableButton: View {
    var enabled: Bool
    var action: () -> Void // call-back

    var body: some View {
        Button(action: action) {
            Text("시작하기")
        }
        .disabled(!enabled) // disable이 true면 사용불가
        .accessibilityIdentifier("Start Button")
    }
}
