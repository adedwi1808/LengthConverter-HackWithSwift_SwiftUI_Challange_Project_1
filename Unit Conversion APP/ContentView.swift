//
//  ContentView.swift
//  Unit Conversion APP
//
//  Created by Ade Dwi Prayitno on 07/04/22.
//

import SwiftUI

enum Units: String, CaseIterable {
    case m = "Meters"
    case km = "Kilometers"
    case ft = "Feet"
    case yard = "yards"
    case mi = "Miles"
    
    //Convert Meters to Target Unit
    var metersToTarget: Double {
        switch self {
        case .m:
            return 1
        case .km:
            return 0.001
        case .ft:
            return 3.28084
        case .yard:
            return 1.0936133333333
        case .mi:
            return 0.00062137121212119323429
        }
    }
    
    //Convert From Input Unit To Meters
    var normalisasi: Double {
        switch self {
        case .m:
            return 1
        case .km:
            return 1000
        case .ft:
            return 0.30480000975359072823
        case .yard:
            return 0.91440002926077212919
        case .mi:
            return 0.91440002926077212919
        }
    }
}


struct ContentView: View {
    @State private var inputvalue = 0.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    @FocusState private var inputIsFocused: Bool
    
    
    func OutputLength(from input: Double, with inputUnit: Units, to outputUnit: Units) -> Double {
        return (input * inputUnit.normalisasi) * outputUnit.metersToTarget
    }
        
        var body: some View {
            NavigationView{
                Form{
                    Section{
                        TextField("Input",value: $inputvalue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                        
                        Picker("Input Unit", selection: $inputUnit){
                            ForEach(Units.allCases, id: \.rawValue){
                                Text($0.rawValue)
                            }
                        }
                        Picker("Output Unit", selection: $outputUnit){
                            ForEach(Units.allCases, id: \.rawValue){
                                Text($0.rawValue)
                            }
                        }
                    }header: {
                        Text("Input Length")
                    }
                    
                    
                    Section{
                        Text(OutputLength(from: inputvalue, with: Units(rawValue: inputUnit) ?? .m, to: Units(rawValue: outputUnit) ?? .m), format: .number)
                        
                    }header:{
                        Text("Answer")
                    }
                    
                }
                .navigationTitle("Length Converter")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
