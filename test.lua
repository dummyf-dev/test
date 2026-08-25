-- KhenzoScript - Fixed UI Layout & Shortened Value Format (M, B, T) + Luck Preserved
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KhenzoScriptGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 320)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(50, 50, 60)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local accentLine = Instance.new("Frame")
accentLine.Name = "AccentLine"
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.BorderSizePixel = 0
accentLine.Parent = topBar

local accentGradient = Instance.new("UIGradient")
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))
})
accentGradient.Parent = accentLine

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -110, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "KhenzoScript"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Back Button
local backButton = Instance.new("TextButton")
backButton.Name = "BackButton"
backButton.Size = UDim2.new(0, 26, 0, 26)
backButton.Position = UDim2.new(1, -95, 0.5, -13)
backButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
backButton.Text = "<"
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.TextSize = 14
backButton.Font = Enum.Font.GothamBold
backButton.Visible = false
backButton.Parent = topBar

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 6)
backCorner.Parent = backButton

-- Minimize Button (-)
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 26, 0, 26)
minimizeButton.Position = UDim2.new(1, -63, 0.5, -13)
minimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = topBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

-- Close Button (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -31, 0.5, -13)
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 12
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Content Container
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -24, 1, -50)
contentFrame.Position = UDim2.new(0, 12, 0, 48)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Resize Grip
local resizeGrip = Instance.new("TextButton")
resizeGrip.Name = "ResizeGrip"
resizeGrip.Size = UDim2.new(0, 16, 0, 16)
resizeGrip.Position = UDim2.new(1, -16, 1, -16)
resizeGrip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
resizeGrip.BackgroundTransparency = 0.5
resizeGrip.Text = "◢"
resizeGrip.TextColor3 = Color3.fromRGB(200, 200, 200)
resizeGrip.TextSize = 10
resizeGrip.Font = Enum.Font.GothamBold
resizeGrip.Parent = mainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 4)
resizeCorner.Parent = resizeGrip

---------------------------------------------------------
-- TOAST NOTIFICATIONS
---------------------------------------------------------
local toastContainer = Instance.new("Frame")
toastContainer.Name = "ToastContainer"
toastContainer.Size = UDim2.new(0, 220, 0, 32)
toastContainer.Position = UDim2.new(0.5, -110, 0, -40)
toastContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
toastContainer.BorderSizePixel = 0
toastContainer.ZIndex = 10
toastContainer.Parent = mainFrame

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 6)
toastCorner.Parent = toastContainer

local toastStroke = Instance.new("UIStroke")
toastStroke.Color = Color3.fromRGB(0, 170, 255)
toastStroke.Thickness = 1
toastStroke.Parent = toastContainer

local toastLabel = Instance.new("TextLabel")
toastLabel.Name = "ToastLabel"
toastLabel.Size = UDim2.new(1, -10, 1, 0)
toastLabel.Position = UDim2.new(0, 5, 0, 0)
toastLabel.BackgroundTransparency = 1
toastLabel.Text = "Notification"
toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toastLabel.TextSize = 11
toastLabel.Font = Enum.Font.GothamMedium
toastLabel.ZIndex = 11
toastLabel.Parent = toastContainer

local function showToast(message)
    toastLabel.Text = message
    toastContainer:TweenPosition(
        UDim2.new(0.5, -110, 0, 8),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.3,
        true
    )
    task.delay(2, function()
        toastContainer:TweenPosition(
            UDim2.new(0.5, -110, 0, -40),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quart,
            0.3,
            true
        )
    end)
end

---------------------------------------------------------
-- HELPER SEARCH BAR CREATOR
---------------------------------------------------------
local function createSearchBar(parent, placeholderText)
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchBar"
    searchBox.Size = UDim2.new(1, 0, 0, 26)
    searchBox.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    searchBox.PlaceholderText = placeholderText or "🔍 Cari..."
    searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.TextSize = 12
    searchBox.Font = Enum.Font.Gotham
    searchBox.ClearTextOnFocus = false
    searchBox.Parent = parent

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = searchBox

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(50, 50, 60)
    boxStroke.Thickness = 1
    boxStroke.Parent = searchBox

    return searchBox
end

---------------------------------------------------------
-- HELPER: FORMAT NUMERIC VALUE TO SHORT FORM (K, M, B, T)
---------------------------------------------------------
local function formatValue(rawVal)
    if not rawVal then return "-" end
    local num = tonumber(tostring(rawVal):match("[%d%.]+"))
    if not num then return tostring(rawVal) end

    if num >= 1e12 then
        return string.format("$%.2fT", num / 1e12):gsub("%.00", "")
    elseif num >= 1e9 then
        return string.format("$%.2fB", num / 1e9):gsub("%.00", "")
    elseif num >= 1e6 then
        return string.format("$%.2fM", num / 1e6):gsub("%.00", "")
    elseif num >= 1e3 then
        return string.format("$%.2fK", num / 1e3):gsub("%.00", "")
    else
        return "$" .. tostring(num)
    end
end

