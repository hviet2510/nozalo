-- 🌟 main.lua | Khởi động toàn bộ hệ thống UI và AutoFarm theo Level
-- Repo: hviet2510/nozalo

-- ⚙️ Biến toàn cục
_G.AutoFarmEnabled = false
_G.SelectedTool = "Combat"

-- 📦 Tải Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/Rayfield.lua"))()

-- 🧱 Tạo cửa sổ giao diện
local Window = Rayfield:CreateWindow({
   Name = "Nozalo Hub | Blox Fruits",
   LoadingTitle = "Nozalo Hub đang khởi động...",
   LoadingSubtitle = "by hviet2510",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NozaloHub",
      FileName = "BloxFruitsSettings"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

-- 📁 Tab chính AutoFarm
local Tab = Window:CreateTab("Auto Farm", 4483362458)

-- 📍 Section
local Section = Tab:CreateSection("Tùy chọn")

-- 🔘 Toggle bật/tắt farm
Tab:CreateToggle({
   Name = "Bật Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(value)
      _G.AutoFarmEnabled = value
      if value then
         Rayfield:Notify({
            Title = "AutoFarm",
            Content = "Đang bật hệ thống Auto Farm!",
            Duration = 4
         })
         -- 🔄 Gọi autofarm
         loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/autofarm.lua"))()
      else
         Rayfield:Notify({
            Title = "AutoFarm",
            Content = "Đã tắt hệ thống Auto Farm!",
            Duration = 4
         })
      end
   end,
})

-- 🎒 Danh sách vũ khí
local toolList = {}

for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
   if tool:IsA("Tool") then
      table.insert(toolList, tool.Name)
   end
end

-- 🔽 Dropdown chọn tool
Tab:CreateDropdown({
   Name = "Chọn Vũ Khí",
   Options = toolList,
   CurrentOption = _G.SelectedTool,
   Callback = function(option)
      _G.SelectedTool = option
      Rayfield:Notify({
         Title = "Vũ Khí",
         Content = "Đã chọn: " .. option,
         Duration = 3
      })
   end
})

-- ✅ Thông báo khi load xong
Rayfield:Notify({
   Title = "Nozalo Hub",
   Content = "Đã khởi động thành công!",
   Duration = 5
})
