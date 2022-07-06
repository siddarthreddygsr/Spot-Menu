//
//  Home.swift
//  Spot-Menu
//
//  Created by Siddarth Reddy on 06/07/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{
            HStack{
//                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 20,height:20)
                })
                .padding(.leading,250)
                .padding(.top,10)
                
            }
            HStack{
                Image("track")
                .resizable()
                .frame(width: 90,height: 90)
                .padding(10)
                VStack{
                    Text("Let Me Down Slowly")
                        .font(.system(size: 20))
                    Text("Alec Benjamin")
                }
                .frame(width: 190)
                
                
            }
            HStack{
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width:20,height: 20)
                    .padding(10)
                Image(systemName: "gobackward.10")
                    .resizable()
                    .frame(width:27,height: 27)
                    .padding(5)
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width:30,height: 30)
                    .padding(5)
                Image(systemName: "goforward.10")
                    .resizable()
                    .frame(width:27,height: 27)
                    .padding(5)
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width:20,height: 20)
                    .padding(10)
            }
            Spacer()
        }
        .frame(width: 320, height: 250)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

