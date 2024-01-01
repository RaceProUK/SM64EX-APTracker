--Key: Vanilla entrance
--Value: Randomised entrance
EntranceMapper = {}

--Key: SM64PC internal ID
--Value: Tracker's internal name and stage
EntranceMapper["EntranceIDMap"] = {
    ["91"] = { "BOB", 1 },
    ["241"] = { "WF", 2 },
    ["121"] = { "JRB", 3 },
    ["51"] = { "CCM", 4 },
    ["41"] = { "BBH", 5 },
    ["71"] = { "HMC", 6 },
    ["221"] = { "LLL", 7 },
    ["81"] = { "SSL", 8 },
    ["231"] = { "DDD", 9 },
    ["101"] = { "SL", 10 },
    ["111"] = { "WDW", 11 },
    ["361"] = { "TTM", 12 },
    ["131"] = { "THIHuge", 13 },
    ["132"] = { "THITiny", 14 },
    ["141"] = { "TTC", 15 },
    ["151"] = { "RR", 16 },

    ["271"] = { "PSS", 17 },
    ["201"] = { "SA", 18 },
    ["311"] = { "WMotR", 19 },

    ["281"] = { "CotMC", 21 },
    ["291"] = { "TotWC", 20 },
    ["181"] = { "VCutM", 22 },

    ["171"] = { "BitDW", 23 },
    ["191"] = { "BitFS", 24 }
}

function EntranceMapper:Fill(areaMap)
    for key, value in pairs(areaMap) do
        local entrance = EntranceMapper["EntranceIDMap"][key][1]
        local course = EntranceMapper["EntranceIDMap"][tostring(value)][1]
        --AP uses entrance => course
        --But we need course => entrance
        EntranceMapper[course] = entrance

        --Update Entrance Tracker
        local level = Tracker:FindObjectForCode("Level" .. entrance)
        local stage = EntranceMapper["EntranceIDMap"][tostring(value)][2]
        level.CurrentStage = stage
    end
end

function EntranceMapper:Reset()
    EntranceMapper["BOB"] = nil
    EntranceMapper["WF"] = nil
    EntranceMapper["JRB"] = nil
    EntranceMapper["CCM"] = nil
    EntranceMapper["BBH"] = nil
    EntranceMapper["HMC"] = nil
    EntranceMapper["LLL"] = nil
    EntranceMapper["SSL"] = nil
    EntranceMapper["DDD"] = nil
    EntranceMapper["SL"] = nil
    EntranceMapper["WDW"] = nil
    EntranceMapper["TTM"] = nil
    EntranceMapper["THIHuge"] = nil
    EntranceMapper["THITiny"] = nil
    EntranceMapper["TTC"] = nil
    EntranceMapper["RR"] = nil
    EntranceMapper["PSS"] = nil
    EntranceMapper["SA"] = nil
    EntranceMapper["WMotR"] = nil
    EntranceMapper["CotMC"] = nil
    EntranceMapper["TotWC"] = nil
    EntranceMapper["VCutM"] = nil
    EntranceMapper["BitDW"] = nil
    EntranceMapper["BitFS"] = nil
end