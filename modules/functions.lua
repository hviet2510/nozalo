-- functions.lua

local Functions = {}

function Functions.EquipTool(player, toolName)
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    -- Kiểm tra toolName có hợp lệ là chuỗi không
    if typeof(toolName) ~= "string" then
        warn("[EquipTool] ToolName không phải là chuỗi:", toolName)
        return
    end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:lower() == toolName:lower() then
            tool.Parent = player.Character
            break
        end
    end
end

function Functions.TweenTo(player, position)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local TweenService = game:GetService("TweenService")
    local tween = TweenService:Create(hrp, TweenInfo.new(0.5), {CFrame = CFrame.new(position)})
    tween:Play()
end

function Functions.AutoQuest(player, enemyName)
    local quests = workspace:FindFirstChild("QuestSystem")
    if not quests then return end

    local quest = quests:FindFirstChild("GetQuest")
    if quest then
        fireclickdetector(quest.ClickDetector)
        wait(0.5)
        fireclickdetector(quest[enemyName].ClickDetector)
    end
end

return Functions
