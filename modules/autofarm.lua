-- 🌾 AutoFarm | Phiên bản VIP chuẩn Hub trả phí (chỉ dành cho khách dùng Rayfield và repo module hóa)

if _G.AutoFarmStarted then return end
_G.AutoFarmStarted = true

-- 📦 Load module hỗ trợ
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- ⚙️ Cấu hình mặc định
local TOOL_NAME = _G.SelectedTool or "Combat"
local DISTANCE_BEHIND = 5
local TWEEN_SPEED = 250

-- 🔁 Vòng lặp farm
task.spawn(function()
	while _G.AutoFarmEnabled do
		task.wait(0.1)
		pcall(function()
			-- Làm mới nhân vật nếu chết
			if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then
				Functions.RefreshCharacter()
				return
			end

			-- Nhận nhiệm vụ nếu chưa có
			Functions.AcceptQuest()

			-- Tìm quái gần nhất để farm
			local enemy = Functions.GetClosestEnemy()
			if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
				-- Di chuyển ra sau quái
				local target = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -DISTANCE_BEHIND)
				Functions.TweenTo(target, TWEEN_SPEED)

				-- Cầm vũ khí
				Functions.EquipTool(TOOL_NAME)

				-- Tấn công nếu có tool
				local tool = LP.Character:FindFirstChildOfClass("Tool")
				if tool then tool:Activate() end
			end
		end)
	end
end)
