//
//  Home.swift
//  Spot-Menu
//
//  Created by Siddarth Reddy on 06/07/22.
//

import SwiftUI
import MediaPlayer

struct Home: View {
    @StateObject var updaterViewModel = UpdaterViewModel()
    var body: some View {
       
        VStack{
            HStack{
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 20,height:20)
                })
                .buttonStyle(PlainButtonStyle())
                .padding(.leading,250)
                .padding(.top,10)
                
            }
            HStack{
                Image("track")
                .resizable()
                .frame(width: 90,height: 90)
                .padding(10)
                
                VStack{
                    Text("\(updaterViewModel.trackname)")
                        .font(.system(size: 20))
                    
                    Text("\(updaterViewModel.artistname)")
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
                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "playpause")
                    print(response)
                }, label: {
                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width:30,height: 30)
                                        .padding(5)
                })
                .buttonStyle(PlainButtonStyle())

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
        .frame(width: 320, height: 220)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//class Updater {
//    public static func getTrack(response: String){
//        response = SpotifyHelpers.tellSpotify(command: "get name of current track")
//    }
//}

//var timer = Timer()
//var trackname:String = "ERROR"
//func viewDidLoad() {
//    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
//        getTrackname(trackname: &trackname)
//    })
//}
//
//func getTrackname(trackname: inout String){
//    trackname = SpotifyHelpers.tellSpotify(command: "get name of current track")
//}
//func getArtist(artist: inout String){
//    artist = SpotifyHelpers.tellSpotify(command: "get artist of current track")
//}

class UpdaterViewModel: ObservableObject {
    @Published var trackname:String = "ERROR"
    @Published var artistname:String = "ERROR"

    var timer: Timer?
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.refresh()
        })
    }
    deinit {
        timer?.invalidate()
    }
    func refresh() {
        trackname = SpotifyHelpers.tellSpotify(command: "get name of current track")
        artistname = SpotifyHelpers.tellSpotify(command: "get artist of current track")
    }
}
