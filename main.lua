local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Nozalo Hub",
    LoadingTitle = "Đang tải...",
    LoadingSubtitle = "Tùy chỉnh giao diện",
    Theme = "Default",
    
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Nozalo",
        FileName = "NozaloConfig"
    },

    KeySystem = false,
    KeySettings = {
        Title = "Nozalo",
        Subtitle = "Nhập key",
        Note = "Key nằm trong Discord",
        FileName = "KeyFile",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = { "nozalo123" }
    }
})

-- Tạo tab Auto Farm
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

FarmTab:CreateToggle({
    Name = "Auto Farm Quái Gần Nhất",
    CurrentValue = false,
    Callback = function(state)
        _G.AutoFarmEnabled = state
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
        end
    end
})

-- (Tùy chọn): Tạo thêm nút reload nếu cần test lại nhanh
FarmTab:CreateButton({
    Name = "Tải lại Farmlogic",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()
    end
})
