AccessRules = {
    ["BOB"] = function() return true end,
    ["WF"] = function() return HasEnoughStars(1) end,
    ["JRB"] = function() return HasEnoughStars(3) end,
    ["CCM"] = function() return HasEnoughStars(3) end,
    ["BBH"] = function() return HasEnoughStars(12) end,
    ["HMC"] = function() return HasItem("KeyBasement") end,
    ["LLL"] = function() return HasItem("KeyBasement") end,
    ["SSL"] = function() return HasItem("KeyBasement") end,
    ["DDD"] = function() return HasItem("KeyBasement") and HasEnoughStars("StarDoor30") end,
    ["SL"] = function() return HasItem("KeyUpper") end,
    ["WDW"] = function() return HasItem("KeyUpper") end,
    ["TTM"] = function() return HasItem("KeyUpper") end,
    ["THI Huge"] = function() return HasItem("KeyUpper") end,
    ["THI Tiny"] = function() return HasItem("KeyUpper") end,
    ["TTC"] = function() return HasItem("KeyUpper") and HasEnoughStars("StarDoor50") end,
    ["RR"] = function() return HasItem("KeyUpper") and HasEnoughStars("StarDoor50") end,

    ["PSS"] = function() return HasEnoughStars(1) end,
    ["SA"] = function() return HasEnoughStars(3) end,
    ["WMotR"] = function() return HasItem("KeyUpper") and HasEnoughStars("StarDoor50") end,

    ["CotMC"] = function() return CanAccess("HMC") end,
    ["TotWC"] = function() return HasEnoughStars(10) end,
    ["VCutM"] = function() return HasItem("KeyBasement") and HasItem("MoatDrained") end,

    ["BitDW"] = function() return HasEnoughStars("StarDoor08") end,
    ["BitFS"] = function() return HasItem("KeyBasement") and HasItem("SubDeparted") and HasEnoughStars("StarDoor30") end,
}