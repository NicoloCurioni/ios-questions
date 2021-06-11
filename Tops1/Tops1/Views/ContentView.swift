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
    
    let labels = [
        "en" : "🇺🇸 EN",
        "de" : "🇩🇪 DE",
        "ru" : "🇷🇺 RU"
    ]
    
    @AppStorage("language") var language:String = "en"

    var body: some View {
        VStack(alignment: .trailing) {

            Menu(language) {
                Button("🇺🇸 EN", action: { language = "en" })
                Button("🇩🇪 DE", action: { language = "de" })
                Button("🇷🇺 RU", action: { language = "ru" })
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
