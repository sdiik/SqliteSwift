//
//  SqliteControllerSwiftUI.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 09/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import SwiftUI

struct SqliteControllerSwiftUI: View {
    // array of user models
    @State var userModels: [UserModel] = []
    
    //check if user is selected for edit
    @State var userSelected: Bool = false
    
    //id of selected user to edit or delete
    @State var selectedUserId: Int64 = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: AddUserView(),
                        label: {
                            Text("Add user")
                        })
                }
                
                // navigation list to go to edit user view
                NavigationLink(destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                    EmptyView()
                }
                
                // create list view to show all users
                List(self.userModels) { (model) in
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text("\(model.age)")
                        
                        //Button to edit user
                        Button(action: {
                            self.selectedUserId = model.id
                            self.userSelected = true
                        }, label: {
                            Text("Edit").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            
                            // create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                            
                            // call delete function
                            dbManager.deleteUser(idValue: model.id)
                            
                            // refresh the user models arrays
                            self.userModels = dbManager.getUsers()
                            
                        }, label: {
                            Text("Delete").foregroundColor(.red)
                        })
                        
                        
                    }
                }
            }.padding()
            //load data in user models array
            .onAppear(perform: {
                self.userModels = DB_Manager().getUsers()
            })
            .navigationBarTitle("Users")
        }
    }
}

struct SqliteControllerSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        SqliteControllerSwiftUI()
    }
}
