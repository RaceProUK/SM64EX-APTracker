ScriptHost:LoadScript("scripts/archipelago/itemMap.lua")
ScriptHost:LoadScript("scripts/archipelago/locationMap.lua")
ScriptHost:LoadScript("scripts/settings.lua")

CurrentIndex = -1

function Reset(slotData)
    Tracker.BulkUpdate = true
    CurrentIndex = -1

    ResetSettings()

    --Auto-tracked Items
    for _, value in pairs(ItemMap) do
        local itemCode = value[1]
        local itemType = value[2]
        if itemCode then
            local item = Tracker:FindObjectForCode(itemCode)
            if item then
                if itemType == "toggle" then
                    item.Active = false
                elseif itemType == "move" then
                    item.Active = true
                elseif itemType == "consumable" then
                    item.AcquiredCount = 0
                end
            end
        end
    end

    --Locations
    for _, value in pairs(LocationMap) do
        local area = value[1]
        local section = value[2]
        local address = "@" .. area .. "/" .. section
        local location = Tracker:FindObjectForCode(address)
        if location then
            location.AvailableChestCount = location.ChestCount
        end
    end

    --Settings
    ParseSettings(slotData)

    Tracker.BulkUpdate = false
end

function ItemReceived(index, id, name, player)
    if index <= CurrentIndex then
        return
    else
        CurrentIndex = index
    end

    if id == ExtraLife then
        --Extra lives can be safely ignored
        return
    elseif id == KeyProgressive then
        --SM64PC handles the progressive key this way too
        local basement = Tracker:FindObjectForCode("KeyBasement")
        local upper = Tracker:FindObjectForCode("KeyUpper")
        if upper and basement then
            upper.Active = basement.Active
            basement.Active = true
        end
    else
        local mapping = ItemMap[id]
        local itemCode = mapping[1]
        local itemType = mapping[2]
        local item = Tracker:FindObjectForCode(itemCode)
        if item then
            if itemType == "toggle" then
                item.Active = true
            elseif itemType == "consumable" then
                item.AcquiredCount = item.AcquiredCount + item.Increment
            end
        end
    end
end

function LocationChecked(id, name)
    local mapping = LocationMap[id]
    if not mapping then
        return
    end

    local area = mapping[1]
    local section = mapping[2]
    local address = "@" .. area .. "/" .. section
    local location = Tracker:FindObjectForCode(address)
    if location then
        location.AvailableChestCount = location.AvailableChestCount - 1
        if area == "Dire Dire Docks" and section == "Board Bowser's Sub" then
            --Despite being a hosted item, it's not updated automatically
            local item = Tracker:FindObjectForCode("SubDeparted1")
            item.Active = true
        end
        if area == "Bowser in the Fire Sea" and section == "Upstairs Key" then
            --Despite being a hosted item, it's not updated automatically
            local item = Tracker:FindObjectForCode("SubDeparted2")
            item.Active = true
        end
    end
end

Archipelago:AddClearHandler("Reset", Reset)
Archipelago:AddItemHandler("Item Received", ItemReceived)
Archipelago:AddLocationHandler("Location Checked", LocationChecked)