---------------------------------------------------------
-- HELPER: EXTRACT ITEM STATS (WEIGHT, VALUE, LUCK)
---------------------------------------------------------
local function getItemStats(tool)
    local weight = "-"
    local rawValue = nil
    local value = "-"
    local luck = "-"

    -- 1. Cek Attributes
    local attrs = tool:GetAttributes()
    if attrs.Weight then weight = tostring(attrs.Weight) .. " kg" end
    if attrs.kg then weight = tostring(attrs.kg) .. " kg" end
    if attrs.Value then rawValue = attrs.Value end
    if attrs.Price then rawValue = attrs.Price end
    if attrs.Luck then luck = "Luck +" .. tostring(attrs.Luck) .. "%" end

    -- 2. Cek Child Objects (ValueObjects)
    local weightObj = tool:FindFirstChild("Weight") or tool:FindFirstChild("kg")
    if weightObj then weight = tostring(weightObj.Value) .. " kg" end

    local valObj = tool:FindFirstChild("Value") or tool:FindFirstChild("Price")
    if valObj then rawValue = valObj.Value end

    local luckObj = tool:FindFirstChild("Luck") or tool:FindFirstChild("LuckValue")
    if luckObj then luck = "Luck +" .. tostring(luckObj.Value) .. "%" end

    -- 3. Cek Nama Tool
    local name = tool.Name
    local weightMatch = name:match("[%[%(]([%d%.]+%s*[kK]g)[%]%)]") or name:match("[%[%(]([%d%.]+%s*[tT]ons?)[%]%)]")
    if weightMatch then weight = weightMatch end

    -- 4. Cek TextLabel Descendants
    for _, desc in ipairs(tool:GetDescendants()) do
        if desc:IsA("TextLabel") then
            local text = desc.Text
            if text:find("kg") or text:find("tons") then
                if weight == "-" then weight = text:match("([%d%.]+%s*kg)") or text:match("([%d%.]+%s*tons?)") or weight end
            end
            if text:find("%$") then
                local matchedVal = text:match("%$([%d%.%a]+)")
                if matchedVal and not rawValue then rawValue = matchedVal end
            end
            if text:lower():find("luck") then
                if luck == "-" then 
                    luck = text:match("(Luck%s*[%+%-%d%.%a%%]+)") or text:match("(%+[%d%.%a]+%%)") or text
                end
            end
        end
    end

    value = formatValue(rawValue)
    return weight, value, luck
end

---------------------------------------------------------
-- PAGES SETUP
---------------------------------------------------------

-- 1. Main Page
local mainPage = Instance.new("Frame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.Parent = contentFrame

local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 10)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = mainPage

local function createSection(titleText, parent, height)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = titleText .. "Section"
    sectionFrame.Size = UDim2.new(1, 0, 0, height or 60)
    sectionFrame.BackgroundTransparency = 1
    sectionFrame.Parent = parent

    local title = Instance.new("TextLabel")
    title.Name = "SectionTitle"
    title.Size = UDim2.new(1, 0, 0, 14)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(138, 138, 158)
    title.TextSize = 10
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = sectionFrame

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, 0, 1, -18)
    container.Position = UDim2.new(0, 0, 0, 18)
    container.BackgroundTransparency = 1
    container.Parent = sectionFrame

    return sectionFrame, container
end

-- 2. Rune Page Container
local runePage = Instance.new("Frame")
runePage.Name = "RunePage"
runePage.Size = UDim2.new(1, 0, 1, 0)
runePage.BackgroundTransparency = 1
runePage.Visible = false
runePage.Parent = contentFrame

local runeSearch = createSearchBar(runePage, "🔍 Cari Rune...")

local runeTopControls = Instance.new("Frame")
runeTopControls.Name = "RuneTopControls"
runeTopControls.Size = UDim2.new(1, 0, 0, 35)
runeTopControls.Position = UDim2.new(0, 0, 0, 32)
runeTopControls.BackgroundTransparency = 1
runeTopControls.Parent = runePage

local topGrid = Instance.new("UIGridLayout")
topGrid.CellSize = UDim2.new(0.48, 0, 0, 32)
topGrid.CellPadding = UDim2.new(0.04, 0, 0, 0)
topGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
topGrid.SortOrder = Enum.SortOrder.LayoutOrder
topGrid.Parent = runeTopControls

local dividerLineRune = Instance.new("Frame")
dividerLineRune.Name = "DividerLineRune"
dividerLineRune.Size = UDim2.new(1, 0, 0, 1)
dividerLineRune.Position = UDim2.new(0, 0, 0, 72)
dividerLineRune.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
dividerLineRune.BorderSizePixel = 0
dividerLineRune.Parent = runePage

local runeScroll = Instance.new("ScrollingFrame")
runeScroll.Name = "RuneScroll"
runeScroll.Size = UDim2.new(1, 0, 1, -78)
runeScroll.Position = UDim2.new(0, 0, 0, 78)
runeScroll.BackgroundTransparency = 1
runeScroll.BorderSizePixel = 0
runeScroll.ScrollBarThickness = 4
runeScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
runeScroll.Parent = runePage

local runeGrid = Instance.new("UIGridLayout")
runeGrid.CellSize = UDim2.new(0.48, 0, 0, 34)
runeGrid.CellPadding = UDim2.new(0.04, 0, 0, 6)
runeGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
runeGrid.SortOrder = Enum.SortOrder.LayoutOrder
runeGrid.Parent = runeScroll

-- 3. Backpack Page Container
local backpackPage = Instance.new("Frame")
backpackPage.Name = "BackpackPage"
backpackPage.Size = UDim2.new(1, 0, 1, 0)
backpackPage.BackgroundTransparency = 1
backpackPage.Visible = false
backpackPage.Parent = contentFrame

