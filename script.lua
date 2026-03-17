-- [[ المطور الرسمي: سلاكس | قناة: Ezz.i1 ]]
-- [[ الإصدار: Ultra Modern V2 ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- إعدادات عامة
_G.HeadSize = 10
_G.Disabled = true

-- إنشاء الواجهة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Slax_Dev_Hub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- التنسيق العصري
local Theme = {
    Main = Color3.fromRGB(12, 12, 18),
    Accent = Color3.fromRGB(140, 80, 250), -- بنفسجي ملكي
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 170)
}

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 190)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -95)
MainFrame.BackgroundColor3 = Theme.Main
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
SizeBox.PlaceholderText = "أدخل الحجم..."
SizeBox.TextColor3 = Theme.Text
SizeBox.Font = Enum.Font.GothamBold
SizeBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner", SizeBox)
BoxCorner.CornerRadius = UDim.new(0, 10)

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

local ToggleCorner = Instance.new("UICorner", Toggle)
ToggleCorner.CornerRadius = UDim.new(0, 12)

-- زر السيف (لإخفاء الواجهة)
local SwordBtn = Instance.new("TextButton")
SwordBtn.Size = UDim2.new(0, 55, 0, 55)
SwordBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
SwordBtn.BackgroundColor3 = Theme.Main
SwordBtn.Text = ""
SwordBtn.Draggable = true
SwordBtn.Parent = ScreenGui

local SwordCorner = Instance.new("UICorner", SwordBtn)
SwordCorner.CornerRadius = UDim.new(0, 50)

local SwordImg = Instance.new("ImageLabel")
SwordImg.Size = UDim2.new(0, 35, 0, 35)
SwordImg.Position = UDim2.new(0.5, -17, 0.5, -17)
SwordImg.Image = "rbxassetid://1061914210"
SwordImg.ImageColor3 = Theme.Accent
SwordImg.BackgroundTransparency = 1
SwordImg.Parent = SwordBtn

-- الوظائف البرمجية
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

SwordBtn.MouseButton1Click:Connect(function()
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
warn("تم تحميل سكربت المطور: سلاكس")
print("حقوق القناة: Ezz.i1")
print("--------------------------------------")
