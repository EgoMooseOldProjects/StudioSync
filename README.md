# StudioSync

Disclaimer: I'm not responsible for you ruining your game by syncing stuff wrong.

## Setup

1. Put sync plugin in roblox plugins folder
2. Create a folder anywhere on your computer
3. Put files from directory folder into this new folder
4. Open node.js cmd prompt and cd to new folder
5. Run:
```
npm install connect
npm install serve-static
```

## Run

1. Open node.js cmd prompt and cd to folder you created earlier
2. Run `node server.js`
3. Open a place in studio and enable http service
4. Run the sync plugin

## Editing Scripts

1. Create a Lua file in your new folder
2. In studio at the top of a script write `-- $sync-FILENAME.lua`
3. When you save the file it will update in studio

**NOTE:** Careful not to sync scripts that have a lot of code in them to an empty file or
else you will lose ur work! If you want to update a script that's not sync'd yet, copy
the code to the new file, then sync.
