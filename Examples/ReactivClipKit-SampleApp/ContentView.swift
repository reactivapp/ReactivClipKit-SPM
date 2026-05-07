//
//  ContentView.swift
//  ReactivClipKit-Sample
//
//  Created by Reactiv Technologies Inc.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .font(.system(size: 48))

            Text("Sample Host App")
                .font(.title)
                .fontWeight(.bold)

            Text("This view is shown by the host app. When a Reactiv-owned URL or push notification arrives, ReactivClipHost presents the Reactiv commerce experience as a full-screen cover over this content.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .padding(30)
    }
}

#Preview {
    ContentView()
}
