-- [[ SLAX HUB V18 - THE MASTER ARCHITECT EDITION ]]
-- المطور: SLAX (سلاكس)
-- الإصلاح النهائي: استعادة كافة الخيارات + نظام معاينة وحفظ متكامل

local player = game.Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local fileName = "SLAX_Skins_V18.json"
local favorites = {}

if game.CoreGui:FindFirstChild("SLAX_V18_ULTIMATE") then game.CoreGui.SLAX_V18_ULTIMATE:Destroy() end

local function sendCmd(msg)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

-- [ نظام الحفظ ]
local function saveToDisk() if writefile then writefile(fileName, HttpService:JSONEncode(favorites)) end end
local function loadFromDisk() if isfile and isfile(fileName) then favorites = HttpService:JSONDecode(readfile(fileName)) else favorites = {} end end
loadFromDisk()

-- [ الواجهة ]
local gui = Instance.new("ScreenGui", game.CoreGui); gui.Name = "SLAX_V18_ULTIMATE"
local main = Instance.new("Frame", gui); main.Size = UDim2.new(0, 600, 0, 480); main.Position = UDim2.new(0.5, -300, 0.5, -240); main.BackgroundColor3 = Color3.fromRGB(12, 12, 15); main.Active = true; main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12); Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 40, 70)

local sidebar = Instance.new("Frame", main); sidebar.Size = UDim2.new(0, 140, 1, 0); sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10); Instance.new("UICorner", sidebar)
local container = Instance.new("Frame", main); container.Size = UDim2.new(1, -160, 1, -45); container.Position = UDim2.new(0, 150, 0, 40); container.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
    local p = Instance.new("ScrollingFrame", container); p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false; p.ScrollBarThickness = 2
    local layout = Instance.new("UIListLayout", p); layout.Padding = UDim.new(0, 8); pages[name] = p; return p
end

local mainPage = createPage("Main"); local skinsPage = createPage("Skins"); local favPage = createPage("Favorites"); local adminPage = createPage("Admin"); local comboPage = createPage("Combos"); local tpPage = createPage("TP")
mainPage.Visible = true

local selectedTarget, comboTarget, hbOn, hbInv, hbSize, currentPreviewID = "me", "others", false, false, 20, nil

-- [ الأدوات ]
local function createBtn(txt, col, parent, func)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = col; b.Text = txt; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(func); return b
end

-- [ نافذة المعاينة المحدثة ]
local previewFrame = Instance.new("Frame", main); previewFrame.Size = UDim2.new(0, 180, 0, 240); previewFrame.Position = UDim2.new(1, 10, 0, 0); previewFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); previewFrame.Visible = false; Instance.new("UICorner", previewFrame); Instance.new("UIStroke", previewFrame).Color = Color3.fromRGB(255, 40, 70)
local pImg = Instance.new("ImageLabel", previewFrame); pImg.Size = UDim2.new(0, 130, 0, 130); pImg.Position = UDim2.new(0.5, -65, 0, 10); pImg.BackgroundTransparency = 1; pImg.Image = ""

local function showPreview(id)
    currentPreviewID = id
    pImg.Image = "rbxthumb://type=AvatarHeadShot&id="..id.."&w=150&h=150"
    previewFrame.Visible = true
end

createBtn("ارتداء ✅", Color3.fromRGB(0, 180, 100), previewFrame, function() if currentPreviewID then sendCmd("/char " .. selectedTarget .. " " .. currentPreviewID) end end).Position = UDim2.new(0.05,0,0.62,0)
createBtn("⭐ مفضلة", Color3.fromRGB(255, 180, 0), previewFrame, function() if currentPreviewID then favorites[tostring(currentPreviewID)] = true; saveToDisk() end end).Position = UDim2.new(0.05,0,0.80,0)

-- [ نظام القوائم ]
local function setupMenu(parent, isCombo)
    local d = Instance.new("ScrollingFrame", parent); d.Size = UDim2.new(1, -10, 0, 85); d.BackgroundColor3 = Color3.fromRGB(20, 20, 25); d.ScrollBarThickness = 2; Instance.new("UICorner", d); Instance.new("UIListLayout", d)
    local function up()
        for _, c in pairs(d:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, p in pairs(game.Players:GetPlayers()) do
            if isCombo and p == player then continue end
            local b = Instance.new("TextButton", d); b.Size = UDim2.new(1, 0, 0, 28); 
            local tName = (p == player and "me" or p.Name)
            b.BackgroundColor3 = ((isCombo and comboTarget or selectedTarget) == tName and Color3.fromRGB(255, 40, 70) or Color3.fromRGB(25, 25, 30))
            b.Text = p.Name; b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() if isCombo then comboTarget = tName else selectedTarget = tName end; up() end)
        end
    end
    game.Players.PlayerAdded:Connect(up); game.Players.PlayerRemoving:Connect(up); up()
end

-- [[ 1. الرئيسية - الهيت بوكس ]]
local hbInp = Instance.new("TextBox", mainPage); hbInp.Size = UDim2.new(1,-10,0,32); hbInp.PlaceholderText = "اكتب قوة الهيت بوكس هنا..."; hbInp.BackgroundColor3 = Color3.fromRGB(22,22,28); hbInp.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", hbInp)
hbInp:GetPropertyChangedSignal("Text"):Connect(function() hbSize = tonumber(hbInp.Text) or 20 end)
createBtn("تفعيل الهيت بوكس ✅", Color3.fromRGB(30,150,30), mainPage, function() hbOn = not hbOn end)
createBtn("إخفاء الهيت بوكس 👻", Color3.fromRGB(100,100,100), mainPage, function() hbInv = not hbInv end)
createBtn("ريسبون ذكي ♻️", Color3.fromRGB(50,50,55), mainPage, function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then local p = c.HumanoidRootPart.CFrame; c:BreakJoints(); player.CharacterAdded:Wait(); task.wait(0.2); player.Character.HumanoidRootPart.CFrame = p end end)

