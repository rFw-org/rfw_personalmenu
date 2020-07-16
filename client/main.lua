local MenuOpen = false
local playerInventory = {}
local selected = {
    item = nil,
    count = nil,
}

RegisterKeyMapping("open", "Open player menu", 'keyboard', config.key)
RegisterCommand("open", function()
    OpenPersonnalMenu()
end, false)

RMenu.Add('personnal', 'main', RageUI.CreateMenu("Personnal", ""))
RMenu:Get('personnal', 'main'):SetSubtitle("~b~Mechanic action menu")
RMenu:Get('personnal', 'main').EnableMouse = false
RMenu:Get('personnal', 'main').Closed = function()
    MenuOpen = false
end;

RMenu.Add('personnal', 'inventory', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'), "Inventory", "~b~Player inventory"))
RMenu:Get('personnal', 'inventory').EnableMouse = true
RMenu:Get('personnal', 'inventory').Closed = function()
    -- TODO Perform action
end;

RMenu.Add('personnal', 'inventory_use', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'), "Inventory", "~b~Player inventory"))
RMenu:Get('personnal', 'inventory_use').EnableMouse = true
RMenu:Get('personnal', 'inventory_use').Closed = function()
    -- TODO Perform action
end;

function OpenPersonnalMenu()
    if MenuOpen then
        MenuOpen = false
        return
    else
        MenuOpen = true
        RageUI.Visible(RMenu:Get('personnal', 'main'), true)
        Citizen.CreateThread(function()
            while MenuOpen do
                RageUI.IsVisible(RMenu:Get('personnal', 'main'), true, true, true, function()
                    RageUI.ButtonWithStyle("Inventaire", nil, { RightLabel = "→" }, true, function(_, _, s)
                        if s then
                            playerInventory = exports.rFw:GetPlayerInv()
                        end 
                    end, RMenu:Get('personnal', 'inventory'))
            
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('personnal', 'inventory'), true, true, true, function()
                    for k,v in pairs(playerInventory) do
                        RageUI.ButtonWithStyle(v.label, nil, { RightLabel = "~b~"..v.count.."→" }, true, function(_, _, s)
                            if s then
                                selected.item = k
                                selected.count = v.count
                            end
                        end, RMenu:Get('personnal', 'inventory_use'))
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('personnal', 'inventory_use'), true, true, true, function()

                    RageUI.ButtonWithStyle("Use", nil, { RightLabel = "→" }, true, function(_, _, s)
                        if s then
                            exports.rFw:UseItem(selected.item)
                        end
                    end)

                    RageUI.ButtonWithStyle("Give", nil, { RightLabel = "→" }, true, function(_, _, s)
                    end)

                end, function()
                end)
                Wait(1)
            end
        end)
    end
end