---Prisma Error | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/error/error.lua
---Author: Lonaasan
string.prisma = string.prisma or {};
string.prisma.error = string.prisma.error or {};

prismaError = {};

function prismaError.throw(errorMessage, errorLevel)
    errorLevel = errorLevel or 3;
    error(errorMessage, errorLevel);
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.error = prismaError;
