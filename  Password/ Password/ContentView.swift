//  /*
//
//  Project: Password
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 24.04.0223
//
//  */

import SwiftUI

struct Login: View {
    @EnvironmentObject var observable: Observable
    
    @State private var showUnderlinePhone = false
    @State private var showUnderlinePass = false
    @State private var percentagePhone: CGFloat = 0
    @State private var percentagePass: CGFloat = 0
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Добро пожаловать в Gwork!")
                            //.font(.custom(FontsManager.Inter.regular, size: 30))
                            .fontWeight(.semibold)
                        //.font(.system(size: 30, weight: .semibold))
                        
                        Text("Заполните поля для поиска работы или размещения заказов")
                            //.font(.custom(FontsManager.Inter.regular, size: 16))
                        //.font(.system(size: 16))
                            .padding(.bottom, 20)
                    }
                    Spacer()
                    
                }
                
                VStack(spacing: 0) {
                    HStack {
                        TextField("Номер телефона или почта", text: $observable.loginPhone, onEditingChanged: { focused in
                            if focused {
                                withAnimation {
                                    showUnderlinePhone = true
                                }
                            } else {
                                withAnimation {
                                    showUnderlinePhone = false
                                }
                            }
                        })
                    }
                    //.font(.custom(FontsManager.Inter.regular, size: 16))
                    .padding()
                    .background(
                        Color.white
                    )
                    .cornerRadius(6)
                    
                    Underline(fieldIsActive: "phone")
                }
                
                
                VStack(spacing: 0) {
                    HStack {
                        SecureField("Введите пароль", text: $observable.loginPass)
                            //.font(.custom(FontsManager.Inter.regular, size: 16))
                    }
                    .padding()
                    .background(
                        Color.white
                    )
                    .cornerRadius(6)
                    
                    Underline(fieldIsActive: "")
                }
                .padding(.bottom, 30)
                
                
                
                VStack(alignment: .center, spacing: 30) {
                    Button {
                        observable.is_validate = true
                    } label: {
                        Text("Войти")
                    }
                    .frame(width: 96, height: 40)
                    .foregroundColor(observable.loginPhone != "" && observable.loginPass != "" ? .white : Color.red)
                    .background(
                        observable.loginPhone != "" && observable.loginPass != "" ? Color.blue :  Color.red
                    )
                    .cornerRadius(6)
                    
                    Button {
                        
                    } label: {
                        Text("Восстановить пароль")
                            //.font(.custom(FontsManager.Inter.regular, size: 16))

                    }
                    .foregroundColor(Color.blue)
                    
                    Button {
                        
                    } label: {
                        Text("Зарегистрироваться")
                            //.font(.custom(FontsManager.Inter.regular, size: 16))
                    }
                    .foregroundColor(Color.blue)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(Observable())
    }
}

extension Login {
    
    func Underline(fieldIsActive: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: (screen.width - 32) * (fieldIsActive == "phone" ? percentagePhone : percentagePass), height: 2)
            //.foregroundColor(Color.init(toElement: .main))
            .onChange(of: fieldIsActive == "phone" ? showUnderlinePhone : showUnderlinePass, perform: { newValue in
                if newValue {
                    withAnimation(.linear(duration: 0.5)) {
                        if fieldIsActive == "phone" {
                            percentagePhone = 1.0
                        } else {
                            percentagePass = 1.0
                        }
                    }
                } else {
                    withAnimation(.linear(duration: 0.5)) {
                        if fieldIsActive == "phone" {
                            percentagePhone = 0.0
                        } else {
                            percentagePass = 0.0
                        }
                    }
                }
            })
    }
    
}
