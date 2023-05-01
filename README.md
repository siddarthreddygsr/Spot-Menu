commands to be integrated:

```
 osascript -e 'tell application "Spotify" to get (duration of current track)div 60000 & (duration of current track)/1000 mod 60 div 1'
 osascript -e 'tell application "Spotify" to get artwork url of current track'
```

to do:

[ ] - fix track artwork
[ ] - implement slider 
