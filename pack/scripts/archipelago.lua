ScriptHost:LoadScript("scripts/archipelago/itemMap.lua")
ScriptHost:LoadScript("scripts/archipelago/locationMap.lua")

CurrentIndex = -1

function Reset(slotData)
    CurrentIndex = -1

    --Manually Tracked Items
    EntranceMapper:Reset()
    Tracker:FindObjectForCode("GrandStar").Active = false
    Tracker:FindObjectForCode("MoatDrained").Active = false
    Tracker:FindObjectForCode("SubDeparted1").Active = false
    Tracker:FindObjectForCode("SubDeparted2").Active = false
    Tracker:FindObjectForCode("Star100").Active = true
    Tracker:FindObjectForCode("1UpBoxes").Active = true
    Tracker:FindObjectForCode("Goal").CurrentStage = 0

    --Reset Moves
    Tracker:FindObjectForCode("DoubleJump").Active = true
    Tracker:FindObjectForCode("TripleJump").Active = true
    Tracker:FindObjectForCode("LongJump").Active = true
    Tracker:FindObjectForCode("BackFlip").Active = true
    Tracker:FindObjectForCode("SideFlip").Active = true
    Tracker:FindObjectForCode("WallKick").Active = true
    Tracker:FindObjectForCode("Dive").Active = true
    Tracker:FindObjectForCode("GroundPound").Active = true
    Tracker:FindObjectForCode("Kick").Active = true
    Tracker:FindObjectForCode("Climb").Active = true
    Tracker:FindObjectForCode("LedgeGrab").Active = true

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
    if slotData == nil then
        return
    end
    if slotData["CompletionType"] then
        local setting = Tracker:FindObjectForCode("Goal")
        setting.CurrentStage = slotData["CompletionType"]
    end
    if slotData["AreaRando"] then
        EntranceMapper:Fill(slotData["AreaRando"])
        local setting = Tracker:FindObjectForCode("EntrancesRandomised")
        setting.Active = slotData["AreaRando"] ~= 0
    end
    if slotData["MoveRandoVec"] then
        Tracker:FindObjectForCode("DoubleJump").Active = true --This move is not randomised
        Tracker:FindObjectForCode("TripleJump").Active = slotData["MoveRandoVec"] & 2 ~= 2
        Tracker:FindObjectForCode("LongJump").Active = slotData["MoveRandoVec"] & 4 ~= 2
        Tracker:FindObjectForCode("BackFlip").Active = slotData["MoveRandoVec"] & 8 ~= 2
        Tracker:FindObjectForCode("SideFlip").Active = slotData["MoveRandoVec"] & 16 ~= 2
        Tracker:FindObjectForCode("WallKick").Active = slotData["MoveRandoVec"] & 32 ~= 2
        Tracker:FindObjectForCode("Dive").Active = slotData["MoveRandoVec"] & 64 ~= 2
        Tracker:FindObjectForCode("GroundPound").Active = slotData["MoveRandoVec"] & 128 ~= 2
        Tracker:FindObjectForCode("Kick").Active = slotData["MoveRandoVec"] & 256 ~= 2
        Tracker:FindObjectForCode("Climb").Active = slotData["MoveRandoVec"] & 512 ~= 2
        Tracker:FindObjectForCode("LedgeGrab").Active = slotData["MoveRandoVec"] & 1024 ~= 2
    end
    if slotData["PaintingRando"] then
        local setting = Tracker:FindObjectForCode("PaintingsRandomised")
        setting.Active = slotData["PaintingRando"] ~= 0
    end
    if slotData["DeathLink"] then
        local setting = Tracker:FindObjectForCode("DeathLink")
        setting.Active = slotData["DeathLink"] ~= 0
    end
    if slotData["FirstBowserDoorCost"] then
        local setting = Tracker:FindObjectForCode("StarDoor08")
        setting.AcquiredCount = slotData["FirstBowserDoorCost"]
    end
    if slotData["BasementDoorCost"] then
        local setting = Tracker:FindObjectForCode("StarDoor30")
        setting.AcquiredCount = slotData["BasementDoorCost"]
    end
    if slotData["SecondFloorDoorCost"] then
        local setting = Tracker:FindObjectForCode("StarDoor50")
        setting.AcquiredCount = slotData["SecondFloorDoorCost"]
    end
    if slotData["StarsToFinish"] then
        local setting = Tracker:FindObjectForCode("StarDoor70")
        setting.AcquiredCount = slotData["StarsToFinish"]
    end
    if slotData["MIPS1Cost"] then
        local setting = Tracker:FindObjectForCode("MIPS1")
        setting.AcquiredCount = slotData["MIPS1Cost"]
    end
    if slotData["MIPS2Cost"] then
        local setting = Tracker:FindObjectForCode("MIPS2")
        setting.AcquiredCount = slotData["MIPS2Cost"]
    end
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
