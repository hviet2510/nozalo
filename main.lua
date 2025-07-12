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

local Tab = Window:CreateTab("⚔️ AutoFarm", 4483362458)

Tab:CreateToggle({
	Name = "Auto Farm Quái Gần Nhất",
	CurrentValue = false,
	Callback = function(state)
		_G.AutoFarmEnabled = state
		if state then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
		end
	end,
})
