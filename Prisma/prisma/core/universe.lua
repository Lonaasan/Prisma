---Prisma Universe Script | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/core/universe.lua
---Author: Lonaasan
require("/prisma/debug/log.lua");

local _init = init or function()
end;
local _update = update or function()
end;
local _uninit = uninit or function()
end;

string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.enabled = true;

function init(...)
    prismaDebugLog.info("Prisma Universe Script Loaded!");
    -- prismaDebugLog.detailedTableTree(_ENV, "");
    return _init(...);
end
function update(...)
    return _update(...);
end
function uninit(...)
    return _uninit(...);
end
