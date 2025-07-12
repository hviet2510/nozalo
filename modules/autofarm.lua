-- 🌾 AutoFarm by Level (Không dùng enemylist, dùng farmlogic.lua)

if _G.AutoFarmStarted then return end
_G.AutoFarmStarted = true

local funcs = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()
local logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local TOOL = _G.SelectedTool or "Combat"

task.spawn(function()
	while _G.AutoFarmEnabled do
		task.wait(0.2)
		pcall(function()
			funcs.RefreshCharacter()

			local data = logic.GetTargetEnemy()
			if not data then warn("⚠️ Không có dữ liệu quái cho Level này.") return end

			-- Tự nhận quest
			if not LP.PlayerGui:FindFirstChild("QuestGUI") then
				funcs.TweenTo(data.QuestPos)
				fireclickdetector(workspace:FindFirstChild(data.QuestName, true).Head:FindFirstChildOfClass("ClickDetector"))
				task.wait(0.5)
				-- Auto click quest 1
				local gui = LP.PlayerGui:FindFirstChild("QuestGUI", true)
				if gui and gui:FindFirstChild("Dialogue") then
					local btn = gui.Dialogue:FindFirstChild("Button1")
					if btn then fireclickdetector(btn:FindFirstChildOfClass("ClickDetector")) end
				end
			end

			-- Tìm enemy đúng loại
			for _, mob in pairs(workspace.Enemies:GetChildren()) do
				if mob.Name == data.QuestMob and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
					local target = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
					funcs.TweenTo(target, 250)
					funcs.EquipTool(TOOL)
					local tool = LP.Character:FindFirstChildOfClass("Tool")
					if tool then tool:Activate() end
					break
				end
			end
		end)
	end
end)
