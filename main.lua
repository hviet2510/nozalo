-- main.lua - Gọi thư viện UI chuyên nghiệp từ repo hviet2510/nozalo

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/refs/heads/main/compkillerlib.lua"))()

local window = ui:CreateWindow("⚔️ Nozalo UI - 5★ Pro")

local tab = window:CreateTab("Main")

-- Button
tab:AddButton("🔥 Kill All", function()
    print("[Nozalo] Kill All activated")
end)

-- Toggle
tab:AddToggle("☠️ Auto Kill", false, function(state)
    print("[Nozalo] Auto Kill:", state)
end)

-- Dropdown
tab:AddDropdown("⚔️ Weapon", {"Katana", "Gun", "Dark Blade", "Electric Claw"}, function(selected)
    print("[Nozalo] Selected weapon:", selected)
end)

-- Slider
tab:AddSlider("💥 Power", 1, 10, 5, function(value)
    print("[Nozalo] Power level set to:", value)
end)

-- Input Box
tab:AddInputBox("🔤 Enter Target Name", "Ex: Bandit", function(text)
    print("[Nozalo] Target:", text)
end)
