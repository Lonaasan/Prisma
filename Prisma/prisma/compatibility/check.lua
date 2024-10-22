---Prisma Debug Logger | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/debug/log.lua
---Author: Lonaasan
string.prisma = string.prisma or {};
string.prisma.compatibility = string.prisma.compatibility or {};
string.prisma.compatibility.check = {};

prismaCompatibilityCheck = {}

---Check we are running with Neon++
---@return boolean
function prismaCompatibilityCheck.IsNeon()
    return neon ~= nil;
end

---Check we are running with StarExtensions
---@return boolean
function prismaCompatibilityCheck.IsStarExtensions()
    return starExtensions ~= nil;
end

---Check we are running in OpenStarbound
---@return boolean
function prismaCompatibilityCheck.IsOpenStarbound()
    return root.assetJson("/player.config:genericScriptContexts").OpenStarbound ~= nil;
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.compatibility.check = prismaCompatibilityCheck;
