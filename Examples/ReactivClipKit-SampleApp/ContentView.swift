//
//  ContentView.swift
//  ReactivClipKit-Sample
//
//  Created by Reactiv Technologies Inc. on 2025-04-15.
//

import SwiftUI

/// Main ContentView for ReactivClipKit Sample Application
///
/// This view serves as the main interface for the host application.
/// In a real-world implementation, this would typically contain your application's
/// primary UI components and navigation.
struct ContentView: View {
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .font(.system(size: 48))
            
            Text("ReactivClipKit Sample")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This is the host application for the ReactivClipKit App Clip demo")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding(30)
    }
}

// MARK: - Previews

#Preview {
    ContentView()
}
