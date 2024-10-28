//
//  StatesView.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

struct StatesView: View {
    @StateObject var viewModel: StatesViewModel
    
    init(viewModel: StatesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading States...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                List(viewModel.states) { state in
                    VStack(alignment: .leading) {
                        Text(state.State)
                            .font(.headline)
                        Text("Population: \(state.Population)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("States - \(viewModel.year)")
        .onAppear {
            Task {
                await viewModel.fetchStates()
            }
        }
    }
}

extension StatesView: Hashable {
    static func == (lhs: StatesView, rhs: StatesView) -> Bool {
        lhs.viewModel.year == rhs.viewModel.year
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(viewModel.year)
    }
}
