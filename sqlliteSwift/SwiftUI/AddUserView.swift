//
//  AddUserView.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 09/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import SwiftUI

struct AddUserView: View {
    //Create variable to store user input values
    @State var name: String = ""
    @State var email: String = ""
    @State var age: String = ""
    
    // to go back on home screen when user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            TextField("Enter email", text: $email)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
            TextField("Enter Age", text: $age )
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            Button(action: {
                DB_Manager().addUser(nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add User")
            })
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
            .padding(.bottom, 10)
        }.padding()
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