local bpSearch = createSearchBar(backpackPage, "🔍 Cari Item Backpack...")

local bpTopControls = Instance.new("Frame")
bpTopControls.Name = "BpTopControls"
bpTopControls.Size = UDim2.new(1, 0, 0, 50)
bpTopControls.Position = UDim2.new(0, 0, 0, 32)
bpTopControls.BackgroundTransparency = 1
bpTopControls.Parent = backpackPage

local statsLabel = Instance.new("TextLabel")
statsLabel.Name = "StatsLabel"
statsLabel.Size = UDim2.new(1, 0, 0, 16)
statsLabel.Position = UDim2.new(0, 0, 0, 0)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "⭐ Favorite: 0  |  📦 Non-Fav: 0"
statsLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
statsLabel.TextSize = 11
statsLabel.Font = Enum.Font.GothamMedium
statsLabel.Parent = bpTopControls

local refreshBpBtn = Instance.new("TextButton")
refreshBpBtn.Name = "RefreshBpButton"
refreshBpBtn.Size = UDim2.new(1, 0, 0, 26)
refreshBpBtn.Position = UDim2.new(0, 0, 0, 20)
refreshBpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
refreshBpBtn.Text = "Refresh"
refreshBpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBpBtn.TextSize = 12
refreshBpBtn.Font = Enum.Font.GothamMedium
refreshBpBtn.Parent = bpTopControls

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 6)
refreshCorner.Parent = refreshBpBtn

local dividerLineBp = Instance.new("Frame")
dividerLineBp.Name = "DividerLineBp"
dividerLineBp.Size = UDim2.new(1, 0, 0, 1)
dividerLineBp.Position = UDim2.new(0, 0, 0, 84)
dividerLineBp.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
dividerLineBp.BorderSizePixel = 0
dividerLineBp.Parent = backpackPage

local backpackScroll = Instance.new("ScrollingFrame")
backpackScroll.Name = "BackpackScroll"
backpackScroll.Size = UDim2.new(1, 0, 1, -88)
backpackScroll.Position = UDim2.new(0, 0, 0, 88)
backpackScroll.BackgroundTransparency = 1
backpackScroll.BorderSizePixel = 0
backpackScroll.ScrollBarThickness = 4
backpackScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
backpackScroll.Parent = backpackPage

local backpackLayout = Instance.new("UIListLayout")
backpackLayout.Padding = UDim.new(0, 6)
backpackLayout.SortOrder = Enum.SortOrder.LayoutOrder
backpackLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
backpackLayout.Parent = backpackScroll

-- 4. Auto Drop Page Container
local autoDropPage = Instance.new("Frame")
autoDropPage.Name = "AutoDropPage"
autoDropPage.Size = UDim2.new(1, 0, 1, 0)
autoDropPage.BackgroundTransparency = 1
autoDropPage.Visible = false
autoDropPage.Parent = contentFrame

local dropSearch = createSearchBar(autoDropPage, "🔍 Cari Item Drop...")

local dropTopControls = Instance.new("Frame")
dropTopControls.Name = "DropTopControls"
dropTopControls.Size = UDim2.new(1, 0, 0, 32)
dropTopControls.Position = UDim2.new(0, 0, 0, 32)
dropTopControls.BackgroundTransparency = 1
dropTopControls.Parent = autoDropPage

local refreshDropBtn = Instance.new("TextButton")
refreshDropBtn.Name = "RefreshDropButton"
refreshDropBtn.Size = UDim2.new(1, 0, 0, 26)
refreshDropBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
refreshDropBtn.Text = "🔄 Refresh List Drop"
refreshDropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshDropBtn.TextSize = 12
refreshDropBtn.Font = Enum.Font.GothamMedium
refreshDropBtn.Parent = dropTopControls

local refreshDropCorner = Instance.new("UICorner")
refreshDropCorner.CornerRadius = UDim.new(0, 6)
refreshDropCorner.Parent = refreshDropBtn

local dividerLineDrop = Instance.new("Frame")
dividerLineDrop.Name = "DividerLineDrop"
dividerLineDrop.Size = UDim2.new(1, 0, 0, 1)
dividerLineDrop.Position = UDim2.new(0, 0, 0, 68)
dividerLineDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
dividerLineDrop.BorderSizePixel = 0
dividerLineDrop.Parent = autoDropPage

local autoDropScroll = Instance.new("ScrollingFrame")
autoDropScroll.Name = "AutoDropScroll"
autoDropScroll.Size = UDim2.new(1, 0, 1, -72)
autoDropScroll.Position = UDim2.new(0, 0, 0, 72)
autoDropScroll.BackgroundTransparency = 1
autoDropScroll.BorderSizePixel = 0
autoDropScroll.ScrollBarThickness = 4
autoDropScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
autoDropScroll.Parent = autoDropPage

local autoDropLayout = Instance.new("UIListLayout")
autoDropLayout.Padding = UDim.new(0, 6)
autoDropLayout.SortOrder = Enum.SortOrder.LayoutOrder
autoDropLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
autoDropLayout.Parent = autoDropScroll

