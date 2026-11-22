local STICKER = "playCount"

---@type PlaycountPlugin
local M = {
    enabled = true,
}

M.setup = function(self, args)
    if not args then
        args = {}
    end
    self.enabled = args.enabled ~= false
end

M.song_change = function(self, _old_song, new_song)
    if not self.enabled then
        return
    end

    if new_song == nil then
        return
    end

    local sticker, get_err = mpd.get_song_sticker(new_song.file, STICKER)
    if get_err ~= nil then
        log.error("Failed to read play count of '" .. new_song.file .. "': " .. get_err)
        return
    end

    local count = (tonumber(sticker) or 0) + 1
    log.debug("Setting play count of '" .. new_song.file .. "' to " .. count)

    local _, set_err = mpd.set_song_sticker(new_song.file, STICKER, tostring(count))
    if set_err ~= nil then
        log.error("Failed to write play count of '" .. new_song.file .. "': " .. set_err)
    end
end

---@param plugin PlaycountPlugin
---@param enabled boolean
local function set_enabled(plugin, enabled)
    log.info((enabled and "Enabling" or "Disabling") .. " playcount plugin")
    plugin.enabled = enabled
end

M.subscribed_channels = { "rmpcd.playcount" }
M.message = function(self, _channel, message)
    if message == "enable" then
        set_enabled(self, true)
    elseif message == "disable" then
        set_enabled(self, false)
    elseif message == "toggle" then
        set_enabled(self, not self.enabled)
    end
end

return M
