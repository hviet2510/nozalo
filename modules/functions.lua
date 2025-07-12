local Functions = {}

function Functions.EquipTool(player, toolName)
    local char = player.Character
    local bp = player:FindFirstChild("Backpack")
    if not char or not bp then return end

    local tool = (toolName and (char:FindFirstChild(toolName) or bp:FindFirstChild(toolName))) or bp:FindFirstChildOfClass("Tool")
    if tool then tool.Parent = char end
end

function Functions.TweenTo(player, pos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ts = game:GetService("TweenService")
    local tween = ts:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

function Functions.AutoQuest(player, mobName)
    local npc = workspace:FindFirstChild("QuestNPC")
    if not npc then return end
    local gui = player:FindFirstChild("PlayerGui")
    if gui and not gui:FindFirstChild("QuestFrame") then
        Functions.TweenTo(player, npc.Position + Vector3.new(0, 3, 0))
        local cd = npc:FindFirstChildOfClass("ClickDetector")
        if cd then fireclickdetector(cd) end
        task.wait(0.5)
        -- Cần xử lý chọn đúng nhiệm vụ theo tên mob nếu cần
    end
end

return Functions
