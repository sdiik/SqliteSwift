//
//  EditUserView.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 11/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import SwiftUI

struct EditUserView: View {
    
    // id receiving of user from previous view
    @Binding var id: Int64
    
    // variables to store value from input fields
    @State var name: String = ""
    @State var email: String = ""
    @State var age: String = ""
    
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .keyboardType(.default)
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter email", text: $email)
                .padding(10)
                .background(Color(.systemGray6))
                .keyboardType(.emailAddress)
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter Age", text: $age)
                .padding(10)
                .background(Color(.systemGray6))
                .keyboardType(.numberPad)
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            Button(action:  {
                
                DB_Manager().updateUser(idValue: self.id,
                                        nameValue: self.name,
                                        emailValue: self.email,
                                        ageValue: Int64(self.age)!)
                // go to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit User")
            }).frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
        }.padding()
        
        .onAppear(perform: {
            let userModel: UserModel = DB_Manager().getUser(idValue: self.id)
            self.name = userModel.name
            self.email = userModel.email
            self.age = String(userModel.age)
            
        })
    }
}

struct EditUserView_Previews: PreviewProvider {
    
    // when using @Binding, to this in preivew provider
    @State static var id: Int64 = 0
    
    static var previews: some View {
        EditUserView(id: $id)
    }
}
