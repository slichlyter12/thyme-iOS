//
//  AddIngredientView.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/9/22.
//

import SwiftUI

struct AddIngredientView: View {
    
    @Binding var isPresented: Bool
    @Binding var ingredient: NewRecipeView.Ingredient
    @Binding var allIngredients: [NewRecipeView.Ingredient]
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Ingredient", text: $ingredient.name)
                TextField("Amout", text: $ingredient.amount)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        allIngredients.append(ingredient)
                        isPresented = false
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
            }
            .navigationTitle("Add Ingredient")
        }
        
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    struct AddIngredientViewPreview: View {
        @State var isPresented: Bool = true
        @State var ingredient = NewRecipeView.Ingredient(name: "", amount: "")
        @State var allIngredients = [NewRecipeView.Ingredient(name: "", amount: "")]
        
        var body: some View {
            AddIngredientView(isPresented: $isPresented, ingredient: $ingredient, allIngredients: $allIngredients)
        }
    }
    
    static var previews: some View {
        AddIngredientViewPreview()
    }
}
