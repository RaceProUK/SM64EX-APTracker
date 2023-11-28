EntranceMapper:Reset()

function CanAccess(target)
    if Tracker:FindObjectForCode("EntrancesRandomised").Active then
        local redirected = EntranceMapper[target]
        if redirected == nil then
            return false
        else
            return AccessRules[redirected]()
        end
    else
        return AccessRules[target]()
    end
end

function HasEnoughStars(target)
    local stars = Tracker:ProviderCountForCode("Stars")
    local count = tonumber(target) or Tracker:ProviderCountForCode(target)
    return stars >= count
end

function HasItem(item)
    return Tracker:FindObjectForCode(item).Active
end