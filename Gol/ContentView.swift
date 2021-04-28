//
//  ContentView.swift
//  Gol
//
//  Created by Raphael Cerqueira on 27/04/21.
//

import SwiftUI

struct ContentView: View {
    @State var showDetailsView: Bool = false
    @Namespace private var animation
    @State var detailsTitle: String = ""
    
    var body: some View {
        ZStack {
            if !showDetailsView {
                HomeView(showDetailsView: $showDetailsView, animation: animation, detailsTitle: $detailsTitle)
            }
            
            if showDetailsView {
                DetailsView(showDetailsView: $showDetailsView, animation: animation, detailsTitle: $detailsTitle)
            }
        }
    }
}

struct HomeView: View {
    @Binding var showDetailsView: Bool
    var animation: Namespace.ID
    
    let screen = UIScreen.main.bounds
    
    let options = ["Minhas viagens", "Check-in", "Comprar viagem", "Minha conta", "Status de voo"]
    
    let moreOptions = ["Voe Junto", "Ajuda", "Sair"]
    
    @Binding var detailsTitle: String
    
    @State var moreOptionsVisible: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9924781919, green: 0.3595064878, blue: 0.00949444063, alpha: 1)), Color(#colorLiteral(red: 0.9723210931, green: 0.5567080975, blue: 0.06823665649, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                .matchedGeometryEffect(id: "background", in: animation)
                .frame(width: calculateRadius(), height: calculateRadius())
            
            VStack(alignment: .leading) {
                Text("Olá, Raphael")
                    .padding(20)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("Você ainda não tem nenhuma viagem marcada")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                
                HStack {
                    Button(action: {
                        showView("Comprar viagem")
                    }, label: {
                        Text("Comprar")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(#colorLiteral(red: 0.9924781919, green: 0.3595064878, blue: 0.00949444063, alpha: 1)))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(Capsule().fill(Color.white))
                    })
                    
                    Button(action: {
                        showView("Localizar viagem")
                    }, label: {
                        Text("Adicionar viagem")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(Capsule().strokeBorder(Color.white, lineWidth: 3))
                    })
                }
                .padding(20)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                showView(option)
                            }, label: {
                                Text(option)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                            })
                        }
                        
                        if moreOptionsVisible {
                            VStack(alignment: .leading) {
                                ForEach(moreOptions, id: \.self) { option in
                                    Button(action: {
                                        showView(option)
                                    }, label: {
                                        Text(option)
                                            .font(.title)
                                            .foregroundColor(Color.white.opacity(0.7))
                                            .padding(.bottom)
                                    })
                                }
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                moreOptionsVisible.toggle()
                            }
                        }, label: {
                            HStack {
                                Text(moreOptionsVisible ? "Ocultar" : "Mais opções")
                                    .font(.title)
                                    .foregroundColor(Color.white.opacity(0.7))
                                
                                Image(systemName: moreOptionsVisible ? "chevron.up" : "chevron.down")
                            }
                        })
                    }
                    
                    Spacer()
                }
                .padding(20)
                .padding(.bottom, 40)
            }
            .foregroundColor(.white)
            .frame(width: screen.width, height: screen.height)
        }
    }
    
    func showView(_ title: String) {
        detailsTitle = title
        withAnimation {
            showDetailsView.toggle()
        }
    }
    
    func calculateRadius() -> CGFloat {
        let halfWidth = screen.width / 2
        let halfHeight = screen.height / 2
        let radius = (halfWidth * halfWidth) + (halfHeight * halfHeight)
        return sqrt(radius) * 2
    }
}

struct DetailsView: View {
    @Binding var showDetailsView: Bool
    var animation: Namespace.ID
    @Binding var detailsTitle: String
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(detailsTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
        
                    Button(action: {
                        withAnimation {
                            showDetailsView.toggle()
                        }
                    }, label: {
                        Circle()
                            .matchedGeometryEffect(id: "background", in: animation)
                            .foregroundColor(Color(#colorLiteral(red: 0.9924781919, green: 0.3595064878, blue: 0.00949444063, alpha: 1)))
                            .frame(width: 60, height: 60)
                    })
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
