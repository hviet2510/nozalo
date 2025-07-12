-- Log bắt đầu
print("[Main] Bắt đầu khởi chạy...")

-- Tải Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Tải thành công Rayfield UI")

-- Tải các module farm
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
print("[Main] Tải thành công AutoFarm & EnemyList")

-- Tạo cửa sổ UI
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Khởi động NamerPro...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false
})

-- Tạo Tab Farm Level
local FarmTab = Window:CreateTab("Farm Level", 4483362458)

-- Tạo Auto Farm Toggle
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(Value)
		AutoFarm.Toggle(Value)
	end
})

-- (Tuỳ chọn) Set tool khi farm
FarmTab:CreateInput({
	Name = "Tên Tool muốn dùng",
	PlaceholderText = "Melee / Kiếm / Vũ khí...",
	RemoveTextAfterFocusLost = true,
	Callback = function(text)
		AutoFarm.SetTool(text)
	end
})

-- (Tuỳ chọn) Khoảng cách đánh
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh quái",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v)
		AutoFarm.SetRange(v)
	end
})

print("[Main] Hoàn tất khởi tạo UI và hệ thống Auto Farm!")
