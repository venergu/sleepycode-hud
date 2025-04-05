Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle ~= 0 then
            local speed = GetEntitySpeed(vehicle) * 3.6
            local gear = GetVehicleCurrentGear(vehicle)
            local fuel = GetVehicleFuelLevel(vehicle)
            local _, lightsOn, highbeamsOn = GetVehicleLightsState(vehicle)
            local getStateVehicle = (GetVehicleBodyHealth(vehicle) / 10)
            DisplayRadar(true)
            SendNUIMessage({
                action = "openUI",
                speed = math.floor(speed),
                gear = gear,
                fuel = fuel,
                light = lightsOn == 1 or highbeamsOn == 1,
                getStateVehicle = getStateVehicle
            })
        else
            SendNUIMessage({
                action = "closeUI",
            })
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
        local health = (GetEntityHealth(PlayerPedId()) - 100)
        local armor = GetPedArmour(PlayerPedId())
        local talking = NetworkIsPlayerTalking(PlayerId())
        SendNUIMessage({
            action = "updateStatus",
            hunger = hunger,
            thirst = thirst,
            health = health,
            armor = armor,
            talking = talking
        })
    end
end)

function OffHud()
    DisplayHud(false)
    DisplayRadar(false)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    SendNUIMessage({
        action = "openStats"
    })
    OffHud()
end)
