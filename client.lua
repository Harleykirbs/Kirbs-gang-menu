local QBCore = exports['qb-core']:GetCoreObject()

RegisterKeyMapping('gangmenu', 'Open Gang Menu', 'keyboard', 'F10')

RegisterCommand('gangmenu', function()
    QBCore.Functions.TriggerCallback('gangmenu:getGangData', function(gang)
        if gang and gang.name ~= "none" then
            local menu = {
                {
                    header = "💀 Gang Menu - " .. gang.label,
                    isMenuHeader = true
                },
                {
                    header = "📥 Invite Nearby Player",
                    txt = "Invite a player within 3 meters",
                    params = {
                        event = "gangmenu:invitePlayer"
                    }
                },
                {
                    header = "⬆ Promote Member",
                    txt = "Promote a gang member",
                    params = {
                        event = "gangmenu:promotePlayer"
                    }
                },
                {
                    header = "⬇ Demote Member",
                    txt = "Demote a gang member",
                    params = {
                        event = "gangmenu:demotePlayer"
                    }
                },
                {
                    header = "❌ Kick Member",
                    txt = "Remove a gang member",
                    params = {
                        event = "gangmenu:kickPlayer"
                    }
                },
                {
                    header = "❌ Close Menu",
                    params = {
                        event = ""
                    }
                }
            }

            exports['qb-menu']:openMenu(menu)
        else
            QBCore.Functions.Notify("You're not in a gang!", "error")
        end
    end)
end)

RegisterNetEvent("gangmenu:invitePlayer", function()
    TriggerServerEvent("gangmenu:inviteNearby")
end)

RegisterNetEvent("gangmenu:promotePlayer", function()
    TriggerServerEvent("gangmenu:promoteNearby")
end)

RegisterNetEvent("gangmenu:demotePlayer", function()
    TriggerServerEvent("gangmenu:demoteNearby")
end)

RegisterNetEvent("gangmenu:kickPlayer", function()
    TriggerServerEvent("gangmenu:kickNearby")
end)






