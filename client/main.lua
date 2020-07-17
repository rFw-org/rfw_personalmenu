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
RMenu:Get('personnal', 'inventory').EnableMouse = false
RMenu:Get('personnal', 'inventory').Closed = function()
    -- TODO Perform action
end;

RMenu.Add('personnal', 'inventory_use', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'), "Inventory", "~b~Player inventory"))
RMenu:Get('personnal', 'inventory_use').EnableMouse = false
RMenu:Get('personnal', 'inventory_use').Closed = function()
    -- TODO Perform action
end;

Citizen.CreateThread(function()
    for k,v in pairs(config.menu) do
        RMenu.Add('personnal', v.name, RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'), "Menu", "~b~Player menu"))
        RMenu:Get('personnal', v.name).EnableMouse = false
        RMenu:Get('personnal', v.name).Closed = function()
            -- TODO Perform action
        end;
    end
end)

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
            
                    for k,v in pairs(config.menu) do
                        RageUI.ButtonWithStyle(v.name, nil, { RightLabel = "→" }, true, function(_, _, s)
                        end, RMenu:Get('personnal', v.name))
                    end
                end, function()
                end)

                for k,v in pairs(config.menu) do
                    RageUI.IsVisible(RMenu:Get('personnal', v.name), true, true, true, function()
                        for _,i in pairs(v.options) do
                            RageUI.Button(i.name, nil, true, function(_, _, s)
                                if s then
                                    i.action()
                                end
                            end)
                        end
                    end, function()
                    end)
                end

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

                    RageUI.ButtonWithStyle("Give", nil, { RightLabel = "→" }, true, function(_, h, s)
                        if s then
                            local player, dst = GetClosestPlayer()
                            if player ~= nil and dst < 1.5 then
                                local target = GetPlayerServerId(player)
                                local count = KeyboardAmount()
                                if count ~= nil and count > 0 and count <= selected.count then
                                    TriggerServerEvent("rFw:PlayerGiveToPlayer", target, selected.item, count, selected.count)
                                end
                            else
                                ShowNotification("No near player.")
                            end
                        end
                        if h then
                            DisplayClosetPlayer()
                        end
                    end)

                end, function()
                end)
                Wait(1)
            end
        end)
    end
end