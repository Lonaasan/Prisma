---Prisma Storage | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/storage/storage.lua
---Author: Lonaasan
require("/prisma/error/error.lua");

string.prisma = string.prisma or {};
string.prisma.storage = string.prisma.storage or {};

prismaStorage = {};

storage = storage or {};

function prismaStorage.get(key)
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    return storage[key];
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

function prismaStorage.put(key, value)
    if not key or not value then
        prismaError.throw("Key or value is nil");
    end
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[key] = value;
end

function prismaStorage.delete(key)
    if storage[key] == nil then
        prismaError.throw("Key does not exist");
    end
    storage[key] = nil;
end

function prismaStorage.clear()
    storage = {};
end

function prismaStorage.getAll()
    return storage;
end

function prismaStorage.exists(key)
    return storage[key] ~= nil;
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.storage = prismaStorage;
