--Key: Vanilla entrance
--Value: Randomised entrance
EntranceMapper = {}

--Key: SM64PC internal ID
--Value: Tracker's internal name
EntranceMapper["EntranceIDMap"] = {
    ["91"] = "BOB",
    ["241"] = "WF",
    ["121"] = "JRB",
    ["51"] = "CCM",
    ["41"] = "BBH",
    ["71"] = "HMC",
    ["221"] = "LLL",
    ["81"] = "SSL",
    ["231"] = "DDD",
    ["101"] = "SL",
    ["111"] = "WDW",
    ["361"] = "TTM",
    ["131"] = "THI Huge",
    ["132"] = "THI Tiny",
    ["141"] = "TTC",
    ["151"] = "RR",

    ["271"] = "PSS",
    ["201"] = "SA",
    ["311"] = "WMotR",

    ["281"] = "CotMC",
    ["291"] = "TotWC",
    ["181"] = "VCutM",

    ["171"] = "BitDW",
    ["191"] = "BitFS"
}

function EntranceMapper:Fill(areaMap)
    for key, value in pairs(areaMap) do
        local entrance = EntranceMapper["EntranceIDMap"][key]
        local course = EntranceMapper["EntranceIDMap"][tostring(value)]
        EntranceMapper[entrance] = course
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
    EntranceMapper["THI Huge"] = nil
    EntranceMapper["THI Tiny"] = nil
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