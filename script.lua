-- [[ SLAX HUB V18 - THE MASTER ARCHITECT EDITION (MODIFIED) ]]
-- المطور الأصلي: SLAX (سلاكس)
-- التحديث: إضافة صورة الزر الجديدة وتنسيق الواجهة

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
local main = Instance.new("Frame", gui); main.Size = UDim2.new(0, 500, 0, 420); main.Position = UDim2.new(0.5, -250, 0.5, -210); main.BackgroundColor3 = Color3.fromRGB(12, 12, 15); main.Active = true; main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10); Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 40, 70)

local sidebar = Instance.new("ScrollingFrame", main); sidebar.Size = UDim2.new(0, 120, 1, 0); sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10); sidebar.ScrollBarThickness = 2; Instance.new("UICorner", sidebar)
local container = Instance.new("Frame", main); container.Size = UDim2.new(1, -135, 1, -45); container.Position = UDim2.new(0, 130, 0, 40); container.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
    local p = Instance.new("ScrollingFrame", container); p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false; p.ScrollBarThickness = 2
    local layout = Instance.new("UIListLayout", p); layout.Padding = UDim.new(0, 6); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center; pages[name] = p; return p
end

local mainPage = createPage("Main"); local skinsPage = createPage("Skins"); local favPage = createPage("Favorites"); local adminPage = createPage("Admin"); local comboPage = createPage("Combos"); local tpPage = createPage("TP"); local profilePage = createPage("Profile"); local chatPage = createPage("Chat")
mainPage.Visible = true

local selectedTarget, comboTarget, hbOn, hbInv, hbSize, currentPreviewID = "me", "others", false, false, 20, nil

-- [ الأدوات ]
local function createBtn(txt, col, parent, func)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(1, -10, 0, 30); b.BackgroundColor3 = col; b.Text = txt; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.TextSize = 12
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(func); return b
end

-- [ نافذة المعاينة ]
local previewFrame = Instance.new("Frame", main); previewFrame.Size = UDim2.new(0, 150, 0, 200); previewFrame.Position = UDim2.new(1, 10, 0, 0); previewFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); previewFrame.Visible = false; Instance.new("UICorner", previewFrame); Instance.new("UIStroke", previewFrame).Color = Color3.fromRGB(255, 40, 70)
local pImg = Instance.new("ImageLabel", previewFrame); pImg.Size = UDim2.new(0, 100, 0, 100); pImg.Position = UDim2.new(0.5, -50, 0, 10); pImg.BackgroundTransparency = 1; pImg.Image = ""

local function showPreview(id)
    currentPreviewID = id
    pImg.Image = "rbxthumb://type=AvatarHeadShot&id="..id.."&w=150&h=150"
    previewFrame.Visible = true
end

createBtn("ارتداء ✅", Color3.fromRGB(0, 180, 100), previewFrame, function() if currentPreviewID then sendCmd("/char " .. selectedTarget .. " " .. currentPreviewID) end end).Position = UDim2.new(0.05,0,0.60,0)
createBtn("⭐ مفضلة", Color3.fromRGB(255, 180, 0), previewFrame, function() if currentPreviewID then favorites[tostring(currentPreviewID)] = true; saveToDisk() end end).Position = UDim2.new(0.05,0,0.80,0)

-- [ نظام القوائم ]
local function setupMenu(parent, isCombo)
    local d = Instance.new("ScrollingFrame", parent); d.Size = UDim2.new(1, -10, 0, 70); d.BackgroundColor3 = Color3.fromRGB(20, 20, 25); d.ScrollBarThickness = 2; Instance.new("UICorner", d); Instance.new("UIListLayout", d)
    local function up()
        for _, c in pairs(d:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, p in pairs(game.Players:GetPlayers()) do
            if isCombo and p == player then continue end
            local b = Instance.new("TextButton", d); b.Size = UDim2.new(1, 0, 0, 25); 
            local tName = (p == player and "me" or p.Name)
            b.BackgroundColor3 = ((isCombo and comboTarget or selectedTarget) == tName and Color3.fromRGB(255, 40, 70) or Color3.fromRGB(25, 25, 30))
            b.Text = p.Name; b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b); b.TextSize = 11
            b.MouseButton1Click:Connect(function() if isCombo then comboTarget = tName else selectedTarget = tName end; up() end)
        end
    end
    game.Players.PlayerAdded:Connect(up); game.Players.PlayerRemoving:Connect(up); up()
