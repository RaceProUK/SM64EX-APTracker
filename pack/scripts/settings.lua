function ResetSettings()
    EntranceMapper:Reset()

    --Manually Tracked Items
    Tracker:FindObjectForCode("GrandStar").Active = false
    Tracker:FindObjectForCode("MoatDrained").Active = false
    Tracker:FindObjectForCode("SubDeparted1").Active = false
    Tracker:FindObjectForCode("SubDeparted2").Active = false
    Tracker:FindObjectForCode("Star100").Active = true
    Tracker:FindObjectForCode("1UpBoxes").Active = true
    Tracker:FindObjectForCode("Goal").CurrentStage = 0

    --Reset Paintings
    Tracker:FindObjectForCode("PaintingWF").Active = true
    Tracker:FindObjectForCode("PaintingJRB").Active = true
    Tracker:FindObjectForCode("PaintingCCM").Active = true
    Tracker:FindObjectForCode("PaintingLLL").Active = true
    Tracker:FindObjectForCode("PaintingSSL").Active = true
    Tracker:FindObjectForCode("PaintingDDD").Active = true
    Tracker:FindObjectForCode("PaintingSL").Active = true
    Tracker:FindObjectForCode("PaintingWDW").Active = true
    Tracker:FindObjectForCode("PaintingTTM").Active = true
    Tracker:FindObjectForCode("PaintingTHI").Active = true
    Tracker:FindObjectForCode("PaintingTTC").Active = true

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
end

function ParseSettings(slotData)
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
        Tracker:FindObjectForCode("LongJump").Active = slotData["MoveRandoVec"] & 4 ~= 4
        Tracker:FindObjectForCode("BackFlip").Active = slotData["MoveRandoVec"] & 8 ~= 8
        Tracker:FindObjectForCode("SideFlip").Active = slotData["MoveRandoVec"] & 16 ~= 16
        Tracker:FindObjectForCode("WallKick").Active = slotData["MoveRandoVec"] & 32 ~= 32
        Tracker:FindObjectForCode("Dive").Active = slotData["MoveRandoVec"] & 64 ~= 64
        Tracker:FindObjectForCode("GroundPound").Active = slotData["MoveRandoVec"] & 128 ~= 128
        Tracker:FindObjectForCode("Kick").Active = slotData["MoveRandoVec"] & 256 ~= 256
        Tracker:FindObjectForCode("Climb").Active = slotData["MoveRandoVec"] & 512 ~= 512
        Tracker:FindObjectForCode("LedgeGrab").Active = slotData["MoveRandoVec"] & 1024 ~= 1024
    end
    if slotData["PaintingRando"] then
        local setting = Tracker:FindObjectForCode("PaintingsRandomised")
        setting.Active = slotData["PaintingRando"] ~= 0
        Tracker:FindObjectForCode("PaintingWF").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingJRB").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingCCM").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingLLL").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingSSL").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingDDD").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingSL").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingWDW").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingTTM").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingTHI").Active = slotData["PaintingRando"] == 0
        Tracker:FindObjectForCode("PaintingTTC").Active = slotData["PaintingRando"] == 0
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
