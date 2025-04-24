local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('gangmenu:getGangData', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        cb(Player.PlayerData.gang)
    else
        cb(nil)
    end
end)

local function getClosestPlayer(source)
    local players = QBCore.Functions.GetPlayers()
    local srcPed = GetPlayerPed(source)
    local srcCoords = GetEntityCoords(srcPed)
    local closestPlayer, closestDist = nil, 3.0

    for _, v in pairs(players) do
        if v ~= source then
            local targetPed = GetPlayerPed(v)
            local dist = #(GetEntityCoords(targetPed) - srcCoords)
            if dist < closestDist then
                closestPlayer = v
                closestDist = dist
            end
        end
    end
    return closestPlayer
end

RegisterServerEvent("gangmenu:inviteNearby", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local closest = getClosestPlayer(src)

    if closest then
        local Target = QBCore.Functions.GetPlayer(closest)
        if Target then
            Target.Functions.SetGang(Player.PlayerData.gang.name, 0)
            TriggerClientEvent('QBCore:Notify', closest, "You've been invited to a gang!", "success")
            TriggerClientEvent('QBCore:Notify', src, "Player invited to gang.", "success")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "No one nearby to invite!", "error")
    end
end)

RegisterServerEvent("gangmenu:promoteNearby", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local closest = getClosestPlayer(src)

    if closest then
        local Target = QBCore.Functions.GetPlayer(closest)
        if Target and Target.PlayerData.gang.name == Player.PlayerData.gang.name then
            local newGrade = math.min(Target.PlayerData.gang.grade + 1, 4)
            Target.Functions.SetGang(Target.PlayerData.gang.name, newGrade)
            TriggerClientEvent('QBCore:Notify', closest, "You’ve been promoted!", "success")
        end
    end
end)

RegisterServerEvent("gangmenu:demoteNearby", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local closest = getClosestPlayer(src)

    if closest then
        local Target = QBCore.Functions.GetPlayer(closest)
        if Target and Target.PlayerData.gang.name == Player.PlayerData.gang.name then
            local newGrade = math.max(Target.PlayerData.gang.grade - 1, 0)
            Target.Functions.SetGang(Target.PlayerData.gang.name, newGrade)
            TriggerClientEvent('QBCore:Notify', closest, "You’ve been demoted.", "error")
        end
    end
end)

RegisterServerEvent("gangmenu:kickNearby", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local closest = getClosestPlayer(src)

    if closest then
        local Target = QBCore.Functions.GetPlayer(closest)
        if Target and Target.PlayerData.gang.name == Player.PlayerData.gang.name then
            Target.Functions.SetGang("none", 0)
            TriggerClientEvent('QBCore:Notify', closest, "You were kicked from the gang.", "error")
        end
    end
end)
