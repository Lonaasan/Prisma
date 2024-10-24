---Prisma Storage | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/storage/storage.lua
---Author: Lonaasan
require("/prisma/error/error.lua");
require("/prisma/utils/utils.lua");

string.prisma = string.prisma or {};
string.prisma.storage = string.prisma.storage or {};

prismaStorage = {};

storage = storage or {};

function prismaStorage.get(key)
    if not key then
        prismaError.throw("Key is nil");
    end
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    return storage[key];
end

function prismaStorage.getInTag(tag, key)
    if not tag or not key then
        prismaError.throw("Tag or key is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    if storage[tag][key] == nil then
        prismaError.throw("Key does not exist");
    end
    return storage[tag][key];
end

function prismaStorage.post(key, value)
    if not key or not value then
        prismaError.throw("Key or value is nil");
    end
    if storage[key] then
        prismaError.throw("Key already exists");
    end
    storage[key] = value;
end

function prismaStorage.postInTag(tag, key, value)
    if not tag or not key or not value then
        prismaError.throw("Tag or key or value is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    if storage[tag][key] then
        prismaError.throw("Key already exists");
    end
    storage[tag][key] = value;
end

function prismaStorage.patch(key, value)
    if not key or not value then
        prismaError.throw("Key or value is nil");
    end
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[key] = value;
end

function prismaStorage.patchInTag(tag, key, value)
    if not tag or not key or not value then
        prismaError.throw("Tag or key or value is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    if storage[tag][key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[tag][key] = value;
end

function prismaStorage.delete(key)
    if not key then
        prismaError.throw("Key is nil");
    end
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[key] = nil;
end

function prismaStorage.deleteInTag(tag, key)
    if not tag or not key then
        prismaError.throw("Tag or key is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    if storage[tag][key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[tag][key] = nil;
end

function prismaStorage.clear()
    storage = {};
end

function prismaStorage.clearInTag(tag)
    storage[tag] = {};
end

function prismaStorage.getAll()
    return storage;
end

function prismaStorage.getAllInTag(tag)
    return storage[tag];
end

function prismaStorage.exists(key)
    if not key then
        prismaError.throw("Key is nil");
    end
    return storage[key] ~= nil;
end

function prismaStorage.existsInTag(tag, key)
    if not tag or not key then
        prismaError.throw("Tag or key is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    return storage[tag][key] ~= nil;
end

--- function that returns true if the value of a key is not the same as the stored one
function prismaStorage.isDifferent(key, value)
    if not key or not value then
        prismaError.throw("Key or value is nil");
    end
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    return not PrismaUtils.equals(storage[key], value);
end

function prismaStorage.isDifferentInTag(tag, key, value)
    if not tag or not key or not value then
        prismaError.throw("Tag or key or value is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    if storage[tag][key] == nil then
        prismaError.throw("Key does not exist");
    end
    return not PrismaUtils.equals(storage[tag][key], value);
end

function prismaStorage.removeOld(keys)
    if not keys then
        prismaError.throw("Key is nil");
    end
    for key, _ in pairs(storage) do
        if not keys[key] then
            storage[key] = nil;
        end
    end
end

function prismaStorage.removeOldInTag(tag, keys)
    if not tag or not keys then
        prismaError.throw("Tag or key is nil");
    end
    if storage[tag] == nil then
        prismaError.throw("Tag does not exist");
    end
    for key, _ in pairs(storage[tag]) do
        if not keys[key] then
            storage[tag][key] = nil;
        end
    end
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.storage = prismaStorage;
