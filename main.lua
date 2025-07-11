-- main.lua - Dùng cho Nozalo UI (hviet2510/nozalo)

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/compkillerlib.lua"))()

local win = ui:CreateWindow("⚔️ Nozalo UI - Pro")

-- Add các control
win:AddButton("🔥 Kill All", function()
    print("Kill All executed!")
end)

win:AddToggle("☠️ Auto Kill", false, function(state)
    print("Auto Kill:", state)
end)

win:AddDropdown("⚔️ Weapon", {"Katana", "Gun", "Dark Blade", "Claw"}, function(selected)
    print("Selected weapon:", selected)
end)

win:AddSlider("💥 Power", 1, 10, 3, function(value)
    print("Power level:", value)
end)

win:AddInputBox("🎯 Target", "Ex: Bandit", function(text)
    print("Input Target:", text)
end)

-- 🔘 Nút/phím bật tắt UI
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightControl then
		win:SetVisible(not win._gui.Enabled)
	end
end)

-- 🔘 Nút góc màn hình để bật/tắt UI
local toggleBtnGui = Instance.new("ScreenGui", game.CoreGui)
toggleBtnGui.Name = "Nozalo_ToggleBtn"
toggleBtnGui.ResetOnSpawn = false

local btn = Instance.new("TextButton", toggleBtnGui)
btn.Size = UDim2.new(0, 120, 0, 40)
btn.Position = UDim2.new(1, -130, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.Text = "👁 Toggle UI"
btn.TextSize = 14
btn.ZIndex = 999

local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(0, 8)

btn.MouseButton1Click:Connect(function()
	win:SetVisible(not win._gui.Enabled)
end)
