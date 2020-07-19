config = {
    key = "F5",
    carmileage = true,

    menu = {
        {
            name = "Vehicle options",
            min_perm = 0,
            options = {
                {
                    name = "Open hood",
                    min_perm = 0,
                    action = function()
                        SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 0, true)
                    end,
                },
                {
                    name = "Close hood",
                    min_perm = 0,
                    action = function()
                        SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, true)
                    end,
                },
                {
                    name = "Open trunk",
                    min_perm = 0,
                    action = function()
                        for i = 5,7 do
                            SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), i, 0, true)
                        end
                    end,
                },
                {
                    name = "Close trunk",
                    min_perm = 0,
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
            min_perm = 0,
            options = {
                {
                    name = "Toogle Minimap",
                    min_perm = 0,
                    action = function()
                        if radar == nil then radar = false end
                        DisplayRadar(radar)
                        radar = not radar
                    end,
                },
            },
        },
        {
            name = "Staff options",
            min_perm = 1,
            options = {
                {
                    name = "Test",
                    min_perm = 1,
                    action = function()
                        
                    end,
                },
                {
                    name = "Test",
                    min_perm = 2,
                    action = function()
                        
                    end,
                },
                {
                    name = "Test",
                    min_perm = 3,
                    action = function()
                        
                    end,
                },
                {
                    name = "Test",
                    min_perm = 4,
                    action = function()
                        
                    end,
                },
            },
        },
    },

}