---Prisma API Registry | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/api/registry.lua
---Author: Lonaasan

string.prisma = string.prisma or {};
string.prisma.api = string.prisma.api or {};
string.prisma.api.registry = string.prisma.api.registry or {};
string.prisma.api.registry.mods = string.prisma.api.registry.mods or {};

prismaAPIRegistry = {};

local prismaAPIRegistryStorage = {};

function prismaAPIRegistry.registerMods()
    for modName, mod in pairs(string.prisma.api.registry.mods) do
        string.prisma.debug.log.info("Registering mod: " .. modName);
        string.prisma.debug.log.info("Mod: " .. mod);
        prismaAPIRegistryStorage[modName] = mod;
    end
end

function prismaAPIRegistry.getMods()
    for modName, mod in pairs(prismaAPIRegistryStorage) do
        string.prisma.debug.log.info("Stored mod: " .. modName);
        string.prisma.debug.log.info("Mod: " .. mod);
    end
end