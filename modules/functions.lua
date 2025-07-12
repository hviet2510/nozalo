-- functions.lua

local Functions = {}

-- Trang bị tool theo tên
function Functions.EquipTool(player, toolName)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return end

	if typeof(toolName) ~= "string" or toolName == "" then
		warn("[EquipTool] Tên tool không hợp lệ:", toolName)
		return
	end

	for _, tool in pairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower() == toolName:lower() then
			tool.Parent = player.Character
			break
		end
	end
end

-- Tween di chuyển đến vị trí
function Functions.TweenTo(player, position)
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local TweenService = game:GetService("TweenService")
	local tween = TweenService:Create(hrp, TweenInfo.new(0.5), {CFrame = CFrame.new(position)})
	tween:Play()
end

-- Tự động nhận nhiệm vụ theo tên quái
function Functions.AutoQuest(player, enemyName)
	if typeof(enemyName) ~= "string" then
		warn("[AutoQuest] Tên quái không hợp lệ:", enemyName)
		return
	end

	local quests = workspace:FindFirstChild("QuestSystem")
	if not quests then return end

	local quest = quests:FindFirstChild("GetQuest")
	if quest and quest:FindFirstChild(enemyName) then
		local mainClick = quest:FindFirstChild("ClickDetector")
		local subClick = quest[enemyName]:FindFirstChild("ClickDetector")

		if mainClick and subClick then
			fireclickdetector(mainClick)
			task.wait(0.5)
			fireclickdetector(subClick)
		end
	end
end

return Functions
