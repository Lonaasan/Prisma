---Prisma API | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/api/api.lua
---Author: Lonaasan

string.prisma = string.prisma or {};
string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};

prismaAPI = {};

local prismaAPIStorage = {};

function prismaAPI.registerMods()
    for modName, mod in pairs(string.prisma.api.mods) do
        string.prisma.debug.log.info("Registering mod: " .. modName);
        string.prisma.debug.log.info("Mod: " .. mod);
        prismaAPIStorage[modName] = mod;
    end
end

function prismaAPI.getMods()
    for modName, mod in pairs(prismaAPIStorage) do
        string.prisma.debug.log.info("Stored mod: " .. modName);
        string.prisma.debug.log.info("Mod: " .. mod);
    end
end