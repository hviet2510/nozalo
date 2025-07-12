local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Logic = {}
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()

function Logic.GetMobNameByLevel()
    local level = LocalPlayer.Data.Level.Value
    for _, enemy in pairs(EnemyList) do
        if level >= enemy.LevelRequired and level <= enemy.LevelMax then
            return enemy
        end
    end
    return nil
end

function Logic.GetNearestMob(name)
    local mobs = workspace.Enemies:GetChildren()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local nearest, distance = nil, math.huge

    for _, mob in pairs(mobs) do
        if mob.Name == name and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
            local dist = (mob.HumanoidRootPart.Position - root.Position).Magnitude
            if dist < distance then
                nearest = mob
                distance = dist
            end
        end
    end
    return nearest
end

function Logic.TweenTo(pos)
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local tween = TweenService:Create(root, TweenInfo.new(0.5), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

function Logic.Attack(mob)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

function Logic.FarmMob(enemy)
    Functions.StartQuest(enemy)
    Functions.EquipTool()
    task.wait(0.3)

    local mob = Logic.GetNearestMob(enemy.Name)
    if not mob then
        Logic.TweenTo(enemy.Position)
        task.wait(1)
        mob = Logic.GetNearestMob(enemy.Name)
    end

    if mob then
        Logic.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        repeat
            Logic.Attack(mob)
            task.wait(0.2)
        until not mob or not mob.Parent or mob.Humanoid.Health <= 0
    end
end

function Logic.FarmMobByLevel()
    local enemy = Logic.GetMobNameByLevel()
    if enemy then
        Logic.FarmMob(enemy)
    end
end

return Logic
