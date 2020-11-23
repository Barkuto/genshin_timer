# Genshin Timer

## Info
Web App to keep track of when tasks done are going to be refreshed.

Examples: 
- Keep track of when ores in your world are going to be refreshed
- Keep track of when last artifact farm was
- Know when to look for a certain local specialty

### How To Use
1. Press "Add Timer" to add a new timer
2. Rename timer to whatever it is going to time
3. Choose the correct refresh time "12H", "24H", etc
4. Right before starting task, press the "Set Timer"
5. Do task
6. Wait for timer to say "00:00:00" until next time to start task

- Use "Stop" button to stop the timer
- Use "Delete" button to delete the timer
- Timer data is stored inside browser, clearing cache/data might delete timers

## Development
```
npm install
npm run serve
```