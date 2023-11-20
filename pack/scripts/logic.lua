function HasEnoughStars(target)
    local stars = Tracker:ProviderCountForCode("Stars")
    local count = tonumber(target) or Tracker:ProviderCountForCode(target)
    return stars >= count
end