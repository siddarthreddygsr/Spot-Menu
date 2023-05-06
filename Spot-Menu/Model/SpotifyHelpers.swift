import AppKit
class SpotifyHelpers {
    public static func tellSpotify(command: String) -> String {
        let response = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to \(command) as string"
        )
        return response
    }
    
    public static func getposition() -> Float {
        let positionString = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to get player position"
        )
        guard let position = Float(positionString) else {
            print("Error: Unable to convert player position string to float")
            return 0.0
        }
        return position
    }
    
    public static func getduration() -> Float {
        let positionString = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to get duration of current track"
        )
        guard let duration = Float(positionString) else {
            print("Error: Unable to convert player position string to float")
            return 0.0
        }
        return duration/1000
    }
    
    public static func getsliderposition() -> Float {
        let durationString = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to get duration of current track"
        )
        guard var duration = Float(durationString) else {
            print("Error: Unable to convert player position string to float")
            return 0.0
        }
        
        let positionString = Helpers.excuteAppleScript(
            script: "tell application \"Spotify\" to get player position"
        )
        guard let position = Float(positionString) else {
            print("Error: Unable to convert player position string to float")
            return 0.0
        }
        
        duration = duration/1000
        var sliderposition = position/duration * 100
        return sliderposition
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
    public var duration: Float
    public var position: Float
    @IBOutlet private var artworkImageView: NSImageView!
//    public var image : UIImage? = currItem?.artwork?.image(at: CGSize(width: 200, height: 200));
    
    init() {
            self.artist = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "artist")
            self.album = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "album")
            self.name = SpotifyHelpers.getSomethingOfCurrentTrack(thing: "name")
            self.duration = SpotifyHelpers.getduration()
            self.position = SpotifyHelpers.getposition()
       }
}
