local Functions = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ✅ Danh sách tool an toàn, không gây lỗi
local SafeTools = {
    "Combat", "Black Leg", "Electric", "Sharkman Karate", "Superhuman", "Dragon Breath"
}

-- ⚙️ Tự động trang bị tool nếu có
function Functions.EquipTool()
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    local Character = LocalPlayer.Character
    if not Backpack or not Character then return end

    local selectedTool = _G.SelectedTool or "Combat"
    local foundTool = nil

    for _, tool in pairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == selectedTool then
            foundTool = tool
            break
        end
    end

    -- Nếu không tìm thấy, chuyển sang "Combat"
    if not foundTool then
        warn("[⚠️] Tool không hợp lệ hoặc không tìm thấy:", selectedTool)
        _G.SelectedTool = "Combat"
        for _, tool in pairs(Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Combat" then
                foundTool = tool
                break
            end
        end
    end

    if foundTool and Character:FindFirstChild("Humanoid") then
        Character.Humanoid:EquipTool(foundTool)
        print("[✅] Đã trang bị tool:", foundTool.Name)
    else
        warn("[❌] Không thể trang bị tool.")
    end
end

-- 📌 Kiểm tra tool có an toàn không
function Functions.IsToolSafe(name)
    return table.find(SafeTools, name) ~= nil
end

-- 📥 Nhận nhiệm vụ (gọi từ autofarm)
function Functions.GetQuest(questName)
    local npc = workspace:FindFirstChild(questName)
    if npc and (npc:FindFirstChild("Head") or npc:FindFirstChildOfClass("Part")) then
        pcall(function()
            fireclickdetector(npc:FindFirstChildWhichIsA("ClickDetector"))
        end)
    else
        warn("Không tìm thấy NPC nhận nhiệm vụ:", questName)
    end
end

return Functions
