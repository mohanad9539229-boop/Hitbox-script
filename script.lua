-- [[ SLAX HUB: THE FINAL STABLE VERSION ]]
-- Developer: SLAX (سلاكس)

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- دالة إرسال الأوامر للشات (تدعم كل الأنظمة)
local function sendChat(msg)
    local success = pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            -- النظام الجديد (Modern)
            local channel = TextChatService.TextChannels.RBXGeneral
            channel:SendAsync(msg)
        else
            -- النظام القديم (Legacy)
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
    if not success then
        -- محاولة أخيرة لو فشل النظامين
        game:GetService("Players"):Chat(msg)
    end
end

-- إنشاء الواجهة
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "SLAX_HUB_STABLE"

-- زر الإخفاء والإظهار (S)
local toggleBtn = Instance.new("TextButton", sg)
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -22)
toggleBtn.Text = "S"
toggleBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

-- الإطار الرئيسي
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 240, 0, 280)
frame.Position = UDim2.new(0.5, -120, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.Visible = true
frame.Active = true
frame.Draggable = true -- تقدر تحركه في الجوال
Instance.new("UICorner", frame)

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- [1] مربع نص: اسم السكن
local charInput = Instance.new("TextBox", frame)
charInput.Size = UDim2.new(0, 200, 0, 35)
charInput.Position = UDim2.new(0, 20, 0, 25)
charInput.PlaceholderText = "اكتب اسم السكن هنا..."
charInput.Text = LP.Name
charInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
charInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", charInput)

-- [2] زر: فك الكلبشة (Double Swap Chat)
local swapBtn = Instance.new("TextButton", frame)
swapBtn.Size = UDim2.new(0, 200, 0, 40)
swapBtn.Position = UDim2.new(0, 20, 0, 70)
swapBtn.Text = "فك الكلبشة (شات)"
swapBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
swapBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", swapBtn)

swapBtn.MouseButton1Click:Connect(function()
    sendChat("/char me") -- يكتب في الشات لفك الكلبشة
    task.wait(0.3)
    if charInput.Text ~= "" and charInput.Text ~= LP.Name then
        sendChat("/char " .. charInput.Text) -- يكتب الأمر بالاسم الجديد
    end
end)

-- [3] مربع نص: قوة الهيت بوكس
local hbInput = Instance.new("TextBox", frame)
hbInput.Size = UDim2.new(0, 200, 0, 35)
hbInput.Position = UDim2.new(0, 20, 0, 130)
hbInput.PlaceholderText = "قوة الهيت بوكس (مثلاً 20)"
hbInput.Text = "20"
hbInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
hbInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", hbInput)

-- [4] زر: تشغيل/إطفاء الهيت بوكس
local hbToggle = Instance.new("TextButton", frame)
hbToggle.Size = UDim2.new(0, 200, 0, 40)
hbToggle.Position = UDim2.new(0, 20, 0, 175)
hbToggle.Text = "Hitbox: OFF"
hbToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
hbToggle.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", hbToggle)

-- منطق الهيت بوكس
_G.SLAX_HB = false
hbToggle.MouseButton1Click:Connect(function()
    _G.SLAX_HB = not _G.SLAX_HB
    hbToggle.Text = _G.SLAX_HB and "Hitbox: ON" or "Hitbox: OFF"
    hbToggle.BackgroundColor3 = _G.SLAX_HB and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

RS.RenderStepped:Connect(function()
    if _G.SLAX_HB then
        local size = tonumber(hbInput.Text) or 20
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = Vector3.new(size, size, size)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end
end)

print("SLAX HUB: Ready to go!")
