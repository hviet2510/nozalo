local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local AutoFarm = {
    Active = false,
    Range = 10,
    ToolName = nil
}

function AutoFarm.SetRange(val)
    AutoFarm.Range = tonumber(val) or 10
end

function AutoFarm.SetTool(toolName)
    AutoFarm.ToolName = toolName
end

function AutoFarm.EquipTool()
    local bp = lp:WaitForChild("Backpack")
    local char = lp.Character or lp.CharacterAdded:Wait()
    local tool = bp:FindFirstChild(AutoFarm.ToolName) or char:FindFirstChild(AutoFarm.ToolName)
    if tool then tool.Parent = char end
end

function AutoFarm.TweenTo(pos)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - pos).Magnitude
        local tween = TweenService:Create(hrp, TweenInfo.new(dist / 120), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

function AutoFarm.GetEnemy(list)
    local stats = lp:FindFirstChild("leaderstats")
    local lv = stats and stats:FindFirstChild("Level")
    if not lv then return nil end

    for _, data in pairs(list) do
        if lv.Value >= data.MinLevel and lv.Value <= data.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == data.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end
    return nil
end

function AutoFarm.Toggle(state, list)
    AutoFarm.Active = state
    if not state then return end
    task.spawn(function()
        while AutoFarm.Active do
            local mob = AutoFarm.GetEnemy(list)
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                AutoFarm.EquipTool()
                AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                while AutoFarm.Active and mob.Parent and mob.Humanoid.Health > 0 do
                    local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                    task.wait(0.2)
                end
            else
                task.wait(0.5)
            end
        end
    end)
end

return AutoFarm