---------------------------------------------------------
-- HELPER BUTTON CREATOR
---------------------------------------------------------
local function createUiButton(text, parent, bgColor, borderColor)
    local btn = Instance.new("TextButton")
    btn.Name = text .. "Button"
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = bgColor or Color3.fromRGB(26, 26, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = borderColor or Color3.fromRGB(55, 55, 65)
    btnStroke.Thickness = 1
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = btn

    return btn
end

---------------------------------------------------------
-- MAIN PAGE BUTTON LAYOUT
---------------------------------------------------------
local _, dupeContainer = createSection("MAIN DUPE FEATURES", mainPage, 56)
local dupeGrid = Instance.new("UIGridLayout")
dupeGrid.CellSize = UDim2.new(0.48, 0, 0, 34)
dupeGrid.CellPadding = UDim2.new(0.04, 0, 0, 0)
dupeGrid.Parent = dupeContainer

local crystalBtn = createUiButton("💎 Crystal Dupe", dupeContainer, Color3.fromRGB(140, 60, 180), Color3.fromRGB(168, 76, 216))
local runeMainBtn = createUiButton("📜 Rune Dupe", dupeContainer, Color3.fromRGB(140, 60, 180), Color3.fromRGB(168, 76, 216))

local _, invContainer = createSection("INVENTORY", mainPage, 92)
local invGrid = Instance.new("UIGridLayout")
invGrid.CellSize = UDim2.new(1, 0, 0, 32)
invGrid.CellPadding = UDim2.new(0, 0, 0, 6)
invGrid.Parent = invContainer

local backpackMainBtn = createUiButton("📦 Backpack", invContainer, Color3.fromRGB(0, 120, 215), Color3.fromRGB(26, 144, 238))
local autoDropMainBtn = createUiButton("🗑️ Auto Drop", invContainer, Color3.fromRGB(180, 50, 50), Color3.fromRGB(216, 76, 76))

local _, utilContainer = createSection("UTILITIES & TOGGLES", mainPage, 56)
local utilGrid = Instance.new("UIGridLayout")
utilGrid.CellSize = UDim2.new(0.48, 0, 0, 34)
utilGrid.CellPadding = UDim2.new(0.04, 0, 0, 0)
utilGrid.Parent = utilContainer

local autoPickupBtn = createUiButton("⚡ Auto Pickup: OFF", utilContainer)
local noClipBtn = createUiButton("🌀 No Clip: OFF", utilContainer)

---------------------------------------------------------
-- RUNE PAGE CONTROLS CREATION
---------------------------------------------------------
local allRuneBtn = createUiButton("All Rune", runeTopControls, Color3.fromRGB(40, 40, 48))
local executeBtn = createUiButton("Execute Runes", runeTopControls, Color3.fromRGB(0, 120, 215))

local runeList = {
    "Haste", "Storm", "Weight", 
    "Fortune", "Detonation", "Preservation", 
    "Warmth", "Excavator", "Colossus"
}

local runeButtons = {}
local selectedRunes = {}
local isExecuting = false

for _, runeName in ipairs(runeList) do
    local btn = createUiButton(runeName, runeScroll)
    runeButtons[runeName] = btn
    selectedRunes[runeName] = false
end

runeSearch:GetPropertyChangedSignal("Text"):Connect(function()
    local query = runeSearch.Text:lower()
    for runeName, btn in pairs(runeButtons) do
        btn.Visible = (query == "" or string.find(runeName:lower(), query)) and true or false
    end
end)

---------------------------------------------------------
-- AUTO PICKUP LOGIC
---------------------------------------------------------
local autoPickupEnabled = false
local autoPickupThread = nil

local function isItemPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return false end
    local parent = prompt.Parent
    if not parent then return false end

    local actionText = prompt.ActionText:lower()
    local objectText = prompt.ObjectText:lower()

    if actionText:find("pick") or actionText:find("take") or actionText:find("grab") or actionText:find("ambil") then
        return true
    end

    if objectText:find("rune") or objectText:find("item") or objectText:find("crystal") or objectText:find("drop") then
        return true
    end

    if parent:IsA("Tool") or parent:IsA("Model") or parent:IsA("BasePart") then
        local ancestor = parent.Parent
        if ancestor == Workspace or ancestor.Name:lower():find("item") or ancestor.Name:lower():find("drop") then
            return true
        end
    end

    return false
end

local function fireProximityPrompt(prompt)
    if prompt and prompt.Enabled and isItemPrompt(prompt) then
        pcall(function()
            fireproximityprompt(prompt)
        end)
    end
end

local function toggleAutoPickup()
    autoPickupEnabled = not autoPickupEnabled

    local stroke = autoPickupBtn:FindFirstChildOfClass("UIStroke")
    if autoPickupEnabled then
        autoPickupBtn.Text = "⚡ Auto Pickup: ON"
        autoPickupBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        if stroke then stroke.Color = Color3.fromRGB(56, 168, 56) end
        showToast("Auto Pickup Enabled")

        autoPickupThread = task.spawn(function()
            while autoPickupEnabled do
                for _, object in ipairs(Workspace:GetDescendants()) do
                    if object:IsA("ProximityPrompt") then
                        fireProximityPrompt(object)
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        autoPickupBtn.Text = "⚡ Auto Pickup: OFF"
        autoPickupBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
        if stroke then stroke.Color = Color3.fromRGB(55, 55, 65) end
        showToast("Auto Pickup Disabled")

        if autoPickupThread then
            task.cancel(autoPickupThread)
            autoPickupThread = nil
        end
    end
end

autoPickupBtn.MouseButton1Click:Connect(toggleAutoPickup)

---------------------------------------------------------
-- NO CLIP LOGIC
---------------------------------------------------------
local noclipEnabled = false
local noclipConnection = nil

local function toggleNoclip()
    noclipEnabled = not noclipEnabled

    local stroke = noClipBtn:FindFirstChildOfClass("UIStroke")
    if noclipEnabled then
        noClipBtn.Text = "🌀 No Clip: ON"
        noClipBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        if stroke then stroke.Color = Color3.fromRGB(56, 168, 56) end
        showToast("No Clip Activated")
        
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        noClipBtn.Text = "🌀 No Clip: OFF"
        noClipBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
        if stroke then stroke.Color = Color3.fromRGB(55, 55, 65) end
        showToast("No Clip Deactivated")
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

noClipBtn.MouseButton1Click:Connect(toggleNoclip)

---------------------------------------------------------
-- ITEM FAVORITE DETECTOR & DROP LOGIC
---------------------------------------------------------
local refreshBackpackItems
local refreshAutoDropList

local function isToolFavorited(tool)
    if tool:FindFirstChild("Favorite") or tool:FindFirstChild("Favorited") then
        return true
    end
    if tool:GetAttribute("Favorited") == true or tool:GetAttribute("Favorite") == true then
        return true
    end
    local isFav = false
    pcall(function()
        if tool.IsFavorited == true then isFav = true end
    end)
    return isFav
end

local function performDropTool(tool)
    if not tool or isToolFavorited(tool) then return false end
    local character = player.Character
    if not character then return false end

    local dropped = false
    tool.Parent = character
    task.wait(0.05)

    if tool.CanBeDropped then
        tool.Parent = Workspace
        dropped = true
    end

    if not dropped then
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
            dropped = true
        end)
    end

    if not dropped and tool.Parent == character then
        tool.Parent = Workspace
        dropped = true
    end

    task.wait(0.05)
    return dropped
end

local function executeAutoDrop(targetName, targetWeight, targetValue, targetLuck, amount)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    if not character or not backpack then return end

    local droppedCount = 0
    local toolsToDrop = {}

    local function checkAndAdd(tool)
        if tool:IsA("Tool") and tool.Name == targetName and not isToolFavorited(tool) then
            local w, v, l = getItemStats(tool)
            if w == targetWeight and v == targetValue and l == targetLuck then
                table.insert(toolsToDrop, tool)
            end
        end
    end

    for _, tool in ipairs(backpack:GetChildren()) do checkAndAdd(tool) end
    for _, tool in ipairs(character:GetChildren()) do checkAndAdd(tool) end

    if #toolsToDrop == 0 then
        showToast("Tidak ada item cocok!")
        return
    end

    for _, tool in ipairs(toolsToDrop) do
        if droppedCount >= amount then break end
        local success = performDropTool(tool)
        if success then
            droppedCount = droppedCount + 1
        end
    end

    showToast(string.format("Dropped %d/%d %s", droppedCount, amount, targetName))
    refreshAutoDropList()
    refreshBackpackItems()
end

---------------------------------------------------------
-- REFRESH BACKPACK LIST
---------------------------------------------------------
refreshBackpackItems = function()
    for _, child in ipairs(backpackScroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local itemCounts = {}
    local totalFav = 0
    local totalNonFav = 0

    local function processTool(item)
        if item:IsA("Tool") then
            local isFav = isToolFavorited(item)
            local name = item.Name
            local weight, value, luck = getItemStats(item)

            local statsKey = string.format("%s_|_%s_|_%s_|_%s", name, weight, value, luck)

            if not itemCounts[statsKey] then
                itemCounts[statsKey] = { 
                    Name = name, 
                    Fav = 0, 
                    NonFav = 0, 
                    Weight = weight, 
                    Value = value, 
                    Luck = luck 
                }
            end

            if isFav then
                itemCounts[statsKey].Fav = itemCounts[statsKey].Fav + 1
                totalFav = totalFav + 1
            else
                itemCounts[statsKey].NonFav = itemCounts[statsKey].NonFav + 1
                totalNonFav = totalNonFav + 1
            end
        end
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do processTool(item) end
    end

    local character = player.Character
    if character then
        for _, item in ipairs(character:GetChildren()) do processTool(item) end
    end

    statsLabel.Text = string.format("⭐ Favorite: %d  |  📦 Non-Fav: %d", totalFav, totalNonFav)

    local sortedList = {}
    for _, data in pairs(itemCounts) do
        table.insert(sortedList, data)
    end

    table.sort(sortedList, function(a, b)
        if a.Name:lower() == b.Name:lower() then
            return a.Weight < b.Weight
        end
        return a.Name:lower() < b.Name:lower()
    end)

    if #sortedList == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 40)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Text = "Backpack Kosong"
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.TextSize = 13
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.Parent = backpackScroll
    else
        for _, data in ipairs(sortedList) do
            local itemFrame = Instance.new("Frame")
            itemFrame.Name = data.Name .. "Frame"
            itemFrame.Size = UDim2.new(1, -10, 0, 60)
            itemFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
            itemFrame.Parent = backpackScroll

            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 6)
            frameCorner.Parent = itemFrame

            local frameStroke = Instance.new("UIStroke")
            frameStroke.Color = data.Fav > 0 and Color3.fromRGB(220, 170, 0) or Color3.fromRGB(45, 45, 55)
            frameStroke.Thickness = 1
            frameStroke.Parent = itemFrame

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "ItemName"
            nameLabel.Size = UDim2.new(0.65, -10, 0, 18)
            nameLabel.Position = UDim2.new(0, 10, 0, 4)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = (data.Fav > 0 and "⭐ " or "") .. data.Name
            nameLabel.TextColor3 = data.Fav > 0 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255)
            nameLabel.TextSize = 11
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = itemFrame

            local statsTextLabel = Instance.new("TextLabel")
            statsTextLabel.Name = "ItemStatsText"
            statsTextLabel.Size = UDim2.new(0.65, -10, 0, 34)
            statsTextLabel.Position = UDim2.new(0, 10, 0, 22)
            statsTextLabel.BackgroundTransparency = 1
            statsTextLabel.Text = string.format("⚖️ %s | 💵 %s | 🍀 %s", data.Weight, data.Value, data.Luck)
            statsTextLabel.TextColor3 = Color3.fromRGB(160, 220, 255)
            statsTextLabel.TextSize = 9
            statsTextLabel.Font = Enum.Font.Gotham
            statsTextLabel.TextXAlignment = Enum.TextXAlignment.Left
            statsTextLabel.TextWrapped = true
            statsTextLabel.Parent = itemFrame

            local countLabel = Instance.new("TextLabel")
            countLabel.Size = UDim2.new(0.35, -10, 1, 0)
            countLabel.Position = UDim2.new(0.65, 0, 0, 0)
            countLabel.BackgroundTransparency = 1
            countLabel.Text = string.format("⭐%d | 📦%d", data.Fav, data.NonFav)
            countLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
            countLabel.TextSize = 11
            countLabel.Font = Enum.Font.GothamBold
            countLabel.TextXAlignment = Enum.TextXAlignment.Right
            countLabel.Parent = itemFrame
        end
    end

    backpackScroll.CanvasSize = UDim2.new(0, 0, 0, backpackLayout.AbsoluteContentSize.Y + 10)
