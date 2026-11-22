Track playcount of songs, stored inside the `playCount` sticker.

## Requirements

[sticker_file](https://mpd.readthedocs.io/en/stable/mpd.conf.5.html#confval-sticker_file) has to be
configured in your MPD.

## Installation

```lua
rmpcd.install({ url = "https://github.com/rmpc-org/rmpcd-playcount.git" })
```

## Configuration

All options are optional, defaults are below.

```lua
---@type PlaycountPluginHandle
local playcount = rmpcd.install({ url = "https://github.com/rmpc-org/rmpcd-playcount.git" })
playcount:setup({
    enabled = true,
})
```

## Displaying the play count

The count can be shown in rmpc with the `Sticker` property, for example as a column in the song
table in your `theme.ron`:

```rust
song_table_format: [
    (
        prop: (kind: Sticker("playCount"), default: (kind: Text("0"))),
        width: "9",
        alignment: Right,
        label: "Playcount"
    ),
],
```

## Runtime control

Counting can be turned on and off without restarting rmpcd by sending a message to the
`rmpcd.playcount` channel, for example with rmpc:

```sh
rmpc sendmessage rmpcd.playcount disable
rmpc sendmessage rmpcd.playcount enable
rmpc sendmessage rmpcd.playcount toggle
```
