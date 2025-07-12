local TweenService = game:GetService("TweenService")

local Functions = {}

function Functions.EquipTool(player, toolName)
	local char = player.Character
	local bp = player.Backpack
	if not char or not bp then return end

	local tool = nil
	if toolName then
		tool = char:FindFirstChild(toolName) or bp:FindFirstChild(toolName)
	else
		tool = char:FindFirstChildOfClass("Tool") or bp:FindFirstChildOfClass("Tool")
	end

	if tool then tool.Parent = char end
end

function Functions.TweenTo(player, pos)
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local distance = (hrp.Position - pos).Magnitude
	local speed = 100
	local time = distance / speed
	local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
	tween:Play()
	tween.Completed:Wait()
end

function Functions.AutoQuest(player, mobName)
	-- Blox Fruits không dùng NPC bình thường để nhận Quest,
	-- bạn có thể bỏ hoặc tự bổ sung nếu game hỗ trợ.
end

return Functions
