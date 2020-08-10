
RegisterNetEvent("rFw:PlayerGiveToPlayer")
AddEventHandler("rFw:PlayerGiveToPlayer", function(target, item, count, countsee)
    exports.rFw:ExhangeItem(source, target, item, count, countsee)
end)

RegisterNetEvent("rFw:DropItem")
AddEventHandler("rFw:DropItem", function(item, itemId, count, coords)
    exports.rFw:DropItem(source, item, itemId, count, coords)
end)