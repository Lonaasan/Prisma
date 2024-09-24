
string.prisma = string.prisma or {}
string.prisma.debug = string.prisma.debug or {}
string.prisma.debug.log = {}

function string.prisma.debug.log.TableList(e, p)
    if not string.prisma.debug.enabled then
        return
    end
    if type(e) == "table" then
        for k, v in pairs(e) do
            sb.logInfo("%s%s : %s",p,k, type(v))
            --sb.logInfo("%s",v)
            string.prisma.debug.log.TableList(v,p .. k .. ".")
        end
    end
end

function string.prisma.debug.log.TableTree(e, p)
    if not string.prisma.debug.enabled then
        return
    end
    if type(e) == "table" then
        for k, v in pairs(e) do
            local arrow = ""
            if p ~= "" then
                arrow = "└>"
            end
            sb.logInfo("%s%s %s : %s",p,arrow,k, type(v))
            --sb.logInfo("%s",v)
            string.prisma.debug.log.TableTree(v,p .. "    ")
        end
    end
end

function string.prisma.debug.log.DetailedTableTree(e, p)
    if not string.prisma.debug.enabled then
        return
    end
    if type(e) == "table" then
        for k, v in pairs(e) do
            local arrow = ""
            if p ~= "" then
                arrow = "└>"
            end
            sb.logInfo("%s%s %s : %s",p,arrow,k, type(v))
            if type(v) ~= "table" and type(v) ~= "function" then
                sb.logInfo("%s       %s",p,v)
            end
            string.prisma.debug.log.DetailedTableTree(v,p .. "    ")
        end
    end
end

