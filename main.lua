-- Log khởi động
print("[Main] Đang khởi động NamerPro UI...")

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Đã tải Rayfield UI")

-- Load module chính
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()

-- Gán module phụ cho AutoFarm
AutoFarm.FarmLogic = FarmLogic
AutoFarm.Functions = Functions
AutoFarm.SetEnemyList(EnemyList)

-- Tạo UI Window
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang tải...",
	LoadingSubtitle = "Delta Executor - by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false
})

-- Tạo Tab Farm Level
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
FarmTab:CreateLabel("Farm quái tự động theo level")

-- Toggle bật/tắt Auto Farm
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Chọn Tool dùng để farm
local toolList = {}
for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if tool:IsA("Tool") then
		table.insert(toolList, tool.Name)
	end
end
if #toolList == 0 then table.insert(toolList, "Không có tool") end

FarmTab:CreateDropdown({
	Name = "Chọn Tool",
	Options = toolList,
	CurrentOption = toolList[1],
	Callback = function(value)
		if value ~= "Không có tool" then
			AutoFarm.SetTool(value)
		end
	end
})

-- Chọn khoảng cách đánh
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh quái",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v)
		AutoFarm.SetRange(v)
	end
})

print("[Main] ✅ Giao diện đã sẵn sàng.")
