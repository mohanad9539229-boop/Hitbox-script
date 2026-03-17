-- [[ المبرمج: سلاكس | قناة: Ezz.i1 ]]
-- [[ تم التشفير بواسطة slax  ]]

local _0x536c6178 = "سلاكس"
local _0x457a7a = "Ezz.i1"

local function _0x52756e(_0x4c7561)
    local _0x62 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return (_0x4c7561:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
        return _0x62:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#_0x4c7561 % 3 + 1])
end

-- الكود المشفر بالكامل (Base64 + التمويه المنطقي)
local _0x5061796c6f6164 = function()
    local L_1_ = game:GetService("Players")
    local L_2_ = game:GetService("RunService")
    local L_3_ = game:GetService("TweenService")
    local L_4_ = L_1_.LocalPlayer
    _G.HeadSize = 10
    _G.Disabled = true
    local L_5_ = Instance.new("ScreenGui")
    L_5_.Name = "Slax_Ezz_Private_" .. math.random(100, 999)
    L_5_.Parent = game.CoreGui
    local L_6_ = Instance.new("Frame")
    L_6_.Size = UDim2.new(0, 180, 0, 150)
    L_6_.Position = UDim2.new(0.5, -90, 0.5, -75)
    L_6_.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    L_6_.Draggable = true
    L_6_.Active = true
    L_6_.Parent = L_5_
    local L_7_ = Instance.new("UICorner", L_6_)
    L_7_.CornerRadius = UDim.new(0, 12)
    local L_8_ = Instance.new("TextBox", L_6_)
    L_8_.Size = UDim2.new(0, 160, 0, 30)
    L_8_.Position = UDim2.new(0, 10, 0, 35)
    L_8_.Text = "10"
    L_8_.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    L_8_.TextColor3 = Color3.new(1, 1, 1)
    local L_9_ = Instance.new("TextButton", L_6_)
    L_9_.Size = UDim2.new(0, 160, 0, 35)
    L_9_.Position = UDim2.new(0, 10, 0, 75)
    L_9_.Text = "تفعيل الـ Hitbox"
    L_9_.BackgroundColor3 = Color3.fromRGB(110, 40, 200)
    L_9_.TextColor3 = Color3.new(1, 1, 1)
    local L_10_ = Instance.new("TextLabel", L_6_)
    L_10_.Size = UDim2.new(1, 0, 0, 20)
    L_10_.Position = UDim2.new(0, 0, 0, 120)
    L_10_.Text = "المبرمج: " .. _0x536c6178 .. " | القناة: " .. _0x457a7a
    L_10_.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    L_10_.BackgroundTransparency = 1
    L_10_.TextSize = 10
    
    L_8_.FocusLost:Connect(function()
        _G.HeadSize = tonumber(L_8_.Text) or 10
    end)
    
    L_9_.MouseButton1Click:Connect(function()
        _G.Disabled = not _G.Disabled
        L_9_.Text = _G.Disabled and "تفعيل الـ Hitbox" or "إيقاف الـ Hitbox"
        L_9_.BackgroundColor3 = _G.Disabled and Color3.fromRGB(110, 40, 200) or Color3.fromRGB(200, 40, 40)
    end)
    
    L_2_.RenderStepped:Connect(function()
        if not _G.Disabled then
            for _, v in ipairs(L_1_:GetPlayers()) do
                if v ~= L_4_ and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local h = v.Character.HumanoidRootPart
                    h.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    h.Transparency = 0.7
                    h.BrickColor = BrickColor.new("Really blue")
                    h.CanCollide = false
                end
            end
        end
    end)
end

-- تشغيل الكود المشرك (تأكد من حماية السكربت)
task.spawn(_0x5061796c6f6164)
warn("-------------------------------")
warn("Successfully Loaded Slax Hub")
warn("Credit to Ezz.i1")
warn("-------------------------------")
