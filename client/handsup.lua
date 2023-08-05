local QBCore = exports['qb-core']:GetCoreObject()
local animDict = "missminuteman_1ig_2"
local anim = "handsup_base"
local handsup = false
local disableHandsupControls = {24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264}

RegisterCommand('hu', function()
    local ped = PlayerPedId()
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end
    end
        local PlayerData = QBCore.Functions.GetPlayerData()
    if exports['qb-policejob']:IsHandcuffed() or PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
        return
    end
    
    handsup = not handsup
    if handsup then
        TaskPlayAnim(ped, animDict, anim, 2.0, 2.5, -1, 50, 0, false, false, false)
        exports['qb-smallresources']:addDisableControls(disableHandsupControls)
    else
        ClearPedTasks(ped)
        exports['qb-smallresources']:removeDisableControls(disableHandsupControls)
    end
end, false)


RegisterKeyMapping('hu', 'Put your hands up', 'KEYBOARD', 'X')

exports('getHandsup', function() return handsup end)

-- local animDict = "missminuteman_1ig_2"
-- local anim = "handsup_base"
-- local handsup = false

-- RegisterCommand(Config.HandsUp.command, function()
--     local ped = PlayerPedId()
--     if not HasAnimDictLoaded(animDict) then
--         RequestAnimDict(animDict)
--         while not HasAnimDictLoaded(animDict) do
--             Wait(10)
--         end
--     end
--     handsup = not handsup
--     if exports['qb-policejob']:IsHandcuffed() then return end
--     if handsup then
--         TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
--         exports['qb-smallresources']:addDisableControls(Config.disableHandsupControls)
--     else
--         ClearPedTasks(ped)
--         exports['qb-smallresources']:removeDisableControls(Config.disableHandsupControls)
--     end
-- end, false)

-- RegisterKeyMapping(Config.HandsUp.command, 'Hands Up', 'keyboard', Config.HandsUp.keybind)
-- exports('getHandsup', function() return handsup end)
