local Functions = {}

function Functions.EquipTool(player, toolName)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack or typeof(toolName) ~= "string" then return end

	for _, tool in pairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower() == toolName:lower() then
			tool.Parent = player.Character
			break
		end
	end
end

function Functions.TweenToBehind(player, mob, distance)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local mobHRP = mob and mob:FindFirstChild("HumanoidRootPart")
	if not hrp or not mobHRP then return end

	local behindPos = mobHRP.Position - (mobHRP.CFrame.LookVector.Unit * (distance or 10))
	local goal = {CFrame = CFrame.new(behindPos)}
	local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), goal)
	tween:Play()
	tween.Completed:Wait()
end

function Functions.AutoQuest(player, enemyName)
	local quests = workspace:FindFirstChild("QuestSystem")
	if not quests then return end

	local questGiver = quests:FindFirstChild("GetQuest")
	if questGiver and questGiver:FindFirstChild("ClickDetector") then
		fireclickdetector(questGiver.ClickDetector)
		task.wait(0.5)

		local questButton = questGiver:FindFirstChild(enemyName)
		if questButton and questButton:FindFirstChild("ClickDetector") then
			fireclickdetector(questButton.ClickDetector)
		end
	end
end

return Functions