end

-- [[ 1. الرئيسية ]]
local hbInp = Instance.new("TextBox", mainPage); hbInp.Size = UDim2.new(1,-10,0,28); hbInp.PlaceholderText = "اكتب قوة الهيت بوكس هنا..."; hbInp.BackgroundColor3 = Color3.fromRGB(22,22,28); hbInp.TextColor3 = Color3.new(1,1,1); hbInp.TextSize = 12; Instance.new("UICorner", hbInp)
hbInp:GetPropertyChangedSignal("Text"):Connect(function() hbSize = tonumber(hbInp.Text) or 20 end)
createBtn("تفعيل الهيت بوكس ✅", Color3.fromRGB(30,150,30), mainPage, function() hbOn = not hbOn end)
createBtn("إخفاء الهيت بوكس 👻", Color3.fromRGB(100,100,100), mainPage, function() hbInv = not hbInv end)
createBtn("ريسبون ذكي ♻️", Color3.fromRGB(50,50,55), mainPage, function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then local p = c.HumanoidRootPart.CFrame; c:BreakJoints(); player.CharacterAdded:Wait(); task.wait(0.2); player.Character.HumanoidRootPart.CFrame = p end end)

-- [[ 2. سكنات ]]
setupMenu(skinsPage, false)
createBtn("🎲 سكن عشوائي", Color3.fromRGB(255, 40, 70), skinsPage, function() 
    local ids = {
        289438135, 1707711223, 188732, 2298753899, 9119588309, 5254879171, 8595350470, 6007609888,
        124751865, 5019714978, 5007631110, 9088628683, 7223875998, 2474943274, 3104949425, 3335871296,
        203030608, 2596305840, 201124389, 1981724228, 3731169417, 205419201, 7422492329, 406436524,
        1803380, 9406742928, 1359861204, 3012958642, 2260118449, 188829949, 2261820401, 8094705681,
        9894023718, 6077615334, 2281971469, 1946404863, 660132420, 1125262365, 3018607207, 144018186,
        3577671250, 2017401176, 3473976672, 9122248242, 1667867130, 9294642379, 5366504429, 8264800124,
        283156132, 1630540916, 4416918097, 344091683, 6538096, 7623744992, 1099702304, 1199088309,
        1369842558, 3624257547, 145740081, 215710487, 2255861564, 7330109199, 524749295, 272574783,
        4100936320, 4863227235, 1132340350, 5210946332, 3331434198, 2618555079, 4201687597, 147198435,
        704071723, 465771760, 254829155, 8069027498, 2646550793, 366768658, 2885260147
    }
    showPreview(ids[math.random(1,#ids)])
end)
local sGrid = Instance.new("Frame", skinsPage); sGrid.Size = UDim2.new(1,0,0,120); sGrid.BackgroundTransparency = 1; Instance.new("UIGridLayout", sGrid).CellSize = UDim2.new(0.48,0,0,30)
local manualSkins = {{"بكمي 👑", "Adiorbeth"}, {"بنت لطيفة ✨", "0Mariya03"}, {"بنت كيوت 🎀", "kurtellz"}, {"بكمي سوداء 🖤", "1xl_lx"}, {"أجمل رجل 🏆", "A7MD_017"}, {"جمال 2026 🥇", "urut7t7t"}}
for _, s in pairs(manualSkins) do createBtn(s[1], Color3.fromRGB(30,30,35), sGrid, function() sendCmd("/char "..selectedTarget.." "..s[2]) end) end

-- [[ 3. المفضلات ]]
local function refreshFavs()
    for _, c in pairs(favPage:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for id, _ in pairs(favorites) do
        createBtn("ID: "..id, Color3.fromRGB(40,40,45), favPage, function() showPreview(id) end)
    end
end

-- [[ 4. الأدمن ]]
setupMenu(adminPage, false)
local adGrid = Instance.new("Frame", adminPage); adGrid.Size = UDim2.new(1,0,0,150); adGrid.BackgroundTransparency = 1; Instance.new("UIGridLayout", adGrid).CellSize = UDim2.new(0.48,0,0,30)
createBtn("طيران 🕊️", Color3.fromRGB(50,150,255), adGrid, function() sendCmd("/fly "..selectedTarget) end)
createBtn("إيقاف الطيران ❌", Color3.fromRGB(200,50,50), adGrid, function() sendCmd("/unfly "..selectedTarget) end)
createBtn("اختفاء 👻", Color3.fromRGB(100,100,100), adGrid, function() sendCmd("/invis "..selectedTarget) end)
createBtn("نيون 💎", Color3.fromRGB(0,255,255), adGrid, function() sendCmd("/neon "..selectedTarget) end)
createBtn("سرعة ⚡ 100", Color3.fromRGB(0,180,255), adGrid, function() sendCmd("/speed "..selectedTarget.." 100") end)
createBtn("فك قيود 🔓", Color3.fromRGB(80,40,200), adGrid, function() sendCmd("/uncuff "..selectedTarget) end)

-- [[ 5. كومبو ]]
setupMenu(comboPage, true)
createBtn("كومبو الدوران الصغير 🌪️", Color3.fromRGB(255, 100, 0), comboPage, function() sendCmd("/size "..comboTarget.." 0.1 /spin "..comboTarget.." inf") end)
createBtn("حركة ميري 🎭", Color3.fromRGB(255, 40, 70), comboPage, function() sendCmd("/char "..comboTarget.." Miri") end)

-- [[ 6. انتقال ]]
setupMenu(tpPage, false)
createBtn("انتقال للاعب 📍", Color3.fromRGB(150,50,255), tpPage, function() local t = game.Players:FindFirstChild(selectedTarget == "me" and player.Name or selectedTarget) if t and t.Character then player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame end end)

-- [[ 7. البروفايل ]]
local profImg = Instance.new("ImageLabel", profilePage); profImg.Size = UDim2.new(0, 100, 0, 100); profImg.BackgroundTransparency = 1; profImg.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"; Instance.new("UICorner", profImg).CornerRadius = UDim.new(1,0)
local profText = Instance.new("TextLabel", profilePage); profText.Size = UDim2.new(1, 0, 0, 40); profText.BackgroundTransparency = 1; profText.Text = "لو واجهت مشاكل تواصل مع الدعم الفني الخاص بنا في سيرفرنا 💖"; profText.TextColor3 = Color3.fromRGB(200, 200, 200); profText.TextScaled = true; profText.Font = Enum.Font.GothamMedium

local function copyToClip(text, msg)
    if setclipboard then setclipboard(text); sendCmd(msg .. " تم النسخ!") else sendCmd("منفذ السكربت حقك ما يدعم النسخ التلقائي 😢") end
end

createBtn("نسخ رابط اليوتيوب 📺", Color3.fromRGB(255, 0, 0), profilePage, function() copyToClip("https://youtube.com/@ezz.i1?si=iPWvRRe4c1Rr702N", "نورت قناتنا باليوتيوب!") end)
createBtn("نسخ رابط التيك توك 🎵", Color3.fromRGB(25, 25, 25), profilePage, function() copyToClip("https://www.tiktok.com/@2._px?_r=1&_t=ZS-94zsR9sg6wp", "هلا بك في التيك توك!") end)
createBtn("نسخ رابط الديسكورد 💬", Color3.fromRGB(88, 101, 242), profilePage, function() copyToClip("https://discord.gg/fsCeezquk", "حياك بسيرفرنا، الدعم الفني بخدمتك!") end)

-- [[ 8. شات الإشعارات ]]
local chatInp = Instance.new("TextBox", chatPage); chatInp.Size = UDim2.new(1,-10,0,35); chatInp.PlaceholderText = "اكتب رسالتك هنا..."; chatInp.BackgroundColor3 = Color3.fromRGB(22,22,28); chatInp.TextColor3 = Color3.new(1,1,1); chatInp.TextSize = 14; Instance.new("UICorner", chatInp)
local chatGrid = Instance.new("Frame", chatPage); chatGrid.Size = UDim2.new(1,0,0,160); chatGrid.BackgroundTransparency = 1; Instance.new("UIGridLayout", chatGrid).CellSize = UDim2.new(0.31,0,0,30)

local chatCmds = {
    {"أحمر", "/hr ", Color3.fromRGB(255,50,50)}, {"برتقالي", "/ho ", Color3.fromRGB(255,150,0)}, {"أصفر", "/hy ", Color3.fromRGB(255,255,0)},
    {"أخضر", "/hg ", Color3.fromRGB(50,255,50)}, {"أخضر غامق", "/hdg ", Color3.fromRGB(0,150,0)}, {"أزرق", "/hb ", Color3.fromRGB(50,50,255)},
    {"سماوي", "/halb ", Color3.fromRGB(0,200,255)}, {"بنفسجي", "/hp ", Color3.fromRGB(150,50,255)}, {"وردي", "/hpk ", Color3.fromRGB(255,100,200)},
    {"بني/آخر", "/hok ", Color3.fromRGB(139,69,19)}, {"عادي مخفي", ";h ", Color3.fromRGB(150,150,150)}
}

for _, c in pairs(chatCmds) do
    createBtn(c[1], c[3], chatGrid, function() if chatInp.Text ~= "" then sendCmd(c[2] .. chatInp.Text) end end)
end
createBtn("إرسال للشات العادي 💬", Color3.fromRGB(40,40,45), chatPage, function() if chatInp.Text ~= "" then sendCmd(chatInp.Text) end end)

-- [ محرك الهيت بوكس ]
RunService.RenderStepped:Connect(function() for _, v in pairs(game.Players:GetPlayers()) do if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then local hrp = v.Character.HumanoidRootPart if hbOn then hrp.Size = Vector3.new(hbSize, hbSize, hbSize); hrp.Transparency = hbInv and 1 or 0.7; hrp.CanCollide = false else hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 0; hrp.CanCollide = true end end end end)

-- [ أزرار القائمة الجانبية ]
local yPos = 10
local function nav(i, t, tp) 
    local b = createBtn(i.." "..t, Color3.fromRGB(20,20,25), sidebar, function() for _, pg in pairs(pages) do pg.Visible = false end; pages[tp].Visible = true; previewFrame.Visible = false; if tp == "Favorites" then refreshFavs() end end); b.Position = UDim2.new(0,5,0,yPos); b.Size = UDim2.new(1,-10,0,30); b.TextSize = 12; yPos = yPos + 35
end
nav("⚔️", "الرئيسية", "Main"); nav("👕", "سكنات", "Skins"); nav("⭐", "المفضلة", "Favorites"); nav("⚡", "الأدمن", "Admin"); nav("🎭", "كومبو", "Combos"); nav("📍", "انتقال", "TP"); nav("👤", "بروفايل", "Profile"); nav("💬", "شات", "Chat")

-- [[ زِر التبديل الجديد بالصورة المطلوبة ]]
local toggleBtn = Instance.new("ImageButton", gui)
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
toggleBtn.BorderSizePixel = 0
toggleBtn.Draggable = true
toggleBtn.Active = true

-- استخدام ID الصورة من الرابط الخاص بك
toggleBtn.Image = "rbxassetid://99856671918901"

Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)
local btnStroke = Instance.new("UIStroke", toggleBtn); btnStroke.Color = Color3.fromRGB(255, 40, 70); btnStroke.Thickness = 1; btnStroke.Transparency = 0.5

toggleBtn.MouseButton1Click:Connect(function() 
    main.Visible = not main.Visible 
    if not main.Visible then previewFrame.Visible = false end 
end)