end

---------------------------------------------------------
-- REFRESH AUTO DROP LIST
---------------------------------------------------------
refreshAutoDropList = function()
    for _, child in ipairs(autoDropScroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local itemCounts = {}

    local function processTool(item)
        if item:IsA("Tool") then
            local isFav = isToolFavorited(item)
            local name = item.Name
            local weight, value, luck = getItemStats(item)

            local statsKey = string.format("%s_|_%s_|_%s_|_%s", name, weight, value, luck)

            if not itemCounts[statsKey] then
                itemCounts[statsKey] = { 
                    Name = name, 
                    Fav = 0, 
                    NonFav = 0, 
                    Weight = weight, 
                    Value = value, 
                    Luck = luck 
                }
            end

            if isFav then
                itemCounts[statsKey].Fav = itemCounts[statsKey].Fav + 1
            else
                itemCounts[statsKey].NonFav = itemCounts[statsKey].NonFav + 1
            end
        end
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do processTool(item) end
    end

    local character = player.Character
    if character then
        for _, item in ipairs(character:GetChildren()) do processTool(item) end
    end

    local sortedList = {}
    for _, data in pairs(itemCounts) do
        table.insert(sortedList, data)
    end

    table.sort(sortedList, function(a, b)
        if a.Name:lower() == b.Name:lower() then
            return a.Weight < b.Weight
        end
        return a.Name:lower() < b.Name:lower()
    end)

    if #sortedList == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 40)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Text = "Tidak Ada Item di Backpack"
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.TextSize = 13
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.Parent = autoDropScroll
    else
        for _, data in ipairs(sortedList) do
            local dropItemFrame = Instance.new("Frame")
            dropItemFrame.Name = data.Name .. "DropFrame"
            dropItemFrame.Size = UDim2.new(1, -10, 0, 60)
            dropItemFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
            dropItemFrame.Parent = autoDropScroll

            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 6)
            frameCorner.Parent = dropItemFrame

            local frameStroke = Instance.new("UIStroke")
            frameStroke.Color = data.NonFav > 0 and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(55, 55, 65)
            frameStroke.Thickness = 1
            frameStroke.Parent = dropItemFrame

            local dNameLabel = Instance.new("TextLabel")
            dNameLabel.Name = "ItemName"
            dNameLabel.Size = UDim2.new(0.5, -5, 1, 0)
            dNameLabel.Position = UDim2.new(0, 8, 0, 0)
            dNameLabel.BackgroundTransparency = 1
            dNameLabel.Text = string.format("%s (⭐%d | 📦%d)\n⚖️ %s | 💵 %s\n🍀 %s", data.Name, data.Fav, data.NonFav, data.Weight, data.Value, data.Luck)
            dNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            dNameLabel.TextSize = 9
            dNameLabel.Font = Enum.Font.GothamMedium
            dNameLabel.TextXAlignment = Enum.TextXAlignment.Left
            dNameLabel.TextWrapped = true
            dNameLabel.Parent = dropItemFrame

            local dropBox = Instance.new("TextBox")
            dropBox.Name = "DropBox"
            dropBox.Size = UDim2.new(0, 40, 0, 24)
            dropBox.Position = UDim2.new(0.5, 5, 0.5, -12)
            dropBox.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
            dropBox.Text = "1"
            dropBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropBox.TextSize = 11
            dropBox.Font = Enum.Font.GothamBold
            dropBox.Parent = dropItemFrame

            local boxCorner = Instance.new("UICorner")
            boxCorner.CornerRadius = UDim.new(0, 4)
            boxCorner.Parent = dropBox

            local dropActionBtn = Instance.new("TextButton")
            dropActionBtn.Name = "DropActionBtn"
            dropActionBtn.Size = UDim2.new(0, 75, 0, 24)
            dropActionBtn.Position = UDim2.new(0.5, 50, 0.5, -12)
            dropActionBtn.BackgroundColor3 = data.NonFav > 0 and Color3.fromRGB(180, 40, 40) or Color3.fromRGB(60, 60, 70)
            dropActionBtn.Text = "🗑️ Drop"
            dropActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropActionBtn.TextSize = 10
            dropActionBtn.Font = Enum.Font.GothamBold
            dropActionBtn.Parent = dropItemFrame

            local actCorner = Instance.new("UICorner")
            actCorner.CornerRadius = UDim.new(0, 4)
            actCorner.Parent = dropActionBtn

            dropActionBtn.MouseButton1Click:Connect(function()
                if data.NonFav <= 0 then
                    showToast("Semua item favorit / 0 Non-Fav!")
                    return
                end
                local amount = tonumber(dropBox.Text) or 1
                executeAutoDrop(data.Name, data.Weight, data.Value, data.Luck, amount)
            end)
        end
    end

    autoDropScroll.CanvasSize = UDim2.new(0, 0, 0, autoDropLayout.AbsoluteContentSize.Y + 10)
