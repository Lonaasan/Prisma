---Prisma API | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/api/api.lua
---Author: Lonaasan
require("/prisma/storage/storage.lua");

string.prisma = string.prisma or {};
string.prisma.api = string.prisma.api or {};
string.prisma.api.mods = string.prisma.api.mods or {};

prismaAPI = {};

function prismaAPI.registerMods()
    for modName, mod in pairs(string.prisma.api.mods) do
        if not prismaStorage.exists(modName) then
            string.prisma.debug.log.info("Registering mod: " .. modName);
            string.prisma.debug.log.info("Mod: " .. mod);
            prismaStorage.post(modName, mod);
        end
    end
end

function prismaAPI.getMods()
    for key, value in pairs(prismaStorage.getAll()) do
        string.prisma.debug.log.info("Key: " .. key);
        string.prisma.debug.log.info("Value: " .. value);
    end
end
