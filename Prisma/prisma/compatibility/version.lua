---Prisma API | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/compatibility/version.lua
---Author: Lonaasan
require("/prisma/error/error.lua");

string.prisma = string.prisma or {};
string.prisma.compatibility = string.prisma.compatibility or {};
string.prisma.compatibility.version = string.prisma.compatibility.version or {};

prismaCompatibilityVersion = {};



function prismaCompatibilityVersion.parseSingleVersion(version)
    local parsedVersion = {}

    -- Check for exact version
    if string.match(version, "^(%d+)%.(%d+)%.(%d+)$") then
        parsedVersion["min"] = version
        parsedVersion["max"] = version

    -- Check for wildcard version
    elseif string.match(version, "^%*(%d+)%.(%d+)%.(%d+)$") then
        local major = string.gsub(version, "%*", "")
        major = string.gsub(major, "%*", "")
        parsedVersion["min"] = major
        parsedVersion["max"] = ""

    -- Check for caret version
    elseif string.match(version, "^%^(%d+)%.(%d+)%.(%d+)$") then
        local major, _ = string.match(version, "^%^(%d+)")
        major = string.gsub(major, "%^", "")
        local minor, patch = string.match(version, "%.(%d+)%.(%d+)$")
        parsedVersion["min"] = major .. "." .. minor .. "." .. patch
        parsedVersion["max"] = major

    -- Check for tilde version
    elseif string.match(version, "^~(%d+)%.(%d+)%.(%d+)$") then
        local major, _ = string.match(version, "~(%d+)")
        major = string.gsub(major, "~", "")
        local minor, patch = string.match(version, "%.(%d+)%.(%d+)$")
        parsedVersion["min"] = major .. "." .. minor .. "." .. patch
        parsedVersion["max"] = major .. "." .. minor

    else
        error("Invalid version format: " .. version)
    end

    return parsedVersion
end

function prismaCompatibilityVersion.parseVersions(requires)
    local parsedVersions = {}

    for name, version in pairs(requires) do
        parsedVersions[name] = prismaCompatibilityVersion.parseSingleVersion(version)
    end

    return parsedVersions
end

--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.compatibility.version = prismaCompatibilityVersion;