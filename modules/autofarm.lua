-- 📂 modules/autofarm.lua | Auto Farm Gần Nhất (Cơ Bản)

if _G.AutoFarmStarted then return end
_G.AutoFarmStarted = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local DISTANCE = 5
local SPEED = 250

-- 📌 Tìm quái gần nhất
local function GetClosestEnemy()
	local closest, shortest = nil, math.huge
	for _, enemy in pairs(workspace.Enemies:GetChildren()) do
		if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
			local dist = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
			if dist < shortest then
				shortest = dist
				closest = enemy
			end
		end
	end
	return closest
end

-- 📌 Di chuyển bằng Tween
local function TweenTo(pos)
	local tween = TweenService:Create(
		HumanoidRootPart,
		TweenInfo.new((HumanoidRootPart.Position - pos.Position).Magnitude / SPEED, Enum.EasingStyle.Linear),
		{CFrame = pos}
	)
	tween:Play()
	tween.Completed:Wait()
end

-- 🌀 Vòng lặp auto farm
spawn(function()
	while _G.AutoFarmEnabled and task.wait() do
		local enemy = GetClosestEnemy()
		if enemy and enemy:FindFirstChild("HumanoidRootPart") then
			local targetCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -DISTANCE)
			pcall(function()
				TweenTo(targetCFrame)
				if Character:FindFirstChildOfClass("Tool") then
					Character:FindFirstChildOfClass("Tool"):Activate()
				end
			end)
		end
	end
end)
