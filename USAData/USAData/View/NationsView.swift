//
//  NationsView.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

struct NationsView: View {
    @StateObject private var viewModel: NationsViewModel
        
    init(viewModel: NationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.nations) { nation in
            Button(action: {
                viewModel.selectNation(nation: nation)
            }) {
                VStack(alignment: .leading) {
                    Text(nation.Year)
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Text("Population: \(nation.Population)")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationTitle("USA Population")
        .onAppear {
            Task {
                await viewModel.fetchNations()
            }
        }
    }
}
