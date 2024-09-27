string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.luacheckgenerator = {};

function string.prisma.debug.luacheckgenerator.luaCheckGlobalsTable(node)
    local resultTable = {}

    if type(node) == "table" then
        for nodeName, nodeValue in pairs(node) do
            if type(nodeValue) == "table" then
                resultTable[nodeName] = string.prisma.debug.luacheckgenerator.luaCheckGlobalsTable(nodeValue)
            elseif type(nodeValue) == "function" then
                resultTable[nodeName] = {}  -- Replace functions with an empty table
            else
                resultTable[nodeName] = nodeValue  -- Copy other types directly
            end
        end
    end

    return resultTable
end

function string.prisma.debug.luacheckgenerator.customEncode(value)
    if type(value) == "table" then
        local elements = {}
        for k, v in pairs(value) do
            local key = type(k) == "string" and string.format('"%s": ', k) or ""
            table.insert(elements, key .. string.prisma.debug.luacheckgenerator.customEncode(v))
        end
        return "{ fields: {" .. table.concat(elements, ", ") .. "}}"
    elseif type(value) == "string" then
        return "{}" --string.format('"%s"', value)
    elseif type(value) == "number" or type(value) == "boolean" then
        return "{}" --tostring(value)
    else
        return "null"  -- Handle nil values
    end
end

function string.prisma.debug.luacheckgenerator.cleanUp(input)
    local output = input:gsub(':', ' =')
    output = output:gsub(' fields = {}', '')
    output = output:gsub('{"', '{ ')
    output = output:gsub(', "', ', ')
    output = output:gsub('" =', ' =')
    return output
end