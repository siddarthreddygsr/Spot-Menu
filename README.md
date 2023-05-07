commands to be integrated:

```
 osascript -e 'tell application "Spotify" to get (duration of current track)div 60000 & (duration of current track)/1000 mod 60 div 1'
```
used scripts:
```
 osascript -e 'tell application "Spotify" to get artwork url of current track'
```

to do:

- [x] fix track artwork
- [x] implement slider 
- [ ] make song name and artist name scrollable when it crosses a certain limit
- [ ] optimise slider
