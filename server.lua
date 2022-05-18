local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetCurrentPlayers', function(_, cb)
    local TotalPlayers = 0
    for _ in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetActivity', function(_, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            PoliceCount = PoliceCount + 1
        end

        if v.PlayerData.job.name == "ambulance" and v.PlayerData.job.onduty then
            AmbulanceCount = AmbulanceCount + 1
        end
    end
    cb(PoliceCount, AmbulanceCount)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetConfig', function(_, cb)
    cb(Config.IllegalActions)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetPlayersArrays', function(_, cb)
    local players = {}
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        players[v.PlayerData.source] = {}
        players[v.PlayerData.source].permission = QBCore.Functions.IsOptin(v.PlayerData.source)
    end
    cb(players)
end)

RegisterNetEvent('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)