

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()
    var title: String {
        switch fastingManager.fastingState{
            
        case .notStarted:
            return "Let's get strated!"
        case .Fasting:
            return "You are fasting"
        case .feeding:
            return "You are feeding"
        }
    }
    var body: some View {
        ZStack{
            // Background
            Color(#colorLiteral(red: 0.0558129102, green: 0.005435050931, blue: 0.09321708232, alpha: 1))
                .ignoresSafeArea()
            
            
            content
            
            
        }
    }
    var content: some View {
        ZStack {
            VStack(spacing: 40){
                // Title
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.blue)
                
                // Fasting Plan
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal,24)
                    .padding(.vertical,8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
            }

            .padding()


            VStack(spacing:40) {
               // progress Ring
                ProgressRing()
                    .environmentObject(fastingManager)
                HStack(spacing:60){
                    // Start Time
                    VStack(spacing: 5){
                        
                        Text(fastingManager.fastingState == .notStarted  ? "Start" : "Started")
                            .opacity(0.7)
                        
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                        


                    }
                    // End Time
                    VStack(spacing: 5){
                        
                        Text(fastingManager.fastingState == .notStarted  ? "End" : "Ends")
                            .opacity(0.7)
                        
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    
                    }
                   
                }
                // Button
                Button {
                    fastingManager.toggleFastingState()
                    
                } label: {
                    Text(fastingManager.fastingState == .Fasting ? "End fast" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal,24)
                        .padding(.vertical,8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                    
                }
            }
            .padding()
           
        }
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
        
}
