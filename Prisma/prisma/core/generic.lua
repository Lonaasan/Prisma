---Prisma Generic Script | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/core/generic.lua
---Author: Lonaasan
require("/prisma/debug/log.lua");
require("/prisma/debug/luacheck.lua");
require("/prisma/api/api.lua");
require("/prisma/compatibility/check.lua");
require("/prisma/compatibility/version.lua");
require("/prisma/storage/storage.lua");

local _init = init or function()
end;
local _update = update or function()
end;
local _uninit = uninit or function()
end;

local FIRST_SUCCESS_UPDATE = true;

string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.enabled = true;

string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};

function init(...)
    string.prisma.api.mods.TestMod = {
        author = "examplename",
        description = "exampletext",
        scripts = {
            examplescript = {
                scriptpath = "/path/to/your/examplescript.lua",
                options = {
                    autostart = true
                    },
                tables = {
                    tech = true,
                    localAnimator = true
                }
            }
        }
    };

    prismaDebugLog.info("Checking the environment compatibility...");
    local environments = {
        neon = prismaCompatibilityCheck.IsNeon(),
        star_extensions = prismaCompatibilityCheck.IsStarExtensions(),
        open_starbound = prismaCompatibilityCheck.IsOpenStarbound(),
        x_starbound = prismaCompatibilityCheck.IsXStarbound(),
        vanilla = prismaCompatibilityCheck.IsVanilla()
    }

    prismaDebugLog.info(environments);

    prismaDebugLog.info("Testing the version compatibility script...");

    local versions = {
        example0 = "1.2.3",
        example1 = "~43.6.2",
        example2 = "^8.9.4",
        example3 = "*4.12.7"
    };
    prismaDebugLog.info( prismaCompatibilityVersion.parseVersions(versions));

    return _init(...);
end

function update(...)
    if not localAnimator then
        localAnimator = string.prisma.localAnimator;
    elseif FIRST_SUCCESS_UPDATE then

        prismaDebugLog.info("Got the LocalAnimator!");

        FIRST_SUCCESS_UPDATE = false;

        --prismaDebugLog.detailedTableTree(_ENV, "");

        -- local resultTable = prismaDebugLuacheck.globalsTable(_ENV)
        -- local resultString = prismaDebugLuacheck.customEncode(resultTable)
        -- resultString = prismaDebugLuacheck.cleanUp(resultString)
        -- if resultString then
        --     prismaDebugLog.info(resultString)
        -- end

        prismaAPI.registerMods();
        prismaAPI.getMods();
    end
    return _update(...);
end

function uninit(...)
    return _uninit(...);
end
