local TweenService = game:GetService("TweenService")
local module = {}

function module.TweenTo(player, pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end

    local dist = (hrp.Position - pos).Magnitude
    local tween = TweenService:Create(hrp, TweenInfo.new(dist / 120), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

function module.EquipTool(player, toolName)
    local bp = player:WaitForChild("Backpack")
    local char = player.Character or player.CharacterAdded:Wait()
    if not toolName then return end

    local tool = char:FindFirstChild(toolName) or bp:FindFirstChild(toolName)
    if tool then
        tool.Parent = char
    end
end

function module.AutoQuest(player, mobName)
    local questNpc = workspace:FindFirstChild("QuestNPC")
    if not questNpc then return end

    if player.PlayerGui:FindFirstChild("QuestFrame") then return end

    module.TweenTo(player, questNpc.Position + Vector3.new(0, 3, 0))
    fireclickdetector(questNpc:FindFirstChildOfClass("ClickDetector"))
    task.wait(0.5)
    -- Có thể bổ sung đoạn chọn nhiệm vụ cụ thể sau
end

return module
