-- [[ SLAX HUB: CHAT COMMAND AUTOMATION ]]
-- Developer: SLAX

local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- دالة إرسال الرسالة في الشات (تشتغل على أغلب الألعاب)
local function sendChatMessage(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        -- النظام الجديد (Modern Chat)
        local channel = TextChatService.TextChannels.RBXGeneral
        channel:SendAsync(message)
    else
        -- النظام القديم (Legacy Chat)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

-- تعديل وظيفة الزر في السكربت حقنا
swapBtn.MouseButton1Click:Connect(function()
    -- 1. إرسال أمر العودة للأصل (لفك الكلبشة)
    sendChatMessage("/char me")
    
    -- انتظر لحظة بسيطة
    task.wait(0.2)
    
    -- 2. إرسال أمر التحويل للاسم المكتوب في المربع
    local targetName = charInput.Text ~= "" and charInput.Text or "me"
    if targetName ~= "me" then
        sendChatMessage("/char " .. targetName)
    end
    
    print("SLAX HUB: Chat Commands Sent!")
end)
