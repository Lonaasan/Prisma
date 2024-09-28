require("/prisma/debug/log.lua");
require("/prisma/debug/luacheckgenerator.lua");

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

        local resultTable = prismaDebugLuacheckGenerator.luaCheckGlobalsTable(_ENV)
        local resultString = prismaDebugLuacheckGenerator.customEncode(resultTable)
        resultString = prismaDebugLuacheckGenerator.cleanUp(resultString)
        if resultString then
            sb.logInfo("%s", resultString)
        end
    end
    return _update(...);
end

function uninit(...)
    return _uninit(...);
end
