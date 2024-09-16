//
//  TodoListView.swift
//  swift_playground
//
//  Created by Henry on 9/13/24.
//

import SwiftUI

/// https://betterprogramming.pub/swiftui-testing-a-pragmatic-approach-aeb832107fe7
struct TodoListView: View {
    @State private var state: ListViewState = .idle
    private let databaseManager: DatabaseManager = .shared

    var body: some View {
        Group {
            switch state {
            case .idle:
                Button("Start") {
                    Task {
                        await refreshTodos()
                    }
                }

            case .loading:
                Text("Loading…")

            case .error:
                VStack {
                    Text("Oops")
                    Button("Try again") {
                        Task {
                            await refreshTodos()
                        }
                    }
                }

            case .loaded(let todos):
                VStack {
                    List(todos) {
                        Text("\($0.title)")
                    }
                }
            }
        }
        .onChange(of: state) {
            guard case .loaded(let todos) = $0 else {
                return
            }

            databaseManager.save(data: todos)
        }
    }

    private func refreshTodos() async {
        state = .loading
        do {
            let todos = try await loadTodos().sorted { $0.title < $1.title }
            state = .loaded(todos)
        } catch {
            state = .error
        }
    }

    private func loadTodos() async throws -> [Todo] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let todos = try JSONDecoder().decode([Todo].self, from: data)
        return todos
    }
}

enum ListViewState: Equatable {
    case idle
    case loading
    case loaded([Todo])
    case error
}

struct Todo: Codable, Identifiable, Equatable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

final class DatabaseManager {
    static let shared: DatabaseManager = .init()
    private init() {}

    func save<T>(data: T) where T: Encodable {
        // TBD
    }
}

#Preview {
    TodoListView()
}
