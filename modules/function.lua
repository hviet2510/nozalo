-- 🎯 functions.lua | Toàn bộ chức năng phụ trợ farm (Quest, Equip, Enemy, Tween)
-- Viết bởi ChatGPT dành cho hub của hviet2510/nozalo

local module = {}

-- 🌐 Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- 📌 Biến toàn cục
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- 🧾 Nhận nhiệm vụ từ NPC có tên chứa "Quest"
function module.AcceptQuest()
	if LocalPlayer.PlayerGui:FindFirstChild("QuestGUI") then return end

	for _, npc in pairs(workspace:GetChildren()) do
		if npc:IsA("Model") and npc:FindFirstChild("Head") and npc.Name:lower():find("quest") then
			local click = npc.Head:FindFirstChildOfClass("ClickDetector")
			if click then
				fireclickdetector(click)
				task.wait(0.5)

				local gui = LocalPlayer.PlayerGui:FindFirstChild("QuestGUI", true)
				if gui and gui:FindFirstChild("Dialogue") then
					local btn = gui.Dialogue:FindFirstChild("Button1")
					if btn then
						local btnClick = btn:FindFirstChildOfClass("ClickDetector")
						if btnClick then fireclickdetector(btnClick) end
					end
				end
			end
			break
		end
	end
end

-- 🛠 Equip vũ khí từ Backpack nếu chưa cầm
function module.EquipTool(toolName)
	if not Character:FindFirstChildOfClass("Tool") then
		local tool = LocalPlayer.Backpack:FindFirstChild(toolName)
		if tool then tool.Parent = Character end
	end
end

-- 👺 Trả về quái gần nhất có thể farm
function module.GetClosestEnemy()
	local closest = nil
	local minDistance = math.huge

	for _, enemy in pairs(workspace.Enemies:GetChildren()) do
		local humanoid = enemy:FindFirstChild("Humanoid")
		local hrp = enemy:FindFirstChild("HumanoidRootPart")

		if humanoid and hrp and humanoid.Health > 0 then
			local distance = (HumanoidRootPart.Position - hrp.Position).Magnitude
			if distance < minDistance then
				minDistance = distance
				closest = enemy
			end
		end
	end

	return closest
end

-- 🚀 Di chuyển đến 1 vị trí bằng Tween mượt
function module.TweenTo(targetCFrame, speed)
	speed = speed or 250
	local distance = (HumanoidRootPart.Position - targetCFrame.Position).Magnitude
	local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
	tween:Play()
	tween.Completed:Wait()
end

-- 🔁 Làm mới biến nhân vật (khi chết / teleport)
function module.RefreshCharacter()
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

return module
