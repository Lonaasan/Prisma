string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.log = {};

prismaDebugLog = {}

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

function prismaDebugLog.info(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

    title = title or "   PRISMA   ";
    sb.logInfo("\n[%s] %s", title, message);
end

function prismaDebugLog.warn(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

	title = title or "   PRISMA   ";
    sb.logWarn("\n[%s] %s", title, message);
end

function prismaDebugLog.error(message, title)
    if not string.prisma.debug.enabled then
        return;
    end

	title = title or "   PRISMA   ";
    sb.logError("\n[%s] %s", title, message);
end


--- Export the functions for 3rd parties to use without the possibility of changing the original code
string.prisma.debug.log = prismaDebugLog;
