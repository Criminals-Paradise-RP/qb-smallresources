local listening = false
local vehicleClassDisableControl = {
    [0] = true, --compacts
    [1] = true, --sedans
    [2] = true, --SUV's
    [3] = true, --coupes
    [4] = true, --muscle
    [5] = true, --sport classic
    [6] = true, --sport
    [7] = true, --super
    [8] = false, --motorcycle
    [9] = true, --offroad
    [10] = true, --industrial
    [11] = true, --utility
    [12] = true, --vans
    [13] = false, --bicycles
    [14] = false, --boats
    [15] = false, --helicopter
    [16] = false, --plane
    [17] = true, --service
    [18] = true, --emergency
    [19] = false --military
}

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    listening = false
end)

RegisterNetEvent('QBCore:Client:VehicleInfo', function(data)
    if data.event == "Entered" then
        listening = true
        local vehicle = data.vehicle
        local vehicleClass = GetVehicleClass(vehicle)
        if ((data.seat == -1) and (vehicleClassDisableControl[vehicleClass])) then
            CreateThread(function()
                while listening do
                    if IsEntityInAir(vehicle) then
                        DisableControlAction(2, 59)
                        DisableControlAction(2, 60)
                    end
                    Wait(10)
                end
            end)
        end
    else
        listening = false
    end
end)

CreateThread(function()-- DISABLES AIM ASSIST ON CONTROLLERS
    while true do
        Wait(500)-- can set to 0 if needed 
        local gamepad = GetLastInputMethod(2)
        if not gamepad then
           SetPlayerTargetingMode(3)--set targeting to "free-aim" if a controller is being used
        else
            Wait(2000)--wait if the player is using a keyboard
        end
    end
end)

CreateThread(function()
    dynastyBlip = AddBlipForCoord(-703.7, 270.02, 83.15)
    SetBlipSprite(dynastyBlip, 374)
    SetBlipScale(dynastyBlip, 0.8)
    SetBlipDisplay(dynastyBlip, 4)
    SetBlipColour(dynastyBlip, 52)
    SetBlipAsShortRange(dynastyBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Dynasty 8 Real Estate")
    EndTextCommandSetBlipName(dynastyBlip)
end)

CreateThread(function() -- Trains
    SwitchTrainTrack(0, true)
    SwitchTrainTrack(3, true)
    SetTrainTrackSpawnFrequency(0, 2 * 60 * 1000) -- 2 minutes in milliseconds
    SetRandomTrains(1)
      -- turn off/On doors opening
      SetTrainsForceDoorsOpen(false)
  end)
