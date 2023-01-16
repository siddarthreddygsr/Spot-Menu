import AppKit
class SpotifyHelpers {
    public static func tellSpotify(command: String) -> String {
        let response = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to \(command) as string"
        )
        return response
    }

    public static func getSomethingOfCurrentTrack(thing: String) -> String {
        return tellSpotify(
            command: "\(thing) of current track"
            ).replacingOccurrences(
                of: "\n", with: ""
        )
    }

    public static func getNowPlaying() -> Track? {
        if self.isSpotifyRunning() {
            return Track()
        }
        return nil
    }

    public static func isSpotifyRunning() -> Bool {
        return Helpers.excuteAppleScript(script: "application \"Spotify\" is running") == "true"
    }
}

class Track{
    public var artist: String
    public var album: String
    public var name: String
    @IBOutlet private var artworkImageView: NSImageView!
//    public var image : UIImage? = currItem?.artwork?.image(at: CGSize(width: 200, height: 200));
    
    init() {
           self.artist = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "artist")
           self.album = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "album")
           self.name = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "name")
       }
}
