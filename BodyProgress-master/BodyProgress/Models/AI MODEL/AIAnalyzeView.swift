
//  AIAnalyzeView.swift
//  BodyProgress
import SwiftUI
import WebKit

// WebView component to load the AI Analyze URL
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

// View to display the instructions pop-up with a more polished design
struct InstructionsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("How to Use AI Analyze Feature")
                .font(.system(size: 24, weight: .semibold))
                .padding(.top, 10)

            VStack(spacing: 15) {
                InstructionStepView(stepNumber: 1, instruction: "Ensure your device is connected to the internet.")
                InstructionStepView(stepNumber: 2, instruction: "Upload a video of yourself performing a workout.")
                InstructionStepView(stepNumber: 3, instruction: "Review feedback provided by AI.")
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)

            Button(action: {
                // Action to dismiss the view
                NotificationCenter.default.post(name: .dismissInstructions, object: nil)
            }) {
                Text("Got it!")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.85))
                    .cornerRadius(10)
                    .shadow(color: Color.green.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

// Helper view for each instruction step
struct InstructionStepView: View {
    let stepNumber: Int
    let instruction: String

    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 40, height: 40)
                Text("\(stepNumber)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.blue)
            }
            Text(instruction)
                .font(.system(size: 16, weight: .medium))
                .multilineTextAlignment(.leading)
        }
    }
}

// Main view to display AI Analyze with the instructions pop-up on first load
struct AIAnalyzeView: View {
    @State private var showInstructions = true

    var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: "http://127.0.0.1:5000")!)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarTitle("AI Analyze", displayMode: .inline)
            .onAppear {
                // Show the instructions the first time the view is opened
                showInstructions = true
            }
            .sheet(isPresented: $showInstructions) {
                InstructionsView()
            }
            .onReceive(NotificationCenter.default.publisher(for: .dismissInstructions)) { _ in
                showInstructions = false
            }
        }
    }
}

extension Notification.Name {
    static let dismissInstructions = Notification.Name("dismissInstructions")
}

struct AIAnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AIAnalyzeView()
    }
}
