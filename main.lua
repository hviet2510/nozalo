-- main.lua for Nozalo | using Rayfield UI Library

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
	Name = "⚔️ Nozalo Hub",
	LoadingTitle = "Nozalo is loading...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Nozalo", -- Tên folder lưu config
		FileName = "NozaloConfig"
	},
	KeySystem = false, -- Bật nếu muốn key
})

local Tab = Window:CreateTab("Main", 4483362458) -- ID là icon (hoặc nil nếu không có)

-- 🔘 Toggle
Tab:CreateToggle({
	Name = "Auto Kill",
	CurrentValue = false,
	Callback = function(Value)
		print("AutoKill status:", Value)
	end,
})

-- 🔘 Button
Tab:CreateButton({
	Name = "Kill All",
	Callback = function()
		print("Kill All!")
	end,
})

-- 🔘 Dropdown
Tab:CreateDropdown({
	Name = "Select Weapon",
	Options = {"Katana", "Gun", "Claw", "Dark Blade"},
	CurrentOption = "Katana",
	Callback = function(Value)
		print("Selected:", Value)
	end,
})

-- 🔘 Slider
Tab:CreateSlider({
	Name = "Power Level",
	Range = {1, 10},
	Increment = 1,
	CurrentValue = 3,
	Callback = function(Value)
		print("Power:", Value)
	end,
})

-- 🔘 Input Box
Tab:CreateInput({
	Name = "Target Name",
	PlaceholderText = "Ex: Bandit",
	RemoveTextAfterFocusLost = true,
	Callback = function(Value)
		print("Target:", Value)
	end,
})
