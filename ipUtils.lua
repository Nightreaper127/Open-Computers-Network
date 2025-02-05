local tools = {}

tools.numberToCondense = function(readableIP)
    local ipArray = {}
    for i in readableIP:gmatch("%d+") do
        table.insert(ipArray, tonumber(i))
    end

    local internalIPnum = 0
    for i=1, #ipArray do
        internalIPnum = internalIPnum + ipArray[i]*256^(4-i)
    end
    return math.floor(internalIPnum)
end

tools.condensedToNumber = function(condensedIP)
    local parts = {}
    parts[1] = math.floor(condensedIP / 256^3)
    condensedIP = condensedIP %256^3
    parts[2] = math.floor(condensedIP / 256^2)
    condensedIP = condensedIP % 256^2
    parts[3] = math.floor(condensedIP / 256)
    condensedIP = condensedIP % 256
    parts[4] = condensedIP % 256
    local a = table.concat(parts, "."):reverse()
    a = a:sub(3)
    a=a:reverse()
    return a
end

local setup = function()
    _G.IP = {}
    _G.IP.packet = {
        protocol = nil,
        senderPort = nil,
        targetPort = nil,
        senderIP = nil,
        targetIP = nil,
        senderMAC = nil,
        targetMAC = nil,
        data = nil
    }
    _G.IP.clientIP = tools.numberToCondense('0.0.0.0')
    _G.IP.subnetMask = tools.numberToCondense('0.0.0.0')
    _G.IP.defaultGateway = tools.numberToCondense('0.0.0.0')
    _G.IP.MAC = require("component").modem.address
end

local a = '192.168.1.1'
print(tools.numberToCondense(a))
print(tools.condensedToNumber(tools.numberToCondense(a)))
print(string.format('%q', _G.IP.packet))