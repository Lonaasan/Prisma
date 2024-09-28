---Prisma Debug Logger | https://github.com/Lonaasan/Prisma/blob/main/Prisma/prisma/debug/log.lua
---Author: Lonaasan

string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.log = {};

prismaDebugLog = {}

---Log a table in a list format
---@param node table
---@param displayString string
---@return void
function prismaDebugLog.tableList(node, displayString)
    if not string.prisma.debug.enabled then
        return;
    end
    if type(node) == "table" then
        for nodeName, nodeType in pairs(node) do
            sb.logInfo("%s%s : %s", displayString, nodeName, type(nodeType));
            prismaDebugLog.tableList(nodeType, displayString .. nodeName .. ".");
        end
    end
end

---Log a table in a tree format
---@param node table
---@param displayString string
---@return void
function prismaDebugLog.tableTree(node, displayString)
    if not string.prisma.debug.enabled then
        return;
    end
    if type(node) == "table" then
        for nodeName, nodeType in pairs(node) do
            local arrow = "";
            if displayString ~= "" then
                arrow = "└>";
            end
            sb.logInfo("%s%s %s : %s", displayString, arrow, nodeName, type(nodeType));
            prismaDebugLog.tableTree(nodeType, displayString .. "    ");
        end
    end
end

---Log a table in a detailed tree format
---@param node table
---@param displayString string
---@return void
function prismaDebugLog.detailedTableTree(node, displayString)
    if not string.prisma.debug.enabled then
        return;
    end
    if type(node) == "table" then
        for nodeName, nodeType in pairs(node) do
            local arrow = "";
            if displayString ~= "" then
                arrow = "└>";
            end
            sb.logInfo("%s%s %s : %s", displayString, arrow, nodeName, type(nodeType));
            if type(nodeType) ~= "table" and type(nodeType) ~= "function" then
                sb.logInfo("%s       %s", displayString, nodeType);
            end
            prismaDebugLog.detailedTableTree(nodeType, displayString .. "    ");
        end
    end
end

---Log a message with a title
---@param message string
---@param title? string
---@return void
function prismaDebugLog.info(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

    title = title or "   PRISMA   ";
    sb.logInfo("\n[%s] %s", title, message);
end

---Logs a warning message with a title
---@param message string
---@param title? string
---@return void
function prismaDebugLog.warn(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

	title = title or "   PRISMA   ";
    sb.logWarn("\n[%s] %s", title, message);
end

---Logs an error message with a title
---@param message string
---@param title? string
---@return void
function prismaDebugLog.error(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

	title = title or "   PRISMA   ";
    sb.logError("\n[%s] %s", title, message);
end


--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.debug.log = prismaDebugLog;
