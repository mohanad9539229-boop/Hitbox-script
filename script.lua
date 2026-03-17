-- [[ المطور الرسمي: سلاكس | قناة: Ezz.i1 ]]
-- [[ الإصدار: Ultra Modern V3 - Custom Image ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- إعدادات عامة
_G.HeadSize = 10
_G.Disabled = true

-- إنشاء الواجهة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Slax_Developer_Hub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- التنسيق العصري
local Theme = {
    Main = Color3.fromRGB(12, 12, 18),
    Accent = Color3.fromRGB(140, 80, 250), -- بنفسجي ملكي
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 170)
}

-- [[ الإطار الرئيسي ]]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 190)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -95)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = true
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- نص المطور (سلاكس)
local DevTitle = Instance.new("TextLabel")
DevTitle.Size = UDim2.new(1, -30, 0, 30)
DevTitle.Position = UDim2.new(0, 15, 0, 15)
DevTitle.Text = "المطور: سلاكس"
DevTitle.TextColor3 = Theme.Accent
DevTitle.Font = Enum.Font.GothamBold
DevTitle.TextSize = 20
DevTitle.BackgroundTransparency = 1
DevTitle.TextXAlignment = Enum.TextXAlignment.Left
DevTitle.Parent = MainFrame

-- نص القناة
local ChannelTitle = Instance.new("TextLabel")
ChannelTitle.Size = UDim2.new(1, -30, 0, 15)
ChannelTitle.Position = UDim2.new(0, 15, 0, 42)
ChannelTitle.Text = "قناة: Ezz.i1"
ChannelTitle.TextColor3 = Theme.SubText
ChannelTitle.Font = Enum.Font.Gotham
ChannelTitle.TextSize = 12
ChannelTitle.BackgroundTransparency = 1
ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left
ChannelTitle.Parent = MainFrame

-- مدخل حجم الـ Hitbox
local SizeBox = Instance.new("TextBox")
SizeBox.Size = UDim2.new(1, -30, 0, 40)
SizeBox.Position = UDim2.new(0, 15, 0, 70)
SizeBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SizeBox.Text = "10"
SizeBox.TextColor3 = Theme.Text
SizeBox.Font = Enum.Font.GothamBold
SizeBox.Parent = MainFrame
Instance.new("UICorner", SizeBox).CornerRadius = UDim.new(0, 10)

-- زر التفعيل
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(1, -30, 0, 45)
Toggle.Position = UDim2.new(0, 15, 0, 125)
Toggle.Text = "تفعيل السكربت"
Toggle.BackgroundColor3 = Theme.Accent
Toggle.TextColor3 = Theme.Text
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 16
Toggle.Parent = MainFrame
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 12)

-- [[ زر المطور العائم (بصورتك الخاصة) ]]
local SlaxBtn = Instance.new("TextButton")
SlaxBtn.Size = UDim2.new(0, 60, 0, 60)
SlaxBtn.Position = UDim2.new(0.05, 0, 0.4, 0) -- مكان جانبي مريح
SlaxBtn.BackgroundColor3 = Theme.Main
SlaxBtn.Text = ""
SlaxBtn.Draggable = true -- تقدر تحركه في أي مكان
SlaxBtn.Active = true
SlaxBtn.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner", SlaxBtn)
BtnCorner.CornerRadius = UDim.new(1, 0) -- دائري تماماً

-- إضافة صورتك الشخصية للزر
local SlaxImg = Instance.new("ImageLabel")
SlaxImg.Size = UDim2.new(1, 0, 1, 0)
SlaxImg.Position = UDim2.new(0, 0, 0, 0)
SlaxImg.BackgroundTransparency = 1
SlaxImg.Image = "rbxassetid://124253717157226" -- الآيدي الخاص بك
SlaxImg.Parent = SlaxBtn

local ImgCorner = Instance.new("UICorner", SlaxImg)
ImgCorner.CornerRadius = UDim.new(1, 0)

-- [[ وظائف التشغيل ]]

SizeBox.FocusLost:Connect(function()
    _G.HeadSize = tonumber(SizeBox.Text) or 10
end)

Toggle.MouseButton1Click:Connect(function()
    _G.Disabled = not _G.Disabled
    Toggle.Text = _G.Disabled and "تفعيل السكربت" or "إيقاف السكربت"
    TweenService:Create(Toggle, TweenInfo.new(0.3), {
        BackgroundColor3 = _G.Disabled and Theme.Accent or Color3.fromRGB(200, 50, 50)
    }):Play()
end)

SlaxBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- عمل الـ Hitbox
RunService.RenderStepped:Connect(function()
    if not _G.Disabled then
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local part = v.Character.HumanoidRootPart
                part.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                part.Transparency = 0.7
                part.BrickColor = BrickColor.new("Really blue")
                part.CanCollide = false
            end
        end
    end
end)

-- رسالة الترحيب في الـ Output
print("--------------------------------------")
warn("Slax Modern Hub Loaded!")
print("المطور: سلاكس")
print("--------------------------------------")
