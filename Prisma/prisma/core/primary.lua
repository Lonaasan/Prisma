---Prisma Primary Script | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/core/primary.lua
---Author: Lonaasan

local _init = init or function()
end;
local _update = update or function()
end;
local _uninit = uninit or function()
end;

string.prisma = string.prisma or {};

function init(...)
    return _init(...);
end

function update(...)
    return _update(...);
end

function uninit(...)
    return _uninit(...);
end
