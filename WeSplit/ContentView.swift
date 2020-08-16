//
//  ContentView.swift
//  WeSplit
//
//  Created by Luciano Sclovsky on 08/08/20.
//  Copyright © 2020 Luciano Sclovsky. All rights reserved.
//

import SwiftUI

func formatCash(cash: Double) -> String {
    return "$" + String(format: "%.2f", cash)
}

struct ResultView: View {
    var description: String
    var cash: Double

    init(description: String, cash: Double) {
        self.description = description
        self.cash = cash
    }

    var body: some View {
        HStack {
            Text(description)
            Spacer()
            Text(formatCash(cash: cash))
        }
    }
}

struct ContentView: View {

    @State private var checkAmout = ""
    @State private var iGuests = 2
    @State private var iPercentages = 2
    
    private let minGuests = 2
    private let maxGuests = 11
    
    let tipsPercentages = [10, 15, 20, 25, 0]
    
    var guestCount: Double {
        return Double(iGuests + minGuests)
    }
    
    var tipPercentage: Double {
        return Double(tipsPercentages[iPercentages])
    }

    var orderAmount: Double {
        return Double(checkAmout) ?? 0
    }
    
    var tipAmout: Double {
        return (tipPercentage / 100) * orderAmount
    }
    
    var totalAmount: Double {
        return orderAmount + tipAmout
    }

    var totalPerGuest: Double {
        return totalAmount / guestCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Check amount")
                        Spacer()
                        TextField("Amount", text: $checkAmout)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }

                    
                    Picker("Guests", selection: $iGuests) {
                        ForEach(minGuests ..< maxGuests) {
                            Text("\($0) guests")
                        }
                    }
                }
            
                Section(header: Text("Tip percentage")) {
                    Picker("Tip Percentage", selection: $iPercentages) {
                        ForEach(0 ..< tipsPercentages.count) {
                            Text("\(self.tipsPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Calculations")) {
                    ResultView(description: "Tip amount", cash: tipAmout).foregroundColor(iPercentages == 4 ? Color.red : Color.black)
                    ResultView(description: "Total amount", cash: totalAmount)
                    ResultView(description: "Total per guest", cash: totalPerGuest)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

