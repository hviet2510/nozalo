local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/compkillerlib.lua"))()

local win = lib:CreateWindow("Nozalo UI")
local tab = win:CreateTab("Main")

tab:AddButton("Kill All", function()
    print("Kill all executed")
end)

tab:AddToggle("Auto Kill", false, function(state)
    print("Auto Kill:", state)
end)

tab:AddDropdown("Weapon", {"Sword", "Gun", "Melee"}, function(option)
    print("Selected weapon:", option)
end)

tab:AddSlider("Power", 1, 10, 5, function(value)
    print("Power set to:", value)
end)

tab:AddInputBox("Custom Name", "Type name...", function(text)
    print("You typed:", text)
end)
