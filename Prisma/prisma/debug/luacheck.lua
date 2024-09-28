--- Prisma Debug Luacheck | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/debug/luacheck.lua
--- Author: Lonaasan

string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.luacheck = {};

prismaDebugLuacheck = {};

---Generate a table of all global variables
---@param node table
---@return table
function prismaDebugLuacheck.globalsTable(node)
    if not string.prisma.debug.enabled then
        return;
    end

    local resultTable = {}

    if type(node) == "table" then
        for nodeName, nodeValue in pairs(node) do
            if type(nodeValue) == "table" then
                resultTable[nodeName] = prismaDebugLuacheck.globalsTable(nodeValue)
            elseif type(nodeValue) == "function" then
                resultTable[nodeName] = {} -- Replace functions with an empty table
            else
                resultTable[nodeName] = nodeValue -- Copy other types directly
            end
        end
    end

    return resultTable
end

---Custom encode function to handle tables
---@param value table
---@return string
function prismaDebugLuacheck.customEncode(value)
    if not string.prisma.debug.enabled then
        return;
    end

    if type(value) == "table" then
        local elements = {}
        for k, v in pairs(value) do
            local key = type(k) == "string" and string.format('"%s": ', k) or ""
            table.insert(elements, key .. prismaDebugLuacheck.customEncode(v))
        end
        return "{ fields: {" .. table.concat(elements, ", ") .. "}}"
    elseif type(value) == "string" then
        return "{}" -- string.format('"%s"', value)
    elseif type(value) == "number" or type(value) == "boolean" then
        return "{}" -- tostring(value)
    else
        return "null" -- Handle nil values
    end
end

---Clean up the output string
---@param input string
---@return string
function prismaDebugLuacheck.cleanUp(input)
    if not string.prisma.debug.enabled then
        return;
    end

    local output = input:gsub(':', ' =');
    output = output:gsub(' fields = {}', '')
    output = output:gsub('{"', '{ ')
    output = output:gsub(', "', ', ')
    output = output:gsub('" =', ' =')
    return output
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.debug.luacheck = prismaDebugLuacheck;