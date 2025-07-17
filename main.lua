-- Bắt đầu log
print("[Main] Bắt đầu khởi chạy...")

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Tải thành công Rayfield UI")

-- Load AutoFarm module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()

-- Tạo cửa sổ chính
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang khởi động...",
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

-- Auto Farm Toggle
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(Value)
		AutoFarm.Toggle(Value)
	end
})

-- Chọn tool từ Backpack
FarmTab:CreateInput({
	Name = "Tên tool muốn dùng",
	PlaceholderText = "Combat, Katana, v.v.",
	RemoveTextAfterFocusLost = true,
	Callback = function(tool)
		AutoFarm.SetTool(tool)
		print("[AutoFarm] Đã chọn tool:", tool)
	end
})

-- Khoảng cách tấn công
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh quái",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(value)
		AutoFarm.SetRange(value)
		print("[AutoFarm] Đặt khoảng cách:", value)
	end
})

print("[Main] UI đã khởi tạo hoàn tất!")
