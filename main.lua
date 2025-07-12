local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
	Name = "Nozalo Hub",
	Theme = "Default",
	LoadingTitle = "Đang tải...",
	LoadingSubtitle = "Tùy chỉnh giao diện",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Nozalo",
		FileName = "NozaloConfig"
	},
	KeySystem = true,
	KeySettings = {
		Title = "Nozalo",
		Subtitle = "Nhập key",
		Note = "Key nằm trong Discord",
		FileName = "KeyFile",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"nozalo123"}
	}
})

-- 🎨 Theme tab
local ThemeTab = Window:CreateTab("🎨 Theme", 4483362458)

ThemeTab:CreateDropdown({
	Name = "Chọn Giao Diện",
	Options = {
		"Default", "Dark", "Light", "Abyss",
		"Discord", "Red and Black", "Midnight"
	},
	CurrentOption = "Default",
	Callback = function(Theme)
		Rayfield:ChangeTheme(Theme)
	end,
})
