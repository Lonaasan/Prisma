---Prisma Storage | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/utils/utils.lua
---Author: Various Authors (credited at each Method) & Lonaasan

string.prisma = string.prisma or {};
string.prisma.utils = string.prisma.utils or {};

PrismaUtils = {};

--- Method to compare two tables
--- By: igv
--- Edited by: rboy
--- Source: https://stackoverflow.com/a/32660766
--- @param o1 table
--- @param o2 table
--- @param ignore_mt boolean
--- @return boolean
function PrismaUtils.equals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or PrismaUtils.equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.utils = PrismaUtils;