-- [[ 2. سكنات - USER MENU ]]
setupMenu(skinsPage, false)
createBtn("🎲 سكن عشوائي", Color3.fromRGB(255, 40, 70), skinsPage, function() 
    local ids = {289438135, 1707711223, 188732, 2298753899, 9119588309, 5254879171, 6007609888, 124751865, 5019714978}
    showPreview(ids[math.random(1,#ids)])
end)
local sGrid = Instance.new("Frame", skinsPage); sGrid.Size = UDim2.new(1,0,0,150); sGrid.BackgroundTransparency = 1; Instance.new("UIGridLayout", sGrid).CellSize = UDim2.new(0.48,0,0,35)
local manualSkins = {{"بكمي 👑", "Adiorbeth"}, {"بنت لطيفة ✨", "0Mariya03"}, {"بنت كيوت 🎀", "kurtellz"}, {"بكمي سوداء 🖤", "1xl_lx"}, {"أجمل رجل 🏆", "A7MD_017"}, {"جمال 2026 🥇", "urut7t7t"}}
for _, s in pairs(manualSkins) do createBtn(s[1], Color3.fromRGB(30,30,35), sGrid, function() sendCmd("/char "..selectedTarget.." "..s[2]) end) end

-- [[ 3. المفضلات ]]
local function refreshFavs()
    for _, c in pairs(favPage:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for id, _ in pairs(favorites) do
        createBtn("ID: "..id, Color3.fromRGB(40,40,45), favPage, function() showPreview(id) end)
    end
end

-- [[ 4. الأدمن - الخيارات الكاملة ]]
setupMenu(adminPage, false)
local adGrid = Instance.new("Frame", adminPage); adGrid.Size = UDim2.new(1,0,0,180); adGrid.BackgroundTransparency = 1; Instance.new("UIGridLayout", adGrid).CellSize = UDim2.new(0.48,0,0,35)
createBtn("طيران 🕊️", Color3.fromRGB(50,150,255), adGrid, function() sendCmd("/fly "..selectedTarget) end)
createBtn("إيقاف الطيران ❌", Color3.fromRGB(200,50,50), adGrid, function() sendCmd("/unfly "..selectedTarget) end)
createBtn("اختفاء 👻", Color3.fromRGB(100,100,100), adGrid, function() sendCmd("/invis "..selectedTarget) end)
createBtn("نيون 💎", Color3.fromRGB(0,255,255), adGrid, function() sendCmd("/neon "..selectedTarget) end)
createBtn("سرعة ⚡ 100", Color3.fromRGB(0,180,255), adGrid, function() sendCmd("/speed "..selectedTarget.." 100") end)
createBtn("فك قيود 🔓", Color3.fromRGB(80,40,200), adGrid, function() sendCmd("/uncuff "..selectedTarget) end)

-- [[ 5. كومبو - محمي ]]
setupMenu(comboPage, true)
createBtn("كومبو الدوران الصغير 🌪️", Color3.fromRGB(255, 100, 0), comboPage, function() sendCmd("/size "..comboTarget.." 0.1 /spin "..comboTarget.." inf") end)
createBtn("حركة ميري 🎭", Color3.fromRGB(255, 40, 70), comboPage, function() sendCmd("/char "..comboTarget.." Miri") end)

-- [[ 6. انتقال ]]
setupMenu(tpPage, false)
createBtn("انتقال للاعب 📍", Color3.fromRGB(150,50,255), tpPage, function() local t = game.Players:FindFirstChild(selectedTarget == "me" and player.Name or selectedTarget) if t and t.Character then player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame end end)

-- [ محرك الهيت بوكس ]
RunService.RenderStepped:Connect(function() for _, v in pairs(game.Players:GetPlayers()) do if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then local hrp = v.Character.HumanoidRootPart if hbOn then hrp.Size = Vector3.new(hbSize, hbSize, hbSize); hrp.Transparency = hbInv and 1 or 0.7; hrp.CanCollide = false else hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 0; hrp.CanCollide = true end end end end)
local function nav(i, t, p, tp) 
    local b = createBtn(i.." "..t, Color3.fromRGB(20,20,25), sidebar, function() for _, pg in pairs(pages) do pg.Visible = false end; pages[tp].Visible = true; previewFrame.Visible = false; if tp == "Favorites" then refreshFavs() end end); b.Position = UDim2.new(0,5,0,p); b.Size = UDim2.new(1,-10,0,40) 
end
nav("⚔️", "الرئيسية", 50, "Main"); nav("👕", "سكنات", 100, "Skins"); nav("⭐", "المفضلة", 150, "Favorites"); nav("⚡", "الأدمن", 200, "Admin"); nav("🎭", "كومبو", 250, "Combos"); nav("📍", "انتقال", 300, "TP")
local toggleBtn = Instance.new("TextButton", gui); toggleBtn.Size = UDim2.new(0,50,0,50); toggleBtn.Position = UDim2.new(0,10,0.5,0); toggleBtn.BackgroundColor3 = Color3.fromRGB(15,15,18); toggleBtn.Text = "S"; toggleBtn.TextColor3 = Color3.fromRGB(255, 40, 70); toggleBtn.Font = Enum.Font.GothamBold; toggleBtn.TextSize = 25; Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0); toggleBtn.Draggable = true; toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