end

refreshBpBtn.MouseButton1Click:Connect(function()
    refreshBackpackItems()
    showToast("Backpack Refreshed")
end)

refreshDropBtn.MouseButton1Click:Connect(function()
    refreshAutoDropList()
    showToast("List Drop Refreshed")
end)

bpSearch:GetPropertyChangedSignal("Text"):Connect(function()
    local query = bpSearch.Text:lower()
    for _, itemFrame in ipairs(backpackScroll:GetChildren()) do
        if itemFrame:IsA("Frame") then
            local nameLabel = itemFrame:FindFirstChild("ItemName")
            local statsLabelText = itemFrame:FindFirstChild("ItemStatsText")
            local fullText = (nameLabel and nameLabel.Text or "") .. " " .. (statsLabelText and statsLabelText.Text or "")
            itemFrame.Visible = (query == "" or string.find(fullText:lower(), query)) and true or false
        end
    end
end)

dropSearch:GetPropertyChangedSignal("Text"):Connect(function()
    local query = dropSearch.Text:lower()
    for _, itemFrame in ipairs(autoDropScroll:GetChildren()) do
        if itemFrame:IsA("Frame") then
            local nameLabel = itemFrame:FindFirstChild("ItemName")
            if nameLabel then
                itemFrame.Visible = (query == "" or string.find(nameLabel.Text:lower(), query)) and true or false
            end
        end
    end
end)

