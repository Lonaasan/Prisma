---Prisma Debug Logger | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/debug/log.lua
---Author: Lonaasan

string.prisma = string.prisma or {};
string.prisma.compatibility = string.prisma.compatibility or {};
string.prisma.compatibility.check = {};

prismaCompatibilityCheck = {}


---Check we are running with Neon++
---@return boolean
function prismaCompatibilityCheck.IsNeon()
    if neon then
        return true;
    else
        return false;
    end
end

---Check we are running in OpenStarbound
---@return boolean
function prismaCompatibilityCheck.IsOpenStarbound()
    error("Not implemented yet", 2);
    return false;
end


--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.compatibility.check = prismaCompatibilityCheck;