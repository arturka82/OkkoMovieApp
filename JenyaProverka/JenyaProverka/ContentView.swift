//
//  ContentView.swift
//  JenyaProverka
//
//  Created by Artur Gedakyan on 11.03.2021.
//

import SwiftUI

struct ContentView: View {
        
    @State var quantity = Int()
    @State var date = Date()
    @State var selection = Int()


    var modal: some View {
        Text("Modal")
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Text("Plain Text")
                    Stepper(value: $quantity, in: 0...10, label: { Text("Quantity") })
                }
                Section {
                    DatePicker(selection: $date, label: { Text("Due Date") })
                    Picker(selection: $selection, label:
                        Text("Picker Name")
                        , content: {
                            Text("Value 1").tag(0)
                            Text("Value 2").tag(1)
                            Text("Value 3").tag(2)
                            Text("Value 4").tag(3)
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
