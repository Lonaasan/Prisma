require("/prisma/debug/log.lua")

local _init = init or function() end
local _update = update or function() end
local _uninit = uninit or function() end

local firstSuccessUpdate = true -- boolean


string.prisma = string.prisma or {}
string.prisma.debug = string.prisma.debug or {}
--if _SBLOADED["/prisma/debug/log.lua"] then
string.prisma.debug.enabled = false
--end

function init(...)
    return _init(...)
end

function update(...)
    if not localAnimator then
        localAnimator = string.prisma.localAnimator
    elseif firstSuccessUpdate then
        sb.logInfo("Got the LocalAnimator!")
        firstSuccessUpdate = false
        string.prisma.debug.log.DetailedTableTree(_ENV, "")
    end
    return _update(...)
end

function uninit(...)
    return _uninit(...)
end