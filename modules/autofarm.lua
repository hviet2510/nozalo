-- modules/autofarm_nearest.lua | Auto Farm Quái Gần Nhất (Update Mạnh)
if _G.AutoFarmThread then return end
_G.AutoFarmEnabled = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ⚙️ Cài đặt
local DISTANCE = 5      -- Khoảng cách giữ với quái
local SPEED = 200       -- Tốc độ bay Tween

-- 🔍 Tìm quái gần nhất
local function GetNearestEnemy()
	local closest, shortest = nil, math.huge
	for _, enemy in pairs(workspace.Enemies:GetChildren()) do
		if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
			local dist = (RootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
			if enemy.Humanoid.Health > 0 and dist < shortest then
				shortest = dist
				closest = enemy
			end
		end
	end
	return closest
end

-- 🚀 Tween đến vị trí
local function TweenTo(targetCFrame)
	local tween = TweenService:Create(
		RootPart,
		TweenInfo.new((RootPart.Position - targetCFrame.Position).Magnitude / SPEED, Enum.EasingStyle.Linear),
		{CFrame = targetCFrame}
	)
	tween:Play()
	tween.Completed:Wait()
end

-- 🌀 Vòng lặp farm
_G.AutoFarmThread = task.spawn(function()
	while _G.AutoFarmEnabled and task.wait() do
		local enemy = GetNearestEnemy()
		if enemy then
			local eHRP = enemy:FindFirstChild("HumanoidRootPart")
			if eHRP then
				pcall(function()
					local targetPos = eHRP.CFrame * CFrame.new(0, 0, -DISTANCE)
					TweenTo(targetPos)
					if Character:FindFirstChildOfClass("Tool") then
						Character:FindFirstChildOfClass("Tool"):Activate()
					end
				end)
			end
		end
	end
end)
