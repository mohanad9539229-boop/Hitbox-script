-- [[ المطور الرسمي: سلاكس | قناة: Ezz.i1 ]]
-- [[ الإصدار: V7 - Anti-Cuff Toggle Fix ]]

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
ScreenGui.Name = "Slax_Final_Fix"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Theme = {
    Main = Color3.fromRGB(15, 15, 22),
    Accent = Color3.fromRGB(140, 80, 250),
    Red = Color3.fromRGB(200, 50, 50),
    Green = Color3.fromRGB(50, 200, 100),
    Text = Color3.fromRGB(255, 255, 255)
}

-- [[ الإطار الرئيسي ]]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 260)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -130)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local DevTitle = Instance.new("TextLabel")
DevTitle.Size = UDim2.new(1, 0, 0, 45)
DevTitle.Text = "المطور: سلاكس"
DevTitle.TextColor3 = Theme.Accent
DevTitle.Font = Enum.Font.GothamBold
DevTitle.TextSize = 22
DevTitle.BackgroundTransparency = 1
DevTitle.Parent = MainFrame

-- 1. مدخل الحجم
local SizeBox = Instance.new("TextBox")
SizeBox.Size = UDim2.new(1, -30, 0, 35)
SizeBox.Position = UDim2.new(0, 15, 0, 55)
SizeBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SizeBox.Text = "10"
SizeBox.TextColor3 = Theme.Text
SizeBox.Font = Enum.Font.GothamBold
SizeBox.Parent = MainFrame
Instance.new("UICorner", SizeBox).CornerRadius = UDim.new(0, 8)

-- 2. زر الـ Hitbox
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(1, -30, 0, 40)
HitboxToggle.Position = UDim2.new(0, 15, 0, 100)
HitboxToggle.Text = "تفعيل الـ Hitbox"
HitboxToggle.BackgroundColor3 = Theme.Accent
HitboxToggle.TextColor3 = Theme.Text
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.Parent = MainFrame
Instance.new("UICorner", HitboxToggle).CornerRadius = UDim.new(0, 10)

-- 3. زر مضاد الكلبشة (تم إصلاح الإيقاف)
local AntiCuffBtn = Instance.new("TextButton")
AntiCuffBtn.Size = UDim2.new(1, -30, 0, 40)
AntiCuffBtn.Position = UDim2.new(0, 15, 0, 150)
AntiCuffBtn.Text = "مضاد الكلبشة: إيقاف"
AntiCuffBtn.BackgroundColor3 = Theme.Red
AntiCuffBtn.TextColor3 = Theme.Text
AntiCuffBtn.Font = Enum.Font.GothamBold
AntiCuffBtn.Parent = MainFrame
Instance.new("UICorner", AntiCuffBtn).CornerRadius = UDim.new(0, 10)

-- [[ زر المطور العائم ]]
local SlaxBtn = Instance.new("TextButton")
SlaxBtn.Size = UDim2.new(0, 60, 0, 60)
SlaxBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
SlaxBtn.BackgroundColor3 = Theme.Main
SlaxBtn.Text = ""
SlaxBtn.Draggable = true
SlaxBtn.Parent = ScreenGui
Instance.new("UICorner", SlaxBtn).CornerRadius = UDim.new(1, 0)

local SlaxImg = Instance.new("ImageLabel")
SlaxImg.Size = UDim2.new(1, 0, 1, 0)
SlaxImg.Image = "rbxassetid://124253717157226"
SlaxImg.BackgroundTransparency = 1
SlaxImg.Parent = SlaxBtn
Instance.new("UICorner", SlaxImg).CornerRadius = UDim.new(1, 0)

-- [[ وظائف الإصلاح ]]

-- وظيفة تنظيف الكلبشة عند الإيقاف
local function StopAntiCuff()
    _G.AntiCuff = false
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum.WalkSpeed = 16 -- إعادة السرعة للطبيعي
        end
    end
end

AntiCuffBtn.MouseButton1Click:Connect(function()
    if _G.AntiCuff == false then
        _G.AntiCuff = true
        AntiCuffBtn.Text = "مضاد الكلبشة: يعمل"
        TweenService:Create(AntiCuffBtn, TweenInfo.new(0.3), {BackgroundColor3 = Theme.Green}):Play()
    else
        StopAntiCuff() -- استدعاء وظيفة الإيقاف والتنظيف
        AntiCuffBtn.Text = "مضاد الكلبشة: إيقاف"
        TweenService:Create(AntiCuffBtn, TweenInfo.new(0.3), {BackgroundColor3 = Theme.Red}):Play()
    end
end)

HitboxToggle.MouseButton1Click:Connect(function()
    _G.HitboxEnabled = not _G.HitboxEnabled
    if not _G.HitboxEnabled then
        -- إعادة الضبط عند الإيقاف
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                v.Character.HumanoidRootPart.Transparency = 1
            end
        end
        HitboxToggle.Text = "تفعيل الـ Hitbox"
        TweenService:Create(HitboxToggle, TweenInfo.new(0.3), {BackgroundColor3 = Theme.Accent}):Play()
    else
        HitboxToggle.Text = "إيقاف الـ Hitbox"
        TweenService:Create(HitboxToggle, TweenInfo.new(0.3), {BackgroundColor3 = Theme.Red}):Play()
    end
end)

SlaxBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

SizeBox.FocusLost:Connect(function()
    _G.HeadSize = tonumber(SizeBox.Text) or 10
end)

-- اللوب الأساسي
RunService.RenderStepped:Connect(function()
    -- Hitbox Loop
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
    
    -- Anti-Cuff Loop (يعمل فقط إذا كانت القيمة True)
    if _G.AntiCuff then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and (hum.PlatformStand or hum.WalkSpeed < 10) then
                hum.PlatformStand = false
                hum.WalkSpeed = 16
            end
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Weld") or obj:IsA("RopeConstraint") or (obj:IsA("ObjectValue") and obj.Name == "Cuffed") then
                    if obj.Parent.Name == "HumanoidRootPart" or obj.Parent.Name == "Torso" or obj.Name == "Cuffed" then
                        obj:Destroy()
                    end
                end
            end
        end
    end
end)

warn("Slax V7: Anti-Cuff Toggle Fixed!")
