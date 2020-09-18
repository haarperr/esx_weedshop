---------------------------------------
--     ESX_WEEDSHOP by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
weedamount = 0
jointamount = 0
registeramount = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if ESX ~= nil then
            ESX.TriggerServerCallback('esx_weedshop:callback:getWeedStorage', function(wamount)
                weedamount = wamount
            end)
            ESX.TriggerServerCallback('esx_weedshop:callback:getJointStorage', function(jamount)
                jointamount = jamount
            end)
            ESX.TriggerServerCallback('esx_weedshop:callback:getRegisterAmount', function(ramount)
                registeramount = ramount
            end)
        end
        Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPed = GetPlayerPed(-1)
        local playerPosition = GetEntityCoords(playerPed)

        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName  then
            -- WEED STORAGE
            if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.job.StorageCheck.x, Config.Weedshop.job.StorageCheck.y, Config.Weedshop.job.StorageCheck.z, true) < 4) then
                DrawText3D(Config.Weedshop.job.StorageCheck.x, Config.Weedshop.job.StorageCheck.y, Config.Weedshop.job.StorageCheck.z+0.15, 'Storage: ~y~' .. weedamount .. '~w~ weed')
            end

            -- JOINT STORAGE + JOINT CRAFTING
            if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.job.CreateJoint.x, Config.Weedshop.job.CreateJoint.y, Config.Weedshop.job.CreateJoint.z, true) < 1.5) then
                DrawText3D(Config.Weedshop.job.CreateJoint.x, Config.Weedshop.job.CreateJoint.y, Config.Weedshop.job.CreateJoint.z+0.28, 'Storage: ~y~' .. jointamount .. '~w~ joints')
                DrawText3D(Config.Weedshop.job.CreateJoint.x, Config.Weedshop.job.CreateJoint.y, Config.Weedshop.job.CreateJoint.z+0.15, '~g~E~w~ - Roll joint')
                if IsControlJustReleased(0, Keys["E"]) then
                    if weedamount > 0 then
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        exports['progressBars']:startUI(5000, "Rolling joint...")
                        Citizen.Wait(5000)
                        TriggerServerEvent('esx_weedshop:server:createJoint')
                        ClearPedTasksImmediately(playerPed)
                    else
                        ESX.ShowNotification('There is not enough weed in the storage...')
                    end
                end
            elseif (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.job.CreateJoint.x, Config.Weedshop.job.CreateJoint.y, Config.Weedshop.job.CreateJoint.z, true) < 4) then
                DrawText3D(Config.Weedshop.job.CreateJoint.x, Config.Weedshop.job.CreateJoint.y, Config.Weedshop.job.CreateJoint.z+0.15, 'Worktable')
            end

            -- REGISTER
            if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.job.Register.x, Config.Weedshop.job.Register.y, Config.Weedshop.job.Register.z, true) < 1.5) then
                DrawText3D(Config.Weedshop.job.Register.x, Config.Weedshop.job.Register.y, Config.Weedshop.job.Register.z+0.28, 'Register: ~g~$' .. registeramount .. '~w~ cash')
                DrawText3D(Config.Weedshop.job.Register.x, Config.Weedshop.job.Register.y, Config.Weedshop.job.Register.z+0.15, '~g~E~w~ - Get cash money')
                if IsControlJustReleased(0, Keys["E"]) then
                    if registeramount > 0 then
                        TriggerServerEvent('esx_weedshop:server:getRegisterMoney', registeramount)
                    else
                        ESX.ShowNotification('There is no money in the register')
                    end
                end
            elseif (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.job.Register.x, Config.Weedshop.job.Register.y, Config.Weedshop.job.Register.z, true) < 4) then
                DrawText3D(Config.Weedshop.job.Register.x, Config.Weedshop.job.Register.y, Config.Weedshop.job.Register.z+0.15, 'Register')
            end
        end -- END JOB MARKERS

        -- COUNTER
        if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z, true) < 5) then
            DrawMarker(2, Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z, true) < 1) then
                DrawText3D(Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z+0.28, 'There are ~g~' .. jointamount .. '~w~ joints left')
                DrawText3D(Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z+0.15, '~g~E~w~ - Buy joint for $' .. Config.JointPrice)
                if IsControlJustReleased(0, Keys["E"]) then
                    if jointamount > 0 then
                        ESX.TriggerServerCallback('esx_weedshop:callback:getPlayerCashMoney', function(amount)
                            if amount >= Config.JointPrice then
                                TriggerServerEvent('esx_weedshop:server:buyJoint', Config.JointPrice)
                            else
                                ESX.ShowNotification('You do not have enough money to buy a joint.')
                            end
                        end)
                    else
                        ESX.ShowNotification('There are no joints left in our storage...')
                    end
                end
            elseif (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z, true) < 4) then
                DrawText3D(Config.Weedshop.player.Counter.x, Config.Weedshop.player.Counter.y, Config.Weedshop.player.Counter.z+0.15, 'Shop')
            end
        end

        -- SELL WEED
        if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z, true) < 5) then
            DrawMarker(2, Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z, true) < 1.5) then
                DrawText3D(Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z+0.15, '~g~E~w~ - Sell weed')
                if IsControlJustReleased(0, Keys["E"]) then
                    ESX.TriggerServerCallback('esx_weedshop:callback:checkPlayerWeed', function(cb)
                        if cb then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(2000, "Selling weed...")
                            Citizen.Wait(2000)
                            TriggerServerEvent('esx_weedshop:server:sellWeed')
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowNotification('You do not have any kind of weed on you...')
                        end
                    end)
                end
            elseif (GetDistanceBetweenCoords(playerPosition, Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z, true) < 4) then
                DrawText3D(Config.Weedshop.player.SellLocation.x, Config.Weedshop.player.SellLocation.y, Config.Weedshop.player.SellLocation.z+0.15, 'Coffeeshop backdoor')
            end
        end
    end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Weedshop.blip.x, Config.Weedshop.blip.y, Config.Weedshop.blip.z)
    SetBlipSprite(blip, 140)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.ShopName)
    EndTextCommandSetBlipName(blip)
end)

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end