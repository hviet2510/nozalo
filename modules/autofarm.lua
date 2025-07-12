local AutoFarm = {
    Active = false,
    Range = 10,
    ToolName = nil
}

-- Dịch vụ Roblox
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Load các module phụ
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()

-- Cài đặt khoảng cách
function AutoFarm.SetRange(range)
    AutoFarm.Range = tonumber(range) or 10
end

-- Cài đặt tool
function AutoFarm.SetTool(toolName)
    AutoFarm.ToolName = toolName
end

-- Toggle Auto Farm
function AutoFarm.Toggle(state)
    AutoFarm.Active = state
    if not state then return end

    task.spawn(function()
        while AutoFarm.Active do
            local mob = FarmLogic.GetEnemy(lp, EnemyList)

            -- Nếu chưa có mob thì chờ spawn lại
            while AutoFarm.Active and not mob do
                task.wait(1)
                mob = FarmLogic.GetEnemy(lp, EnemyList)
                warn("[AutoFarm] ⏳ Đợi quái xuất hiện...")
            end

            if not mob or not mob:FindFirstChild("HumanoidRootPart") then
                task.wait(0.5)
                continue
            end

            -- Auto Quest
            Functions.AutoQuest(lp, mob.Name)

            -- Tween đến sau lưng mob
            local mobPos = mob.HumanoidRootPart.Position
            local behind = mobPos + (mob.HumanoidRootPart.CFrame.lookVector * -AutoFarm.Range)
            Functions.TweenTo(lp, behind)

            -- Trang bị tool
            Functions.EquipTool(lp, AutoFarm.ToolName)

            -- Đánh quái đến chết
            while AutoFarm.Active and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
                local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
                task.wait(0.2)
            end

            task.wait(0.3) -- đợi lần tiếp theo
        end
    end)
end

return AutoFarm
