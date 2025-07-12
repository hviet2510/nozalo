print("[Main] Đang khởi động NamerPro UI...")

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Đã tải Rayfield UI")

-- Load AutoFarm module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
print("[Main] Đã tải AutoFarm")

-- Tạo UI
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {Enabled = false},
	Discord = {Enabled = false},
	KeySystem = false
})

-- Tab Farm
local FarmTab = Window:CreateTab("Farm Level", 4483362458)

-- Toggle Auto Farm
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarmEnabled",
	Callback = function(v)
		AutoFarm.Toggle(v)
	end
})

-- Dropdown chọn tool từ túi
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function GetToolList()
	local tools = {}
	for _, item in ipairs(lp.Backpack:GetChildren()) do
		if item:IsA("Tool") then
			table.insert(tools, item.Name)
		end
	end
	return tools
end

FarmTab:CreateDropdown({
	Name = "Chọn Tool để farm",
	Options = GetToolList(),
	CurrentOption = nil,
	Callback = function(selected)
		AutoFarm.SetTool(selected)
	end
})

-- Khoảng cách đánh
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(val)
		AutoFarm.SetRange(val)
	end
})

print("[Main] Giao diện và hệ thống AutoFarm đã sẵn sàng!")
