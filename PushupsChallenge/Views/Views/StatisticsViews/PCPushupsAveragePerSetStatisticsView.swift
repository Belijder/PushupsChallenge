//
//  PCPushupsAveragePerSetStatisticsView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 22/06/2023.
//

import SwiftUI
import Charts

struct PCPushupsAveragePerSetStatisticsView: View {
    @StateObject var vm = PCPushupsAveragePerSetStatisticsViewViewModel()
    @State private var currentActiveWorkout: PCWorkout?
    @State private var currentLocation: CGPoint?
    @State private var isExpanded = false
    @Namespace private var namespace
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            Text("Push-ups average per set")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            VStack(spacing: 0) {
                topBar
                chart
                    .overlay(
                        VStack {
                            Spacer()
                            filterOptionPicker
                        }
                    )
                
                if isExpanded {
                    Spacer()
                }
            }
            .frame(height: isExpanded ? 280 : 60)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
            .animation(.easeInOut(duration: isExpanded ? 0.4 : 0.3), value: isExpanded)
        }
    }
}

struct PCPushupsAveragePerSetStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .ignoresSafeArea()
            PCPushupsAveragePerSetStatisticsView()
                .padding()
        }
    }
}

extension PCPushupsAveragePerSetStatisticsView {
    private var topBar: some View {
        HStack {
            VStack {
                Text(String(vm.roundedAverage))
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 60)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pcDarkBlue)
                    .shadow(radius: 4, y: 4)
            }
            
            VStack(spacing: 3) {
                Text("30-days change")
                    .font(.system(size: 8, weight: .regular))
                    .foregroundColor(.pcDarkBlue)
                Text(vm.days30change)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(vm.days30change.first == "+" ? .green : vm.days30change.first == "-" ? .red : .pcDarkBlue)
            }
            .frame(width: 80, height: 60)
            
            VStack(spacing: 3) {
                Text("7-days change")
                    .font(.system(size: 8, weight: .regular))
                    .foregroundColor(.pcDarkBlue)
                Text(vm.days7change)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(vm.days7change.first == "+" ? .green : vm.days7change.first == "-" ? .red : .pcDarkBlue)
            }
            .frame(width: 80, height: 60)
            
            Spacer()

            Image(systemName: "chevron.down")
                .foregroundColor(.pcDarkBlue)
                .frame(width: 80, height: 60)
                .rotation3DEffect(isExpanded ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x: 0, y: 0, z: 1))
        }
        .background {
            Color.white.opacity(0.01)
                .cornerRadius(8)
        }
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    
    private var chart: some View {
        GeometryReader { geometry in
            Chart {
                RuleMark(y: .value("Averange", vm.pushUpsAverange))
                    .foregroundStyle(Color.pcDarkViolet.opacity(0.3))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                ForEach(vm.filteredWorkouts) { workout in
                    
                    if vm.currentFilterOption == .all {
                        LineMark(
                            x: .value("Date", workout.date, unit: .day),
                            y: .value("Reps", workout.reps.reduce(0, +) / workout.reps.count)
                        )
                        .foregroundStyle(Color.pcDarkViolet.gradient)
                        .interpolationMethod(.cardinal)
                        
                        AreaMark(
                            x: .value("Date", workout.date, unit: .day),
                            y: .value("Reps", workout.reps.reduce(0, +) / workout.reps.count)
                        )
                        .foregroundStyle(LinearGradient(colors: [Color.pcDarkViolet, .clear], startPoint: .top, endPoint: .bottom).opacity(0.5))
                        .interpolationMethod(.cardinal)
                    } else {
                        BarMark(
                            x: .value("Date", workout.date, unit: .day),
                            y: .value("Reps", workout.reps.reduce(0, +) / workout.reps.count)
                        )
                        .foregroundStyle(Color.pcDarkViolet.gradient)
                        
                    }
                    
                    if let currentActiveWorkout, currentActiveWorkout.id == workout.id, let currentLocation {
                        RuleMark(x: .value("Date", currentActiveWorkout.date, unit: .day))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                            .foregroundStyle(Color.pcLightRed)
                            .annotation(position: vm.calculateAnnotationPosition(annotationWidth: 70,
                                                                                 xPosition: currentLocation.x,
                                                                                 chartWidth: geometry.size.width)) {
                                VStack(spacing: -5) {
                                    Text(currentActiveWorkout.shortStringDate)
                                        .font(.system(.caption))
                                        .foregroundColor(.pcDarkBlue.opacity(0.5))
                                        .fontWeight(.light)
                                    Text(String(currentActiveWorkout.reps.reduce(0, +) / currentActiveWorkout.reps.count))
                                        .font(.system(.title))
                                        .foregroundColor(.pcDarkBlue)
                                        .fontWeight(.black)
                                }
                                .frame(width: 70)
                                .padding(6)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(radius: 2, y: 2)
                                }
                                .offset(x: vm.calculateAnnotationOffset(annotationWidth: 70, xPosition: currentLocation.x, chartWidth: geometry.size.width))
                            }
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks() {
                    AxisValueLabel()
                        .foregroundStyle(Color.pcDarkBlue)
                    AxisGridLine()
                        .foregroundStyle(Color.pcDarkBlue.opacity(0.4))
                        
                }
            }
            .chartYScale(domain: 0...(vm.filteredWorkouts.map { $0.totalReps / 4 }.max() ?? 15) + 4)
            .padding()
            .opacity(isExpanded ? 1 : 0)
            .frame(height: isExpanded ? 180 : 0)
            .chartOverlay(content: { proxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                let location = value.location
                                self.currentLocation = location
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    if let roundedDate = calendar.date(from: calendar.dateComponents([.day, .month, .year], from: date)) {
                                        if let currentWorkout = vm.workouts.first(where: { workout in
                                            let workoutRoundedDate = calendar.date(from: calendar.dateComponents([.day, .month, .year], from: workout.date))
                                            return workoutRoundedDate == roundedDate
                                        }) {
                                            self.currentActiveWorkout = currentWorkout
                                        }
                                    }
                                }
                            }
                            .onEnded{ value in
                                self.currentActiveWorkout = nil
                            }
                    )
            })
        .animation(.easeInOut(duration: isExpanded ? 0.4 : 0.2), value: isExpanded)
        }
    }
    
    
    private var filterOptionPicker: some View {
        HStack {
            ForEach(PCTimeScaleString.allCases, id: \.rawValue) { option in
                ZStack {
                    if vm.currentFilterOption == option {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pcDarkBlue)
                            .matchedGeometryEffect(id: "optionBackground", in: namespace)
                    }
                    Text(option.rawValue)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(width: 80, height: 22)
                .onTapGesture {
                    withAnimation(.spring()) {
                        vm.currentFilterOption = option
                    }
                }
            }
        }
        .background(content: {
            Color.pcDarkBlue.opacity(0.3)
                .cornerRadius(10)
        })
        .padding(.horizontal)
        .opacity(isExpanded ? 1 : 0)
        .offset(CGSize(width: 0, height: isExpanded ? -5 : 0))
        .animation(.easeInOut(duration: isExpanded ? 0.4 : 0.2), value: isExpanded)
    }
}
