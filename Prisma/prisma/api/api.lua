---Prisma API | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/api/api.lua
---Author: Lonaasan
require("/prisma/storage/storage.lua");
require("/prisma/debug/log.lua");

string.prisma = string.prisma or {};
string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};

prismaAPI = {};

function prismaAPI.registerMods()
    for modName, mod in pairs(string.prisma.api.mods) do
        if not prismaStorage.exists(modName) then
            prismaDebugLog.info("Registering mod: " .. modName);
            prismaDebugLog.info(mod);
            prismaStorage.post(modName, mod);
        elseif prismaStorage.isDifferent(modName, mod) then
            prismaDebugLog.info("Mod: " .. modName .. " is different");
            prismaDebugLog.info(mod);
            prismaStorage.put(modName, mod);
        end
    end
end

function prismaAPI.getMods()
    for key, value in pairs(prismaStorage.getAll()) do
        prismaDebugLog.info("Key: " .. key);
        prismaDebugLog.info(value);
    end
end
