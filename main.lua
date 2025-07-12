-- Log bắt đầu
print("[Main] 🔧 Khởi động hệ thống...")

-- Tải UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

-- Tải các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
print("[Main] ✅ Tải AutoFarm thành công!")

-- Tạo giao diện UI
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "By hviet2510",
	ConfigurationSaving = { Enabled = false },
	Discord = { Enabled = false },
	KeySystem = false
})

-- Tạo Tab Farm
local FarmTab = Window:CreateTab("Farm Level", 4483362458)

FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

FarmTab:CreateInput({
	Name = "Tên Tool",
	PlaceholderText = "Tên tool cần dùng",
	RemoveTextAfterFocusLost = true,
	Callback = function(tool)
		AutoFarm.SetTool(tool)
	end
})

FarmTab:CreateSlider({
	Name = "Khoảng cách tấn công",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(distance)
		AutoFarm.SetRange(distance)
	end
})
