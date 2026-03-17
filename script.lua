-- [[ المطور الرسمي: سلاكس | قناة: Ezz.i1 ]]
-- [[ الإصدار الأقوى: V9 - Unstoppable Anti-Cuff ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- القيم البرمجية
_G.HitboxSize = 10
_G.HitboxStatus = false
_G.AntiCuffStatus = false

-- إنشاء الواجهة (Modern Dark GUI)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Slax_Final_V9"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 270)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Draggable = true
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

-- شعار المطور
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "المطور: سلاكس"
Title.TextColor3 = Color3.fromRGB(140, 80, 250)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundTransparency = 1

-- زر الـ Hitbox
local HitToggle = Instance.new("TextButton", MainFrame)
HitToggle.Size = UDim2.new(1, -40, 0, 40)
HitToggle.Position = UDim2.new(0, 20, 0, 60)
HitToggle.Text = "تفعيل الـ Hitbox"
HitToggle.BackgroundColor3 = Color3.fromRGB(140, 80, 250)
HitToggle.TextColor3 = Color3.new(1, 1, 1)
HitToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", HitToggle).CornerRadius = UDim.new(0, 10)

-- مدخل الحجم
local SizeBox = Instance.new("TextBox", MainFrame)
SizeBox.Size = UDim2.new(1, -40, 0, 30)
SizeBox.Position = UDim2.new(0, 20, 0, 110)
SizeBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SizeBox.Text = "10"
SizeBox.TextColor3 = Color3.new(1, 1, 1)
SizeBox.Font = Enum.Font.GothamBold
Instance.new("UICorner", SizeBox).CornerRadius = UDim.new(0, 5)

-- زر مضاد الكلبشة (النسخة الخارقة)
local CuffToggle = Instance.new("TextButton", MainFrame)
CuffToggle.Size = UDim2.new(1, -40, 0, 45)
CuffToggle.Position = UDim2.new(0, 20, 0, 155)
CuffToggle.Text = "مضاد الكلبشة: مطفأ"
CuffToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CuffToggle.TextColor3 = Color3.new(1, 1, 1)
CuffToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", CuffToggle).CornerRadius = UDim.new(0, 10)

-- حقوق القناة
local Footer = Instance.new("TextLabel", MainFrame)
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.Text = "Ezz.i1 | Slax Hub"
Footer.TextColor3 = Color3.fromRGB(100, 100, 110)
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 12
Footer.BackgroundTransparency = 1

-- زر المطور العائم (صورتك)
local SlaxBtn = Instance.new("TextButton", ScreenGui)
SlaxBtn.Size = UDim2.new(0, 65, 0, 65)
SlaxBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
SlaxBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SlaxBtn.Text = ""
SlaxBtn.Draggable = true

local SlaxImg = Instance.new("ImageLabel", SlaxBtn)
SlaxImg.Size = UDim2.new(1, 0, 1, 0)
SlaxImg.Image = "rbxassetid://124253717157226" -- صورتك يا سلاكس
SlaxImg.BackgroundTransparency = 1
Instance.new("UICorner", SlaxImg).CornerRadius = UDim.new(1, 0)
Instance.new("UICorner", SlaxBtn).CornerRadius = UDim.new(1, 0)

-- [[ الوظائف ]]

local function ResetHitboxes()
    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
            v.Character.HumanoidRootPart.Transparency = 1
        end
    end
end

HitToggle.MouseButton1Click:Connect(function()
    _G.HitboxStatus = not _G.HitboxStatus
    if _G.HitboxStatus then
        HitToggle.Text = "إيقاف الـ Hitbox"
        HitToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        HitToggle.Text = "تفعيل الـ Hitbox"
        HitToggle.BackgroundColor3 = Color3.fromRGB(140, 80, 250)
        ResetHitboxes()
    end
end)

CuffToggle.MouseButton1Click:Connect(function()
    _G.AntiCuffStatus = not _G.AntiCuffStatus
    if _G.AntiCuffStatus then
        CuffToggle.Text = "مضاد الكلبشة: يعمل"
        CuffToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    else
        CuffToggle.Text = "مضاد الكلبشة: مطفأ"
        CuffToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

SlaxBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

SizeBox:GetPropertyChangedSignal("Text"):Connect(function()
    _G.HitboxSize = tonumber(SizeBox.Text) or 10
end)

-- اللوب الأساسي (النبض البرمجي)
RunService.RenderStepped:Connect(function()
    -- تشغيل الـ Hitbox
    if _G.HitboxStatus then
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new("Really blue")
                hrp.CanCollide = false
            end
        end
    end

    -- تشغيل مضاد الكلبشة الخارق
    if _G.AntiCuffStatus then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                -- 1. منع الجلوس (أهم خطوة للكلبشة المجانية)
                if hum.Sit then hum.Sit = false end
                -- 2. إعادة السرعة والقوة
                if hum.WalkSpeed < 10 then hum.WalkSpeed = 16 end
                hum.PlatformStand = false
            end
            -- 3. تدمير أي محاولة للربط الفيزيائي
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Weld") or obj:IsA("RopeConstraint") or obj:IsA("ManualWeld") or obj.Name:find("Cuff") then
                    if (obj.Parent.Name == "HumanoidRootPart" or obj.Parent.Name == "Torso" or obj.Name:find("Cuff")) then
                        obj:Destroy()
                    end
                end
            end
        end
    end
end)

print("--------------------------------------")
warn("Slax Hub V9 Loaded! The Ultimate Anti-Cuff is Ready.")
print("--------------------------------------")
