config = {
    key = "F5",

    menu = {
        {
            name = "Vehicle options",
            options = {
                {
                    name = "Open hood",
                    action = function()
                        SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 0, true)
                    end,
                },
                {
                    name = "Close hood",
                    action = function()
                        SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, true)
                    end,
                },
                {
                    name = "Open trunk",
                    action = function()
                        for i = 5,7 do
                            SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), i, 0, true)
                        end
                    end,
                },
                {
                    name = "Close trunk",
                    action = function()
                        for i = 5,7 do
                            SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), i, true)
                        end
                    end,
                },
            },
        },
        {
            name = "Divers",
            options = {
                {
                    name = "Toogle Minimap",
                    action = function()
                        if radar == nil then radar = false end
                        DisplayRadar(radar)
                        radar = not radar
                    end,
                },
            },
        },
    },
}