---------------------------------------------------------
-- NAVIGATION LOGIC
---------------------------------------------------------
runeMainBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = false
    runePage.Visible = true
    backpackPage.Visible = false
    autoDropPage.Visible = false
    backButton.Visible = true
end)

backpackMainBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = false
    runePage.Visible = false
    backpackPage.Visible = true
    autoDropPage.Visible = false
    backButton.Visible = true
    refreshBackpackItems()
end)

autoDropMainBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = false
    runePage.Visible = false
    backpackPage.Visible = false
    autoDropPage.Visible = true
    backButton.Visible = true
    refreshAutoDropList()
end)

backButton.MouseButton1Click:Connect(function()
    runePage.Visible = false
    backpackPage.Visible = false
    autoDropPage.Visible = false
    mainPage.Visible = true
    backButton.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    if autoPickupThread then task.cancel(autoPickupThread) end
    if noclipConnection then noclipConnection:Disconnect() end
    screenGui:Destroy()
end)

---------------------------------------------------------
-- MINIMIZE LOGIC
---------------------------------------------------------
local isMinimized = false
local originalSize = mainFrame.Size

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        originalSize = mainFrame.Size
        contentFrame.Visible = false
        resizeGrip.Visible = false
        minimizeButton.Text = "+"
        TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 40)
        }):Play()
    else
        minimizeButton.Text = "-"
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = originalSize
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isMinimized then
                contentFrame.Visible = true
                resizeGrip.Visible = true
            end
        end)
    end
end)

---------------------------------------------------------
-- RESIZE LOGIC
---------------------------------------------------------
local resizing = false
local resizeStart, startSize
local minSize = Vector2.new(260, 200)

resizeGrip.InputBegan:Connect(function(input)
    if not isMinimized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        resizing = true
        resizeStart = input.Position
        startSize = Vector2.new(mainFrame.AbsoluteSize.X, mainFrame.AbsoluteSize.Y)
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newWidth = math.max(minSize.X, startSize.X + delta.X)
        local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)
        mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

---------------------------------------------------------
-- RUNE SELECTION & EXECUTION ENGINE
---------------------------------------------------------
local function updateAllRuneButtonState()
    local allSelected = true
    for _, state in pairs(selectedRunes) do
        if not state then
            allSelected = false
            break
        end
    end

    if allSelected then
        allRuneBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        allRuneBtn.Text = "Deselect All"
    else
        allRuneBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
        allRuneBtn.Text = "All Rune"
    end
