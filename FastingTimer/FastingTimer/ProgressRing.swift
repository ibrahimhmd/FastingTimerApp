

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
     let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()


    var body: some View {
        ZStack{
            // Placeholder Ring
            
        Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // Colored Ring
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(.blue),Color(.purple),Color(.systemPink),Color(.cyan),Color(.blue)]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin:.round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0),value: fastingManager.progress)
            
            VStack(spacing: 30){
                if fastingManager.fastingState == .notStarted{
                    // Upcoming Fast
                    VStack(spacing: 5){
                        Text("Upcoming  fast")
                            .opacity(0.7)
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                      
                    }
                    
                }else {
                    // Elapsed Time
                    VStack(spacing: 5){
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        Text(fastingManager.startTime,style: .timer)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                      
                    }
                    .padding(.top)
                 
                    // Remaining Time
                    VStack(spacing: 5){
                        
                        if !fastingManager.elapsed {
                            Text("Remaining time (\((1-fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                            
                        }
                        
                        
                        
                       
                        Text(fastingManager.endTime,style: .timer)
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                      
                    }
                    
                }
                
                
                
               
                
            }
          
            
            
            
        }
        .frame(width: 250, height: 250)
        .padding()
      
        .onReceive(timer){ _ in
            fastingManager.track()
        }
    }
}

#Preview {
    ProgressRing()
        .environmentObject(FastingManager())
}
