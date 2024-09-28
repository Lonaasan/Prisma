---Prisma Generic Script | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/core/generic.lua
---Author: Lonaasan

require("/prisma/debug/log.lua");
require("/prisma/debug/luacheck.lua");

local _init = init or function()
end;
local _update = update or function()
end;
local _uninit = uninit or function()
end;

local firstSuccessUpdate = true;

string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.enabled = false;

function init(...)
    return _init(...);
end

function update(...)
    if not localAnimator then
        localAnimator = string.prisma.localAnimator;
    elseif firstSuccessUpdate then

        prismaDebugLog.info("Got the LocalAnimator!");

        firstSuccessUpdate = false;

        -- prismaDebugLog.detailedTableTree(_ENV, "");

        local resultTable = prismaDebugLuacheck.globalsTable(_ENV)
        local resultString = prismaDebugLuacheck.customEncode(resultTable)
        resultString = prismaDebugLuacheck.cleanUp(resultString)
        if resultString then
            prismaDebugLog.info(resultString)
        end
    end
    return _update(...);
end

function uninit(...)
    return _uninit(...);
end