end

local function toggleRuneSelection(runeName, state)
    selectedRunes[runeName] = state
    local btn = runeButtons[runeName]
    btn.BackgroundColor3 = state and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(26, 26, 30)
    updateAllRuneButtonState()
end

for _, runeName in ipairs(runeList) do
    runeButtons[runeName].MouseButton1Click:Connect(function()
        toggleRuneSelection(runeName, not selectedRunes[runeName])
    end)
end

local isAllSelected = false
allRuneBtn.MouseButton1Click:Connect(function()
    isAllSelected = not isAllSelected
    for _, runeName in ipairs(runeList) do
        toggleRuneSelection(runeName, isAllSelected)
    end
    showToast(isAllSelected and "Selected All Runes" or "Deselected All Runes")
end)

executeBtn.MouseButton1Click:Connect(function()
    isExecuting = not isExecuting
    
    if isExecuting then
        local hasSelection = false
        for _, selected in pairs(selectedRunes) do
            if selected then
                hasSelection = true
                break
            end
        end

        if not hasSelection then
            isExecuting = false
            showToast("Pilih minimal 1 Rune!")
            return
        end

        executeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        executeBtn.Text = "Stop Execution"
        showToast("Execution Started")
        
        task.spawn(function()
            local event = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CrystalDropRequest")
            while isExecuting do
                if event then
                    for runeName, isSelected in pairs(selectedRunes) do
                        if isSelected then
                            event:FireServer(runeName .. " Rune")
                        end
                    end
                end
                task.wait(0.05)
            end
        end)
    else
        executeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        executeBtn.Text = "Execute Runes"
        showToast("Execution Stopped")
    end
end)

---------------------------------------------------------
-- CRYSTAL BUTTON LOGIC (RESET CHARACTER)
---------------------------------------------------------
local isCrystalLoaded = false
local resetGuiReference = nil

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
        if resetGuiReference then
            resetGuiReference.Enabled = not resetGuiReference.Enabled
        end
    end
end)

crystalBtn.MouseButton1Click:Connect(function()
    if isCrystalLoaded then return end
    isCrystalLoaded = true
    showToast("Crystal Dupe Loaded")

    local lastPosition = UDim2.new(0.5, -100, 0.5, -25)
    local resetCooldown = false

    local function showNotification()
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Try to Die detected",
                Text = "Adding 6 seconds cooldown to avoid anti-cheat...",
                Duration = 3
            })
        end)
    end

    local function createResetGui()
        local resetGui = Instance.new("ScreenGui")
        resetGui.Name = "ResetButtonGui"
        resetGui.Parent = player:WaitForChild("PlayerGui")
        resetGuiReference = resetGui

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 200, 0, 50)
        btn.Position = lastPosition
        btn.Text = "Reset Character"
        btn.BackgroundColor3 = Color3.fromRGB(255, 69, 58)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 20
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Parent = resetGui
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 12)
        uiCorner.Parent = btn

        local dragging, dragStart, startPos

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = btn.Position
            end
        end)

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                lastPosition = btn.Position
            end
        end)

        btn.MouseButton1Click:Connect(function()
            if resetCooldown then return end
            resetCooldown = true
            if player.Character then
                player.Character:BreakJoints()
            end
            task.wait(6) 
            resetCooldown = false
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                local newPosition = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
                TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPosition}):Play()
            end
        end)
    end

    local function createInfoGui()
        if UserInputService.TouchEnabled then
            createResetGui()
            return
        end

        local infoGui = Instance.new("ScreenGui")
        infoGui.Name = "InfoGui"
        infoGui.Parent = player:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 160)
        frame.Position = UDim2.new(0.5, -150, 0.5, -80)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.Parent = infoGui

        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 10)
        frameCorner.Parent = frame

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0.4, 0)
        textLabel.Position = UDim2.new(0, 0, 0.15, 0)
        textLabel.Text = "Press F to toggle"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 22
        textLabel.BackgroundTransparency = 1
        textLabel.Parent = frame

        local okButton = Instance.new("TextButton")
        okButton.Size = UDim2.new(0.5, 0, 0.28, 0)
        okButton.Position = UDim2.new(0.25, 0, 0.6, 0)
        okButton.Text = "OK"
        okButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
        okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        okButton.Font = Enum.Font.GothamBold
        okButton.TextSize = 18
        okButton.Parent = frame

        local okCorner = Instance.new("UICorner")
        okCorner.CornerRadius = UDim.new(0, 8)
        okCorner.Parent = okButton

        okButton.MouseButton1Click:Connect(function()
            infoGui:Destroy()
            createResetGui()
        end)
    end

    if game.PlaceId == 5901548022 then
        showNotification()
    end

    createInfoGui()
end)

---------------------------------------------------------
-- DRAGGABLE SCRIPT FOR TOP BAR
---------------------------------------------------------
local draggingBar, dragInputBar, dragStartBar, startPosBar

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingBar = true
        dragStartBar = input.Position
        startPosBar = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingBar = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputBar = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInputBar and draggingBar then
        local delta = input.Position - dragStartBar
        mainFrame.Position = UDim2.new(
            startPosBar.X.Scale, 
            startPosBar.X.Offset + delta.X, 
            startPosBar.Y.Scale, 
            startPosBar.Y.Offset + delta.Y
        )
    end
end)
