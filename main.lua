-- main.lua | Full UI Test | dùng Rayfield tự host (hviet2510/nozalo)

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
	Name = "⚙️ Nozalo UI Full Test",
	LoadingTitle = "Loading Interface...",
	LoadingSubtitle = "Powered by Rayfield UI",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Nozalo", -- Lưu config vào folder này
		FileName = "config"    -- Tên file config
	},
	KeySystem = false, -- Đặt true nếu muốn dùng key để mở UI
})

local Tab = Window:CreateTab("Main", 4483362458)

-- 🔘 BUTTON
Tab:CreateButton({
	Name = "Kill All",
	Callback = function()
		Rayfield:Notify({
			Title = "Info",
			Content = "Kill All Executed!",
			Duration = 3,
		})
	end,
})

-- ✅ TOGGLE
Tab:CreateToggle({
	Name = "Auto Kill",
	CurrentValue = false,
	Callback = function(Value)
		print("AutoKill:", Value)
	end,
})

-- ⬇️ DROPDOWN
Tab:CreateDropdown({
	Name = "Weapon",
	Options = {"Katana", "Claw", "Gun", "Dark Blade"},
	CurrentOption = "Katana",
	Callback = function(Value)
		print("Selected Weapon:", Value)
	end,
})

-- 🎚 SLIDER
Tab:CreateSlider({
	Name = "Power Level",
	Range = {1, 10},
	Increment = 1,
	CurrentValue = 5,
	Callback = function(Value)
		print("Power:", Value)
	end,
})

-- 🔤 INPUT BOX
Tab:CreateInput({
	Name = "Target Name",
	PlaceholderText = "Ex: Bandit",
	RemoveTextAfterFocusLost = true,
	Callback = function(Text)
		print("Target:", Text)
	end,
})

-- ⌨️ KEYBIND
Tab:CreateKeybind({
	Name = "Kill Key",
	CurrentKeybind = "F",
	HoldToInteract = false,
	Callback = function()
		print("Keybind Pressed")
	end,
})

-- 🧪 SECTION TEST
local Section = Tab:CreateSection("Advanced")

-- 📢 NOTIFY TEST
Tab:CreateButton({
	Name = "Notify Me",
	Callback = function()
		Rayfield:Notify({
			Title = "Notification",
			Content = "This is a Rayfield-style notify!",
			Duration = 4,
		})
	end,
})
