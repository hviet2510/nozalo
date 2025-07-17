local Functions = {}

function Functions.EquipTool(player, toolName)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack or typeof(toolName) ~= "string" then return end

	for _, tool in ipairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower() == toolName:lower() then
			tool.Parent = player.Character
			break
		end
	end
end

function Functions.TweenTo(position)
	local char = game.Players.LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local TweenService = game:GetService("TweenService")
	local tween = TweenService:Create(hrp, TweenInfo.new(0.5), {CFrame = CFrame.new(position)})
	tween:Play()
	tween.Completed:Wait()
end

function Functions.StartQuest(questName, levelIndex)
	local npc = workspace:FindFirstChild(questName)
	if not npc then
		warn("[Quest] Không tìm thấy NPC: " .. questName)
		return
	end

	local click = npc:FindFirstChildOfClass("ClickDetector")
	if not click then return end

	fireclickdetector(click)
	task.wait(0.5)

	local gui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("QuestFrame")
	if gui then return end

	-- Giả lập chọn quest theo button
	local button = npc:FindFirstChild(tostring(levelIndex))
	if button and button:IsA("ClickDetector") then
		fireclickdetector(button)
	end
end

return Functions
