-- main.lua
print("[Main] Đang khởi động NamerPro UI...")

-- Tải UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Đã tải Rayfield UI")

-- Tải module AutoFarm (AutoFarm sẽ tự load các phụ thuộc bên trong)
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
print("[Main] Đã tải AutoFarm")

-- Tạo cửa sổ
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {Enabled = false},
	KeySystem = false
})

-- Tab Farm
local FarmTab = Window:CreateTab("Farm Level", 4483362458)

-- Toggle Auto Farm
FarmTab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(Value)
		AutoFarm.Toggle(Value)
	end
})

-- Dropdown chọn tool
FarmTab:CreateInput({
	Name = "Tên Tool",
	PlaceholderText = "Ví dụ: Combat, Katana...",
	RemoveTextAfterFocusLost = true,
	Callback = function(text)
		AutoFarm.SetTool(text)
	end
})

-- Khoảng cách đánh
FarmTab:CreateSlider({
	Name = "Khoảng cách đánh",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v)
		AutoFarm.SetRange(v)
	end
})

print("[Main] Giao diện và hệ thống AutoFarm đã sẵn sàng!")
