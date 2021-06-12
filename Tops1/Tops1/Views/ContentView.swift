//
//  ContentView.swift
//  Tops1
//
//  Created by Alexander Farber on 03.06.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TopEntity.elo, ascending: false)],
        animation: .default)
    private var topEntities: FetchedResults<TopEntity>
    
    let downloadManager = DownloadManager.instance
    
    @State private var selection = 0
    private let items: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    
    let labels = [
        "en" : "🇺🇸 EN",
        "de" : "🇩🇪 DE",
        "ru" : "🇷🇺 RU"
    ]
    
    @AppStorage("language") var language:String = "en"

    var body: some View {
        VStack(alignment: .trailing) {

            Picker(selection: $selection, label: Text("")) {
                ForEach(0..<items.count, id: \.self) { index in
                    Text(self.items[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Menu(labels[language]!) {
                ForEach(labels.sorted(by: <), id: \.key) { key, value in
                    Button(value, action: { language = key })
                }
            }.padding()
            
            List {
                ForEach(topEntities) { top in
                    TopRow(topEntity: top)
                }
            }
        }.environment(\.locale, .init(identifier: language))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
