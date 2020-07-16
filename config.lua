config = {
    key = "F5", -- Events prefix, i suggest you to change that

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