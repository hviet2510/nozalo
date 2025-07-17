-- Log bắt đầu
print("[Main] Bắt đầu khởi chạy NamerPro UI...")

-- Tải Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()
print("[Main] Đã tải Rayfield UI")

-- Tải AutoFarm
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
print("[Main] Đã tải AutoFarm")

-- Lấy LocalPlayer
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tạo cửa sổ
local Window = Rayfield:CreateWindow({
	Name = "NamerPro UI",
	LoadingTitle = "Đang khởi động NamerPro...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false
})

-- Tạo Tab Auto Farm
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Toggle Auto Farm
FarmTab:CreateToggle({
	Name = "Bật Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarmToggle",
	Callback = function(value)
		AutoFarm.Toggle(value)
	end
})

-- Lưu biến dropdown để cập nhật sau
local ToolDropdown = nil

-- Hàm lấy tool từ Backpack
local function GetToolsFromBackpack()
	local tools = {}
	for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			table.insert(tools, tool.Name)
		end
	end
	if #tools == 0 then
		table.insert(tools, "Không có tool")
	end
	return tools
end

-- Tạo Dropdown chọn Tool
ToolDropdown = FarmTab:CreateDropdown({
	Name = "Chọn Tool",
	Options = GetToolsFromBackpack(),
	CurrentOption = nil,
	Flag = "ToolDropdown",
	Callback = function(option)
		if option ~= "Không có tool" then
			AutoFarm.SetTool(option)
			print("[NamerPro] Tool đã chọn: "..option)
		end
	end
})

-- Nút Làm Mới Tool
FarmTab:CreateButton({
	Name = "🔄 Làm Mới Danh Sách Tool",
	Callback = function()
		local newTools = GetToolsFromBackpack()
		ToolDropdown:Refresh(newTools, true)
		print("[NamerPro] Đã làm mới danh sách tool!")
	end
})

-- Slider chỉnh khoảng cách
FarmTab:CreateSlider({
	Name = "Khoảng Cách Đánh",
	Range = {5, 30},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(dist)
		AutoFarm.SetRange(dist)
	end
})

print("[Main] Giao diện đã sẵn sàng!")
