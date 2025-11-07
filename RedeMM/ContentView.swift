//
//  ContentView.swift
//  RedeMM
//
//  Created by rafael dalazen araujo on 07/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showingAddItem = false

    var body: some View {
        NavigationSplitView {
            Group {
                if items.isEmpty {
                    ContentUnavailableView(
                        "No Items",
                        systemImage: "tray",
                        description: Text("Add your first item to get started")
                    )
                } else {
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                ItemDetailView(item: item)
                            } label: {
                                ItemRowView(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(items.isEmpty)
                }
                ToolbarItem {
                    Button(action: {
                        showingAddItem = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView()
            }
        } detail: {
            ContentUnavailableView(
                "Select an item",
                systemImage: "list.bullet.rectangle",
                description: Text("Choose an item from the list to view its details")
            )
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct ItemRowView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title.isEmpty ? "Untitled" : item.title)
                        .font(.headline)
                        .foregroundColor(item.title.isEmpty ? .secondary : .primary)
                    
                    if !item.description.isEmpty {
                        Text(item.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(item.category)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                    
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .omitted))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 2)
    }
}

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                    Text(item.title.isEmpty ? "Untitled" : item.title)
                        .font(.title2)
                        .fontWeight(.medium)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.headline)
                    Text(item.category)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                    Text(item.description.isEmpty ? "No description" : item.description)
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Created")
                        .font(.headline)
                    Text(item.timestamp, format: Date.FormatStyle(date: .complete, time: .standard))
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var category = "General"
    
    let categories = ["General", "Work", "Personal", "Study", "Health", "Finance", "Travel", "Other"]
    
    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Information")) {
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Description", text: $description, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(footer: Text("A title is required to save the item.")) {
                    // Empty section just for the footer
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addItem()
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(
                timestamp: Date(),
                title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                description: description.trimmingCharacters(in: .whitespacesAndNewlines),
                category: category
            )
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
