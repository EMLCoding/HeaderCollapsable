//
//  Home.swift
//  HeaderCollapsable
//
//  Created by Eduardo Martin Lorenzo on 16/6/22.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0 // Permite controlar lo que se arrastra un elemento con el dedo en la pantalla
    
    let maxHeight = UIScreen.main.bounds.height / 2.3
    var topEdge: CGFloat // Es la altura de la area segura superior
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy in
                    TopBar(offset: $offset, topEdge: topEdge, maxHeight: maxHeight )
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(), alignment: .bottom) // Efecto de sticky. Se "estirará hacia abajo" cuando se arrastre con el dedo
                    .background(.purple, in: CustomCorner(corners: [.bottomRight, .bottomLeft], radius: getCornerRadius()))
                    .overlay(
                        HStack(spacing: 15) {
                            Button {
                                
                            } label: {
                                 Image(systemName: "xmark")
                                    .font(.body.bold())
                            }
                            
                            Image("profile")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .opacity(topBarTitleOpacity())
                            
                            Text("Stitch")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .opacity(topBarTitleOpacity())
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                 Image(systemName: "line.3.horizontal.decrease")
                                    .font(.body.bold())
                            }
                        }
                            .padding(.horizontal)
                            .frame(height: 80)
                            .foregroundColor(.white)
                            .padding(.top, topEdge)
                        , alignment: .top
                    )
                }
                .frame(height: maxHeight)
                .offset(y: -offset) // Se fija a la parte superior de la pantalla. Evita que se despegue de la parte superior de la pantalla al arrastrar con el dedo el elemento
                .zIndex(1) // Para que la parte morada se quede siempre por delante del listado
                
                VStack(spacing: 15) {
                    ForEach(allMessages) { message in
                        MessageCardView(message: message)
                    }
                }
                .padding()
                .zIndex(0)
            }
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offset
        
        // 80 es el tamaño de la area segura
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (maxHeight - (80 + topEdge))
        
        let value = 1 - progress
        
        let radius = value * 50
        
        return offset < 0 ? radius : 50
    }
    
    func topBarTitleOpacity() -> CGFloat {
        let progress = -(offset + 60) / (maxHeight - (80 + topEdge))
        
        return progress
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TopBar: View {
    @Binding var offset: CGFloat
    
    var topEdge: CGFloat
    var maxHeight: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("Stitch")
                .font(.largeTitle.bold())
            
            Text("Stitch es un personaje de Disney muy popular. ¡Aloha!")
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .padding(.bottom)
        .opacity(getOpacity())
    }
    
    // Con esta funcion se consigue un efecto de desaparicion a medida que el topbar se hace mas pequeño
    func getOpacity() -> CGFloat {
        let progress = -offset / 70
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
}

struct MessageCardView: View {
    var message: Message
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(message.tintColor)
                .frame(width: 50, height: 50)
                .opacity(0.8 )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(message.userName)
                    .fontWeight(.bold)
                
                Text(message.message)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
