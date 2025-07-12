local TweenService = game:GetService("TweenService")

local Functions = {}

function Functions.EquipTool(player, toolName)
	local char = player.Character
	local bp = player:FindFirstChild("Backpack")
	if not char or not bp then return end

	local tool = nil
	if toolName then
		tool = char:FindFirstChild(toolName) or bp:FindFirstChild(toolName)
	else
		tool = char:FindFirstChildOfClass("Tool") or bp:FindFirstChildOfClass("Tool")
	end

	if tool then
		tool.Parent = char
	end
end

function Functions.TweenTo(player, pos)
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local distance = (hrp.Position - pos).Magnitude
	local tweenTime = distance / 100
	local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
	tween:Play()
	tween.Completed:Wait()
end

function Functions.AutoQuest(player, mobName)
	-- Blox Fruits không có quest NPC chung -> có thể bỏ nếu không áp dụng được
end

return Functions
