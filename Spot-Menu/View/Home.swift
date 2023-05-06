//
//  Home.swift
//  Spot-Menu
//
//  Created by Siddarth Reddy on 06/07/22.
//

import SwiftUI
import MediaPlayer
//import Spotifyios

struct Home: View {
    @StateObject var updaterViewModel = UpdaterViewModel()
//    @State var sliderValue : Float = 0.0
    let artwork = SpotifyHelpers.tellSpotify(command: "get artwork url of current track")
//    let duration = updaterViewModel.duration
//    let position =  updaterViewModel.position
    @State var sliderValue: Double = 0.0
    var slider = 0.0
    init() {
//        slider = Double(updaterViewModel.slidervalue)
        self.sliderValue = slider
    }
    var body: some View {
        
        VStack{
//            HStack{
//                Button(action: {
//                    NSApplication.shared.terminate(nil)
//                }, label: {
//                    Image(systemName: "rectangle.portrait.and.arrow.right")
//                        .resizable()
//                        .frame(width: 20,height:20)
//                })
//                .buttonStyle(PlainButtonStyle())
//                .padding(.leading,250)
//                .padding(.top,10)
//
//            }
//            Spacer()
            HStack{
                
//                Image("track")
                AsyncImage(
                    url: URL(string: artwork),
                    content: { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 300, maxHeight: 100)
                    },
                    placeholder: {
                        ProgressView()
                    }
                    )
                .frame(maxWidth: 100,maxHeight: 100)
                
//                .padding(10)
//                Image(artwork_url)
//                .resizable()
                
                VStack{
                    Button(action: {
                        NSApplication.shared.terminate(nil)
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 20,height:20)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading,170)
                    .padding(.top,10)
                    Text("\(updaterViewModel.trackname)")
                        .font(.system(size: 20))
                    Text("\(updaterViewModel.artistname)")
//                    @Binding var slider = updaterViewModel.slidervalue
//                    Slider(value: Binding(get: { updaterViewModel.position },
//                                              set: { updaterViewModel.position = $0 }),
//                               in: 0...Double(updaterViewModel.duration))
//                       .padding()
                    Slider(value: Binding(
                        get: { Double(updaterViewModel.position) },
                        set: { updaterViewModel.position = Float($0) }
                    ), in: 0...Double(updaterViewModel.duration))
                    .padding()
                    .onChange(of: updaterViewModel.position) { newValue in
                        let difference = Double(newValue) - Double(updaterViewModel.position)
                        let debug_response = SpotifyHelpers.tellSpotify(command: "set player position to player position - \(difference)")
                        print(debug_response)
                    }
                }
                .frame(width: 190)
//                osascript -e 'tell application "Spotify" to get (duration of current track)div 60000 & (duration of current track)/1000 mod 60 div 1'
            }
            HStack{
                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "previous track")
                    print(response)
                }, label: {
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .frame(width:20,height: 20)
                        .padding(10)
                })
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "set player position to player position - 10 ")
                    print(response)
                }, label: {
                    Image(systemName: "gobackward.10")
                        .resizable()
                        .frame(width:27,height: 27)
                        .padding(5)
                })
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "playpause")
                    print(response)
                }, label: {
                    if updaterViewModel.playerstate == "playing" {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width:30,height: 30)
                            .padding(5)
                    } else {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width:30,height: 30)
                            .padding(5)
                    }
                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "set player position to player position + 10 ")
                    print(response)
                }, label: {
                    Image(systemName: "goforward.10")
                        .resizable()
                        .frame(width:27,height: 27)
                        .padding(5)
                })
                .buttonStyle(PlainButtonStyle())
                
                
                Button(action: {
                    let response = SpotifyHelpers.tellSpotify(command: "next track")
                    print(response)
                }, label: {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .frame(width:20,height: 20)
                        .padding(10)
                })
                .buttonStyle(PlainButtonStyle())
               
            }
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
    @Published var playerstate:String = "paused"
    @Published var duration:Float = 0.0
    @Published var position:Float = 0.0
    @Published var slidervalue:Float = 0.0
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
        playerstate = SpotifyHelpers.tellSpotify(command: "get player state")
        duration = SpotifyHelpers.getduration()
        position = SpotifyHelpers.getposition()
        slidervalue = SpotifyHelpers.getsliderposition()
        print(position)
    }
}
