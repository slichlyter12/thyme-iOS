//
//  NewRecipeView.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/8/22.
//

import SwiftUI

struct NewRecipeView: View {
    
    @Binding var isPresented: Bool
    @State var isShowingErrorAlert: Bool = false
    @State var isShowingAddIngredientView: Bool = false
    @State var isShowingAddStepView: Bool = false
    
    enum Field {
        case name
        case author
        case description
    }
    
    @State var name: String = ""
    @State var author: String = ""
    @State var description: String = ""
    @State var cuisine: Recipe.Cuisine = .dinner
    @State var imageName: String = "burgers"
    @State var ingredients: [Ingredient] = []
    @State var steps: [String] = []
    
    @State var ingredientToEdit: Ingredient = Ingredient(name: "", amount: "")
    @State var stepToEdit: String = ""
    
    struct Ingredient: Hashable, Codable {
        var name: String
        var amount: String
    }
    
    var imageNames = ["savorycarrots", "tjgfbrownies", "burgers"]
    
    @FocusState private var focusField: Field?
    @State var editMode: EditMode = .active
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Recipe Name", text: $name)
                        .focused($focusField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .author
                        }
                    TextField("Author", text: $author)
                        .focused($focusField, equals: .author)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .description
                        }
                    Picker("Cuisine", selection: $cuisine) {
                        ForEach(Recipe.Cuisine.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Image", selection: $imageName) {
                        ForEach(imageNames, id: \.self) {
                            ImageStore.shared.image(name: $0)
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .trailing)
                        }
                    }
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .focused($focusField, equals: .description)
                        .frame(height: 200)
                }
                Section("Ingredients") {
                    List {
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            HStack {
                                Text(ingredients[index].name)
                                Spacer()
                                Text(ingredients[index].amount)
                            }
                            .onTapGesture {
                                ingredientToEdit = ingredients[index]
                                isShowingAddIngredientView = true
                            }
                        }
                        .onDelete { indexes in
                            ingredients.remove(atOffsets: indexes)
                        }
                    }
                    Button("Add Ingredient") {
                        ingredientToEdit = Ingredient(name: "", amount: "")
                        isShowingAddIngredientView = true
                    }
                }
                Section("Steps") {
                    List {
                        ForEach(0..<steps.count, id: \.self) { index in
                            HStack {
                                Text("\(index + 1): ")
                                Text(steps[index])
                            }
                            .onTapGesture {
                                stepToEdit = steps[index]
                                isShowingAddStepView = true
                            }
                        }
                        .onDelete { indexes in
                            steps.remove(atOffsets: indexes)
                        }
                        .onMove { source, destination in
                            steps.move(fromOffsets: source, toOffset: destination)
                        }
                        .environment(\.editMode, $editMode)
                    }
                    Button("Add Step") {
                        stepToEdit = ""
                        isShowingAddStepView = true
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusField = nil
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        focusField = nil
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        focusField = nil
                        var ingredientsMap: [String: String] = [:]
                        ingredients.forEach { ingredient in
                            ingredientsMap[ingredient.name] = ingredient.amount
                        }
                        let newRecipe = Recipe(name: name, author: author, description: description, cuisine: cuisine, imageName: imageName, ingredients: ingredientsMap, steps: steps)
                        print("Saving...")
                        newRecipe.save { success in
                            print("finished saving")
                            if !success {
                                isShowingErrorAlert = true
                            } else {
                                isPresented = false
                            }
                        }
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .alert("Uh oh!", isPresented: $isShowingErrorAlert) {
                        Text("There was an error saving the recipe.")
                        Button("Ok", role: .cancel) {
                            print("dismissing error dialog")
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingAddIngredientView, content: {
                AddIngredientView(isPresented: $isShowingAddIngredientView, ingredient: $ingredientToEdit, allIngredients: $ingredients)
            })
            .sheet(isPresented: $isShowingAddStepView, content: {
                AddStepView(isPresented: $isShowingAddStepView, allSteps: $steps, step: $stepToEdit)
            })
            .navigationTitle("New Recipe")
        }
    }
}

struct AddStepView: View {
    @Binding var isPresented: Bool
    @Binding var allSteps: [String]
    @Binding var step: String
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Step", text: $step)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        allSteps.append(step)
                        isPresented = false
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
            }
            .navigationTitle("Add Step")
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    
    struct NewRecipeView_Preview: View {
        @State var isPresented: Bool = true
        var body: some View {
            NewRecipeView(isPresented: $isPresented)
        }
    }
    
    static var previews: some View {
        NewRecipeView_Preview()
            .previewInterfaceOrientation(.portrait)
    }
}
