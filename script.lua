-- [[ المطور الرسمي: سلاكس | قناة: Ezz.i1 ]]
-- [[ الإصدار: Ultra Modern V5 - Super Anti-Cuff ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- إعدادات السكربت
_G.HeadSize = 10
_G.HitboxEnabled = false
_G.AntiCuff = false

-- إنشاء الواجهة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Slax_Ultimate_Hub_V5"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- التنسيق العصري
local Theme = {
    Main = Color3.fromRGB(15, 15, 22),
    Accent = Color3.fromRGB(140, 80, 250), -- بنفسجي
    Red = Color3.fromRGB(200, 50, 50),
    Green = Color3.fromRGB(50, 200, 100),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 180)
}

-- [[ الإطار الرئيسي ]]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 260)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -130)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

-- عنوان المطور (سلاكس)
local DevTitle = Instance.new("TextLabel")
DevTitle.Size = UDim2.new(1, 0, 0, 45)
DevTitle.Text = "المطور: سلاكس"
DevTitle.TextColor3 = Theme.Accent
DevTitle.Font = Enum.Font.GothamBold
DevTitle.TextSize = 22
DevTitle.BackgroundTransparency = 1
DevTitle.Parent = MainFrame

-- [[ الأزرار ]]

-- 1. مدخل حجم الـ Hitbox
local SizeBox = Instance.new("TextBox")
SizeBox.Size = UDim2.new(1, -30, 0, 35)
SizeBox.Position = UDim2.new(0, 15, 0, 55)
SizeBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SizeBox.Text = "10"
SizeBox.TextColor3 = Theme.Text
SizeBox.Font = Enum.Font.GothamBold
SizeBox.Parent = MainFrame
Instance.new("UICorner", SizeBox).CornerRadius = UDim.new(0, 8)

-- 2. زر تفعيل الـ Hitbox
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(1, -30, 0, 40)
HitboxToggle.Position = UDim2.new(0, 15, 0, 100)
HitboxToggle.Text = "تفعيل الـ Hitbox"
HitboxToggle.BackgroundColor3 = Theme.Accent
HitboxToggle.TextColor3 = Theme.Text
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.Parent = MainFrame
Instance.new("UICorner", HitboxToggle).CornerRadius = UDim.new(0, 10)

-- 3. زر مضاد الكلبشة المتطور
local AntiCuffBtn = Instance.new("TextButton")
AntiCuffBtn.Size = UDim2.new(1, -30, 0, 40)
AntiCuffBtn.Position = UDim2.new(0, 15, 0, 150)
AntiCuffBtn.Text = "مضاد الكلبشة: إيقاف"
AntiCuffBtn.BackgroundColor3 = Theme.Red
AntiCuffBtn.TextColor3 = Theme.Text
AntiCuffBtn.Font = Enum.Font.GothamBold
AntiCuffBtn.Parent = MainFrame
Instance.new("UICorner", AntiCuffBtn).CornerRadius = UDim.new(0, 10)

-- حقوق القناة
local ChannelLabel = Instance.new("TextLabel")
ChannelLabel.Size = UDim2.new(1, 0, 0, 20)
ChannelLabel.Position = UDim2.new(0, 0, 1, -25)
ChannelLabel.Text = "قناة: Ezz.i1 | Slax V5"
ChannelLabel.TextColor3 = Theme.SubText
ChannelLabel.Font = Enum.Font.Gotham
ChannelLabel.TextSize = 10
ChannelLabel.BackgroundTransparency = 1
ChannelLabel.Parent = MainFrame

-- [[ زر المطور العائم (بصورتك) ]]
local SlaxBtn = Instance.new("TextButton")
SlaxBtn.Size = UDim2.new(0, 60, 0, 60)
SlaxBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
SlaxBtn.BackgroundColor3 = Theme.Main
SlaxBtn.Text = ""
SlaxBtn.Draggable = true
SlaxBtn.Active = true
SlaxBtn.Parent = ScreenGui
Instance.new("UICorner", SlaxBtn).CornerRadius = UDim.new(1, 0)

local SlaxImg = Instance.new("ImageLabel")
SlaxImg.Size = UDim2.new(1, 0, 1, 0)
SlaxImg.Image = "rbxassetid://124253717157226" -- صورتك يا سلاكس
SlaxImg.BackgroundTransparency = 1
SlaxImg.Parent = SlaxBtn
Instance.new("UICorner", SlaxImg).CornerRadius = UDim.new(1, 0)

-- [[ الوظائف البرمجية المتطورة ]]

-- وظيفة فك الكلبشة والالتصاق (Super Unbind)
local function SuperUnbind()
    local char = LocalPlayer.Character
    if char then
        -- فك تجميد اللاعب
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if hum.PlatformStand == true then hum.PlatformStand = false end
            if hum.WalkSpeed < 10 then hum.WalkSpeed = 16 end
        end

        -- كسر الـ Weld والالتصاق بأي شخص يضغط عليك
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                for _, obj in ipairs(part:GetChildren()) do
                    if obj:IsA("Weld") or obj:IsA("ManualWeld") or obj:IsA("Snap") or obj:IsA("RopeConstraint") then
                        -- إذا كان الربط مع شخص خارج الـ Character بتاعك، احذفه
                        if (obj.Part0 and not obj.Part0:IsDescendantOf(char)) or (obj.Part1 and not obj.Part1:IsDescendantOf(char)) then
                            obj:Destroy()
                        end
                    end
                end
            end
        end

        -- حذف قيم الكلبشة البرمجية
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("ObjectValue") and (obj.Name == "Cuffed" or obj.Name == "Creator") then
                obj:Destroy()
            end
        end
    end
end

-- تفعيل الـ Hitbox
HitboxToggle.MouseButton1Click:Connect(function()
    _G.HitboxEnabled = not _G.HitboxEnabled
    HitboxToggle.Text = _G.HitboxEnabled and "إيقاف الـ Hitbox" or "تفعيل الـ Hitbox"
    TweenService:Create(HitboxToggle, TweenInfo.new(0.3), {BackgroundColor3 = _G.HitboxEnabled and Theme.Red or Theme.Accent}):Play()
end)

-- تفعيل مضاد الكلبشة
AntiCuffBtn.MouseButton1Click:Connect(function()
    _G.AntiCuff = not _G.AntiCuff
    AntiCuffBtn.Text = _G.AntiCuff and "مضاد الكلبشة: يعمل" or "مضاد الكلبشة: إيقاف"
    TweenService:Create(AntiCuffBtn, TweenInfo.new(0.3), {BackgroundColor3 = _G.AntiCuff and Theme.Green or Theme.Red}):Play()
end)

SizeBox.FocusLost:Connect(function()
    _G.HeadSize = tonumber(SizeBox.Text) or 10
end)

SlaxBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- اللوب الأساسي (RenderStepped للأداء السريع)
RunService.RenderStepped:Connect(function()
    -- تشغيل الـ Hitbox
    if _G.HitboxEnabled then
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new("Really blue")
                hrp.CanCollide = false
            end
        end
    end
    
    -- تشغيل مضاد الكلبشة (Super)
    if _G.AntiCuff then
        SuperUnbind()
    end
end)

warn("Slax Hub V5: Loaded Successfully! Developed by Slax.")
