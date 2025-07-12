-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

-- Load các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()

-- Tạo cửa sổ UI
local Window = Rayfield:CreateWindow({
	Name = "NamerPro | Auto Farm",
	LoadingTitle = "Đang tải...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false
})

-- Tab Farm
local FarmTab = Window:CreateTab("⚔️ Farm Level", 4483362458)

-- Auto Farm Toggle
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Chuyển sang dropdown tool
local toolNames = {}
for _, tool in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if tool:IsA("Tool") then
		table.insert(toolNames, tool.Name)
	end
end
if #toolNames == 0 then
	table.insert(toolNames, "Không có tool nào")
end

FarmTab:CreateDropdown({
	Name = "Chọn Tool",
	Options = toolNames,
	CurrentOption = toolNames[1],
	Flag = "ToolDropdown",
	Callback = function(selected)
		if selected ~= "Không có tool nào" then
			AutoFarm.SetTool(selected)
			print("[AutoFarm] Đã chọn tool:", selected)
		end
	end
})

-- Khoảng cách đánh quái
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh quái",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(val)
		AutoFarm.SetRange(val)
	end
})
