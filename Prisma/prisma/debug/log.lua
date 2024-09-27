string.prisma = string.prisma or {};
string.prisma.debug = string.prisma.debug or {};
string.prisma.debug.log = {};

function string.prisma.debug.log.tableList(node, displayString)
	if not string.prisma.debug.enabled then
		return;
	end;
	if type(node) == "table" then
		for nodeName, nodeType in pairs(node) do
			sb.logInfo("%s%s : %s", displayString, nodeName, type(nodeType));
			string.prisma.debug.log.tableList(nodeType, displayString .. nodeName .. ".");
		end;
	end;
end;

function string.prisma.debug.log.tableTree(node, displayString)
	if not string.prisma.debug.enabled then
		return;
	end;
	if type(node) == "table" then
		for nodeName, nodeType in pairs(node) do
			local arrow = "";
			if displayString ~= "" then
				arrow = "└>";
			end;
			sb.logInfo("%s%s %s : %s", displayString, arrow, nodeName, type(nodeType));
			string.prisma.debug.log.tableTree(nodeType, displayString .. "    ");
		end;
	end;
end;

function string.prisma.debug.log.detailedTableTree(node, displayString)
	if not string.prisma.debug.enabled then
		return;
	end;
	if type(node) == "table" then
		for nodeName, nodeType in pairs(node) do
			local arrow = "";
			if displayString ~= "" then
				arrow = "└>";
			end;
			sb.logInfo("%s%s %s : %s", displayString, arrow, nodeName, type(nodeType));
			if type(nodeType) ~= "table" and type(nodeType) ~= "function" then
				sb.logInfo("%s       %s", displayString, nodeType);
			end;
			string.prisma.debug.log.detailedTableTree(nodeType, displayString .. "    ");
		end;
	end;
end;

function string.prisma.debug.log.info()
	sb.logInfo();
end;
