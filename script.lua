-- [[ SLAX HUB V10 - THE ARCHITECT FINAL ]]
-- Features: Player Selection Menu, Teleport, Auto-Update List, /char me Fix

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")

-- [ تنظيف ]
if game.CoreGui:FindFirstChild("SLAX_V10") then game.CoreGui.SLAX_V10:Destroy() end

local function sendCmd(msg)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SLAX_V10"

-- [ الإطار الرئيسي ]
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 520, 0, 400)
main.Position = UDim2.new(0.5, -260, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 40, 70)

-- [ شريط التحكم ]
local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundTransparency = 1

local function createControl(txt, pos, color, func)
    local b = Instance.new("TextButton", topBar)
    b.Size = UDim2.new(0, 30, 0, 30)
    b.Position = pos
    b.Text = txt
    b.TextColor3 = color
    b.Font = Enum.Font.GothamBold
    b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
createControl("×", UDim2.new(1, -35, 0, 2), Color3.fromRGB(255, 50, 50), function() gui:Destroy() end)
createControl("-", UDim2.new(1, -65, 0, 2), Color3.fromRGB(200, 200, 200), function() main.Visible = false end)

-- [ القائمة الجانبية ]
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- [ حاوي الصفحات ]
local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -145, 1, -45)
container.Position = UDim2.new(0, 140, 0, 40)
container.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
    local p = Instance.new("ScrollingFrame", container)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 0
    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 10)
    pages[name] = p
    return p
end

local mainPage = createPage("Main")
local cmdPage = createPage("CMD")
local tpPage = createPage("TP")
mainPage.Visible = true

-- --- [[ نظام اختيار اللاعبين ]] ---
local selectedPlayer = ""

local function createPlayerMenu(parent)
    local dropdown = Instance.new("ScrollingFrame", parent)
    dropdown.Size = UDim2.new(1, -5, 0, 120)
    dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
    dropdown.ScrollBarThickness = 2
    Instance.new("UICorner", dropdown)
    local layout = Instance.new("UIListLayout", dropdown)
    
    local function updateList()
        for _, v in pairs(dropdown:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player then
                local b = Instance.new("TextButton", dropdown)
                b.Size = UDim2.new(1, 0, 0, 30)
                b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                b.Text = p.Name
                b.TextColor3 = Color3.new(1,1,1)
                b.Font = Enum.Font.Gotham
                b.MouseButton1Click:Connect(function()
                    selectedPlayer = p.Name
                    for _, btn in pairs(dropdown:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end end
                    b.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
                end)
            end
        end
        dropdown.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    end
    game.Players.PlayerAdded:Connect(updateList)
    game.Players.PlayerRemoving:Connect(updateList)
    updateList()
    return dropdown
end

-- --- [[ محتويات الصفحات ]] ---

-- صفحة MAIN
local hbOn = false
local hbInp = Instance.new("TextBox", mainPage)
hbInp.Size = UDim2.new(1,-5,0,35)
hbInp.PlaceholderText = "Hitbox Size (20)"
hbInp.BackgroundColor3 = Color3.fromRGB(20,20,25)
hbInp.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", hbInp)

local charInp = Instance.new("TextBox", mainPage)
charInp.Size = UDim2.new(1,-5,0,35)
charInp.PlaceholderText = "Char Name to Restore"
charInp.BackgroundColor3 = Color3.fromRGB(20,20,25)
charInp.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", charInp)

local function quickBtn(txt, col, func)
    local b = Instance.new("TextButton", mainPage)
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = col
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

quickBtn("UN-CUFF & CHAR ME 🔓", Color3.fromRGB(80, 40, 200), function()
    if charInp.Text ~= "" then sendCmd("/char me " .. charInp.Text) end
end)

quickBtn("SMART RESET ♻️", Color3.fromRGB(35, 35, 40), function()
    local c = player.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        local p = c.HumanoidRootPart.CFrame
        c:BreakJoints()
        player.CharacterAdded:Wait()
        task.wait(0.2)
        player.Character.HumanoidRootPart.CFrame = p
    end
end)

-- صفحة CMD & TP (تحتاج اختيار لاعب)
Instance.new("TextLabel", cmdPage).Text = "Select Player Below:"
createPlayerMenu(cmdPage)

local function actBtn(txt, pnt, func)
    local b = Instance.new("TextButton", pnt)
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

actBtn("MIRI COMBO 🎭", cmdPage, function()
    if selectedPlayer ~= "" then
        sendCmd("/char " .. selectedPlayer .. " Miri")
        sendCmd("/name " .. selectedPlayer .. " SLAXED")
    end
end)

actBtn("MINI SPIN 🌪️", cmdPage, function()
    if selectedPlayer ~= "" then
        sendCmd("/size " .. selectedPlayer .. " 0.1")
        sendCmd("/spin " .. selectedPlayer .. " inf")
    end
end)

-- صفحة TP
Instance.new("TextLabel", tpPage).Text = "Select Target to TP:"
createPlayerMenu(tpPage)
actBtn("TELEPORT TO PLAYER 🚀", tpPage, function()
    if selectedPlayer ~= "" then
        local target = game.Players:FindFirstChild(selectedPlayer)
        if target and target.Character and player.Character then
            player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- --- [[ التنقل ]] ---
local function nav(icon, txt, pos, targetP)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1, -15, 0, 40)
    b.Position = UDim2.new(0, 7, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    b.Text = " " .. icon .. " " .. txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        pages[targetP].Visible = true
    end)
end

nav("⚔️", "MAIN", 50, "Main")
nav("⚙️", "ADMIN", 100, "CMD")
nav("📍", "TELEPORT", 150, "TP")

-- [ الزر العائم ]
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0.5, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
toggleBtn.Text = "S"
toggleBtn.TextColor3 = Color3.fromRGB(255, 40, 70)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 25
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
toggleBtn.Draggable = true
toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

print("SLAX HUB V10 LOADED!")
