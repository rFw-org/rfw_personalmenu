
RegisterNetEvent("rFw:PlayerGiveToPlayer")
AddEventHandler("rFw:PlayerGiveToPlayer", function(target, item, count, countsee)
    exports.rFw:ExhangeItem(source, target, item, count, countsee)
end)