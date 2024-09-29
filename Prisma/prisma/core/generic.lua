---Prisma Generic Script | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/core/generic.lua
---Author: Lonaasan

require("/prisma/debug/log.lua");
require("/prisma/debug/luacheck.lua");
require("/prisma/api/api.lua");

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



string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};



function init(...)
    string.prisma.api.mods.TestMod = "TestMod Content";
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

        prismaAPI.registerMods();
        prismaAPI.getMods();
    end
    return _update(...);
end

function uninit(...)
    return _uninit(...);
end
