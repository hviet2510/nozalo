local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()

-- Kiểm tra xem cờ bật Auto Farm có đúng không
while task.wait(1.5) do
    if _G.AutoFarmEnabled then
        pcall(function()
            FarmLogic.FarmCurrentLevel()
        end)
    end
end
