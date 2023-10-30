--- @module util
local util = {}

function util.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

return util