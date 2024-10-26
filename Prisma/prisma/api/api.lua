---Prisma API | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/api/api.lua
---Author: Lonaasan
require("/prisma/storage/storage.lua");
require("/prisma/debug/log.lua");

string.prisma = string.prisma or {};
string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};

prismaAPI = {};
local MOD_TAG = "mods";

function prismaAPI.registerMods()
    if not prismaStorage.exists(MOD_TAG) then
        prismaDebugLog.info("Generating Mod Storage");
        prismaStorage.post(MOD_TAG, {});
    else
        prismaDebugLog.info("Removing old mods");
        prismaStorage.removeOldInTag(MOD_TAG, string.prisma.api.mods);
    end
    for modName, mod in pairs(string.prisma.api.mods) do
        if not prismaStorage.existsInTag(MOD_TAG, modName) then
            prismaDebugLog.info("Registering new mod: " .. modName);
            prismaDebugLog.info(mod);
            prismaStorage.postInTag(MOD_TAG, modName, mod);
        elseif prismaStorage.isDifferentInTag(MOD_TAG, modName, mod) then
            prismaDebugLog.info("Updating mod: " .. modName);
            prismaDebugLog.info(mod);
            prismaStorage.patchInTag(MOD_TAG, modName, mod);
        end
    end
end

function prismaAPI.getMods()
    prismaDebugLog.info("Getting all mods from prisma storage");
    for key, value in pairs(prismaStorage.getAllInTag(MOD_TAG)) do
        prismaDebugLog.info("Mod: " .. key);
        prismaDebugLog.info(value);
    end
end

function prismaAPI.getMod(modName)
    if prismaStorage.existsInTag(MOD_TAG, modName) then
        prismaDebugLog.info("Mod: " .. modName);
        prismaDebugLog.info(prismaStorage.get(modName));
    else
        prismaDebugLog.info("Mod: " .. modName .. " does not exist");
    end
end

function prismaAPI.deleteMod(modName)
    if prismaStorage.existsInTag(MOD_TAG, modName) then
        prismaDebugLog.info("Deleting mod: " .. modName);
        prismaStorage.deleteInTag(MOD_TAG, modName);
    else
        prismaDebugLog.info("Mod: " .. modName .. " does not exist");
    end
end

function prismaAPI.clearMods()
    prismaDebugLog.info("Clearing mods");
    prismaStorage.clearInTag(MOD_TAG);
end
