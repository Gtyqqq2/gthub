--[[
👾 gtyqqq Hub 👾 - complete ( fly lock / pull monster / kill aura / auto skill ) 
wait for update auto upgrade and rebirth
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("CurRemotes"):WaitForChild("MonsterEvent")

--================ GUI =================--
local mainGui = Instance.new("ScreenGui", game.CoreGui)
mainGui.ResetOnSpawn = false

local frame = Instance.new("Frame", mainGui)
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Position = UDim2.new(0.5, -160, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BackgroundTransparency = 0.1
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local gradMain = Instance.new("UIGradient", frame)
gradMain.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(117,164,206)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(123,201,201)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(224,138,175))
}
gradMain.Rotation = 45

--================ HEADER =================--
local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1,0,0,30)
header.Position = UDim2.new(0,0,0,0)
header.Text = "👾 gtyqqq hub 👾"
header.TextColor3 = Color3.fromRGB(255,255,255)
header.BackgroundTransparency = 1
header.Font = Enum.Font.GothamBold
header.TextSize = 18

--================ MENU =================--
local menu = Instance.new("Frame", frame)
menu.Size = UDim2.new(0,85,1,-40)
menu.Position = UDim2.new(0,10,0,40)
menu.BackgroundColor3 = Color3.fromRGB(25,25,25)
menu.BackgroundTransparency = 0.2
Instance.new("UICorner", menu)

local function makeButton(parent, text, y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9,0,0,45)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    return b
end

local btnAura = makeButton(menu,"Aura",15)
local btnTeleport = makeButton(menu,"Teleport",70)

--================ PAGE =================--
local pages = Instance.new("Frame", frame)
pages.Size = UDim2.new(1,-110,1,-40)
pages.Position = UDim2.new(0,100,0,40)
pages.BackgroundTransparency = 1

local pageAura = Instance.new("Frame", pages)
pageAura.Size = UDim2.new(1,0,1,0)
pageAura.BackgroundTransparency = 1

local pageTeleport = Instance.new("Frame", pages)
pageTeleport.Size = UDim2.new(1,0,1,0)
pageTeleport.BackgroundTransparency = 1
pageTeleport.Visible = false

--================ FLY LOCK UI =================--
local flyLockFrame = Instance.new("Frame", pageTeleport)
flyLockFrame.Size = UDim2.new(0.9,0,0,40)
flyLockFrame.Position = UDim2.new(0.05,0,0,10)
flyLockFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
Instance.new("UICorner", flyLockFrame)

local flyLockLabel = Instance.new("TextLabel", flyLockFrame)
flyLockLabel.Size = UDim2.new(0.7,0,1,0)
flyLockLabel.Position = UDim2.new(0,0,0,0)
flyLockLabel.Text = "Fly Lock(careful)"
flyLockLabel.TextColor3 = Color3.fromRGB(255,255,255)
flyLockLabel.BackgroundTransparency = 1
flyLockLabel.Font = Enum.Font.GothamBold
flyLockLabel.TextSize = 16
flyLockLabel.TextXAlignment = Enum.TextXAlignment.Left

local flyLockToggle = Instance.new("TextButton", flyLockFrame)
flyLockToggle.Size = UDim2.new(0.3,0,1,0)
flyLockToggle.Position = UDim2.new(0.7,0,0,0)
flyLockToggle.Text = "OFF"
flyLockToggle.BackgroundColor3 = Color3.fromRGB(100,100,100)
flyLockToggle.TextColor3 = Color3.new(1,1,1)
flyLockToggle.Font = Enum.Font.GothamBold
flyLockToggle.TextSize = 14
Instance.new("UICorner", flyLockToggle)

--================ AURA TOGGLE =================--
local toggle = Instance.new("TextButton", pageAura)
toggle.Size = UDim2.new(0.8,0,0,40)
toggle.Position = UDim2.new(0.1,0,0,10)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 15
Instance.new("UICorner", toggle)

--================ VALUES =================--
local range = 200
local speed = 0.01

--================ LABELS =================--
local label = Instance.new("TextLabel", pageAura)
label.Size = UDim2.new(1,0,0,25)
label.Position = UDim2.new(0,0,0,60)
label.Text = "Range: 200"
label.TextColor3 = Color3.fromRGB(0,255,100)
label.BackgroundTransparency = 1

local speedLabel = Instance.new("TextLabel", pageAura)
speedLabel.Size = UDim2.new(1,0,0,25)
speedLabel.Position = UDim2.new(0,0,0,115)
speedLabel.Text = "Speed: 0.01"
speedLabel.TextColor3 = Color3.fromRGB(255,200,0)
speedLabel.BackgroundTransparency = 1

--================ RANGE SLIDER =================--
local track = Instance.new("Frame", pageAura)
track.Size = UDim2.new(0.6,0,0,12)
track.Position = UDim2.new(0.05,0,0,85)
track.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", track)

local fill = Instance.new("Frame", track)
fill.Size = UDim2.new(1,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(255,0,0)
Instance.new("UICorner", fill)

local knob = Instance.new("Frame", track)
knob.Size = UDim2.new(0,18,0,18)
knob.AnchorPoint = Vector2.new(0.5,0.5)
knob.Position = UDim2.new(1,0,0.5,0)
knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", knob)

--================ SPEED SLIDER =================--
local speedTrack = Instance.new("Frame", pageAura)
speedTrack.Size = UDim2.new(0.6,0,0,12)
speedTrack.Position = UDim2.new(0.05,0,0,140)
speedTrack.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", speedTrack)

local speedFill = Instance.new("Frame", speedTrack)
speedFill.Size = UDim2.new(0,0,1,0)
speedFill.BackgroundColor3 = Color3.fromRGB(255,200,0)
Instance.new("UICorner", speedFill)

local speedKnob = Instance.new("Frame", speedTrack)
speedKnob.Size = UDim2.new(0,18,0,18)
speedKnob.AnchorPoint = Vector2.new(0.5,0.5)
speedKnob.Position = UDim2.new(0,0,0.5,0)
speedKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedKnob)

--================ INPUT =================--
local rangeBox = Instance.new("TextBox", pageAura)
rangeBox.Size = UDim2.new(0.25,-5,0,25)
rangeBox.Position = UDim2.new(0.7,0,0,78)
rangeBox.Text = "200"
rangeBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
rangeBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", rangeBox)

local speedBox = Instance.new("TextBox", pageAura)
speedBox.Size = UDim2.new(0.25,-5,0,25)
speedBox.Position = UDim2.new(0.7,0,0,133)
speedBox.Text = "0.01"
speedBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
speedBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedBox)

--================ FILTER =================--
rangeBox:GetPropertyChangedSignal("Text"):Connect(function()
    rangeBox.Text = rangeBox.Text:gsub("[^0-9]", "")
end)

speedBox:GetPropertyChangedSignal("Text"):Connect(function()
    speedBox.Text = speedBox.Text:gsub("[^0-9%.]", "")
end)

--================ FUNCTIONS =================--
local function setRange(n)
    n = math.clamp(n,0,200)
    range = n
    label.Text = "Range: "..n

    local rel = n/200
    knob.Position = UDim2.new(rel,0,0.5,0)
    fill.Size = UDim2.new(rel,0,1,0)

    rangeBox.Text = tostring(n)
end

local function setSpeed(n)
    n = math.clamp(n,0.01,0.1)
    speed = n
    speedLabel.Text = string.format("Speed: %.2f", n)

    local rel = (n-0.01)/0.09
    speedKnob.Position = UDim2.new(rel,0,0.5,0)
    speedFill.Size = UDim2.new(rel,0,1,0)

    speedBox.Text = string.format("%.2f", n)
end

--================ SLIDER DRAG =================--
local dragging = false
local draggingSpeed = false

local function updateRangeFromPos(x)
    local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
    setRange(math.floor(rel * 200))
end

local function updateSpeedFromPos(x)
    local rel = math.clamp((x - speedTrack.AbsolutePosition.X) / speedTrack.AbsoluteSize.X, 0, 1)
    setSpeed(0.01 + rel * 0.09)
end

local function inputBegan(input, target)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if target == track or target == knob or target == fill then
            dragging = true
            updateRangeFromPos(input.Position.X)
        end

        if target == speedTrack or target == speedKnob or target == speedFill then
            draggingSpeed = true
            updateSpeedFromPos(input.Position.X)
        end
    end
end

local function inputChanged(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            updateRangeFromPos(input.Position.X)
        end

        if draggingSpeed then
            updateSpeedFromPos(input.Position.X)
        end
    end
end

UserInputService.InputChanged:Connect(inputChanged)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        draggingSpeed = false
    end
end)

track.InputBegan:Connect(function(i) inputBegan(i, track) end)
fill.InputBegan:Connect(function(i) inputBegan(i, fill) end)
knob.InputBegan:Connect(function(i) inputBegan(i, knob) end)

speedTrack.InputBegan:Connect(function(i) inputBegan(i, speedTrack) end)
speedFill.InputBegan:Connect(function(i) inputBegan(i, speedFill) end)
speedKnob.InputBegan:Connect(function(i) inputBegan(i, speedKnob) end)

--================ INPUT APPLY =================--
rangeBox.FocusLost:Connect(function()
    local n = tonumber(rangeBox.Text) or range
    setRange(n)
end)

speedBox.FocusLost:Connect(function()
    local n = tonumber(speedBox.Text) or speed
    setSpeed(n)
end)

--================ AURA =================--
local enabled = false
local hrp

local function updateHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
end

updateHRP()
player.CharacterAdded:Connect(updateHRP)

task.spawn(function()
    while task.wait(speed) do
        if enabled and hrp then
            for _,m in pairs(workspace:GetDescendants()) do
                local h = m:FindFirstChildOfClass("Humanoid")
                local r = m:FindFirstChild("HumanoidRootPart")

                if h and r and h.Health > 0 then
                    if (hrp.Position - r.Position).Magnitude <= range then
                        pcall(function()
                            remote:FireServer("DamToMonster", m, {damtype="normal"})
                        end)
                    end
                end
            end
        end
    end
end)

toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggle.Text = enabled and "ON" or "OFF"
    toggle.BackgroundColor3 = enabled and Color3.fromRGB(255,0,0) or Color3.fromRGB(50,50,50)
end)

--================ TELEPORT BUTTON =================--
btnTeleport.MouseButton1Click:Connect(function()
    pageAura.Visible = false
    pageTeleport.Visible = true
end)

btnAura.MouseButton1Click:Connect(function()
    pageTeleport.Visible = false
    pageAura.Visible = true
end)

--================ FLY LOCK =================--

local flyEnabled = false
local high = 35
local baseCF = nil
local lockCF = nil

flyLockToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyLockToggle.Text = flyEnabled and "ON" or "OFF"
    flyLockToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(255,0,0) or Color3.fromRGB(100,100,100)

    if flyEnabled and hrp then
        baseCF = hrp.CFrame
        lockCF = baseCF + Vector3.new(0,high,0)
    else
        lockCF = nil
        baseCF = nil
    end
end)

--================ HIGH UI =================--

local highLabel = Instance.new("TextLabel", pageTeleport)
highLabel.Size = UDim2.new(1,0,0,25)
highLabel.Position = UDim2.new(0,0,0,50)
highLabel.Text = "High: 35"
highLabel.TextColor3 = Color3.fromRGB(0,170,255)
highLabel.BackgroundTransparency = 1

local highTrack = Instance.new("Frame", pageTeleport)
highTrack.Size = UDim2.new(0.6,0,0,12)
highTrack.Position = UDim2.new(0.05,0,0,75)
highTrack.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", highTrack)

local highFill = Instance.new("Frame", highTrack)
highFill.Size = UDim2.new(0,0,1,0)
highFill.BackgroundColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", highFill)

local highKnob = Instance.new("Frame", highTrack)
highKnob.Size = UDim2.new(0,18,0,18)
highKnob.AnchorPoint = Vector2.new(0.5,0.5)
highKnob.Position = UDim2.new(0,0,0.5,0)
highKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", highKnob)

local highBox = Instance.new("TextBox", pageTeleport)
highBox.Size = UDim2.new(0.25,-5,0,25)
highBox.Position = UDim2.new(0.7,0,0,68)
highBox.Text = "35"
highBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
highBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", highBox)

--================ LOGIC =================--

local function setHigh(n)
    n = math.clamp(n,10,50)
    high = n
    highLabel.Text = "High: "..n

    local rel = (n-10)/40
    highKnob.Position = UDim2.new(rel,0,0.5,0)
    highFill.Size = UDim2.new(rel,0,1,0)

    highBox.Text = tostring(n)

    if flyEnabled and baseCF then
        lockCF = baseCF + Vector3.new(0,high,0)
    end
end

local draggingHigh = false

local function updateHighFromPos(x)
    local rel = math.clamp((x - highTrack.AbsolutePosition.X) / highTrack.AbsoluteSize.X, 0, 1)
    setHigh(math.floor(10 + rel * 40))
end

local function startDrag(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingHigh = true
        updateHighFromPos(i.Position.X)
    end
end

highTrack.InputBegan:Connect(startDrag)
highFill.InputBegan:Connect(startDrag)
highKnob.InputBegan:Connect(startDrag)

UserInputService.InputChanged:Connect(function(i)
    if draggingHigh and i.UserInputType == Enum.UserInputType.MouseMovement then
        updateHighFromPos(i.Position.X)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingHigh = false
    end
end)

highBox.FocusLost:Connect(function()
    local n = tonumber(highBox.Text) or high
    setHigh(n)
end)

setHigh(35)

--================ APPLY =================--

RunService.RenderStepped:Connect(function()
    if flyEnabled and hrp and lockCF then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.Velocity = Vector3.zero
        hrp.CFrame = lockCF
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    updateHRP()

    if flyEnabled and hrp then
        baseCF = hrp.CFrame
        lockCF = baseCF + Vector3.new(0,high,0)
    end
end)
--================ MONSTER PULL =================--

local pullEnabled = false
local pullDistance = 21
local pullRange = 150

local pullFrame = Instance.new("Frame", pageTeleport)
pullFrame.Size = UDim2.new(0.9,0,0,40)
pullFrame.Position = UDim2.new(0.05,0,0,105)
pullFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
Instance.new("UICorner", pullFrame)

local pullLabel = Instance.new("TextLabel", pullFrame)
pullLabel.Size = UDim2.new(0.7,0,1,0)
pullLabel.BackgroundTransparency = 1
pullLabel.Text = "Monster Pull"
pullLabel.TextColor3 = Color3.new(1,1,1)
pullLabel.Font = Enum.Font.GothamBold
pullLabel.TextSize = 16
pullLabel.TextXAlignment = Enum.TextXAlignment.Left

local pullToggle = Instance.new("TextButton", pullFrame)
pullToggle.Size = UDim2.new(0.3,0,1,0)
pullToggle.Position = UDim2.new(0.7,0,0,0)
pullToggle.Text = "OFF"
pullToggle.BackgroundColor3 = Color3.fromRGB(100,100,100)
pullToggle.TextColor3 = Color3.new(1,1,1)
pullToggle.Font = Enum.Font.GothamBold
pullToggle.TextSize = 14
Instance.new("UICorner", pullToggle)

pullToggle.MouseButton1Click:Connect(function()
    pullEnabled = not pullEnabled
    pullToggle.Text = pullEnabled and "ON" or "OFF"
    pullToggle.BackgroundColor3 = pullEnabled and Color3.fromRGB(255,0,0) or Color3.fromRGB(100,100,100)
end)

-- 🔥 LOOP ดึงมอน
task.spawn(function()
    while task.wait(0.1) do
        if pullEnabled and hrp then
            local monsters = {}

            for _,m in pairs(workspace:GetDescendants()) do
                if m:IsA("Model") and not Players:GetPlayerFromCharacter(m) then
                    local h = m:FindFirstChildOfClass("Humanoid")
                    local r = m:FindFirstChild("HumanoidRootPart")

                    if h and r and h.Health > 0 then
                        if (hrp.Position - r.Position).Magnitude <= pullRange then
                            table.insert(monsters, r)
                        end
                    end
                end
            end

            local total = #monsters

            for i, r in ipairs(monsters) do
                if total > 0 then
                    local angle = (i / total) * math.pi * 2
                    local radius = 4

                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius

                    local targetCF = hrp.CFrame * CFrame.new(offsetX, 0, -pullDistance + offsetZ)

                    r.CFrame = targetCF
                    r.AssemblyLinearVelocity = Vector3.zero
                    r.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end
    end
end)

--================ ICON =================--
local iconGui = Instance.new("ScreenGui", game.CoreGui)
local icon = Instance.new("ImageButton", iconGui)
icon.Size = UDim2.new(0,80,0,40)
icon.Position = UDim2.new(0,20,0.5,-20)
icon.BackgroundColor3 = Color3.fromRGB(30,30,30)
icon.BackgroundTransparency = 0.1
icon.Image = "rbxassetid://7072719338"
icon.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", icon).CornerRadius = UDim.new(0,12)

local gradIcon = Instance.new("UIGradient", icon)
gradIcon.Color = gradMain.Color
gradIcon.Rotation = 45

local stroke = Instance.new("UIStroke", icon)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(80,80,80)
stroke.Transparency = 0.3

icon.Active = true
icon.Draggable = true

local visible = true
local tweenInfo = TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
local savedPosition = frame.Position
local savedSize = frame.Size

icon.MouseButton1Click:Connect(function()
    visible = not visible

    local pos = icon.AbsolutePosition
    local size = icon.AbsoluteSize

    local startPos = UDim2.new(0,pos.X,0,pos.Y)
    local startSize = UDim2.new(0,size.X,0,size.Y)

    if visible then
        mainGui.Enabled = true
        frame.Visible = true
        frame.Position = startPos
        frame.Size = startSize

        TweenService:Create(frame,tweenInfo,{
            Position = savedPosition,
            Size = savedSize
        }):Play()
    else
        savedPosition = frame.Position
        savedSize = frame.Size

        local t = TweenService:Create(frame,tweenInfo,{
            Position = startPos,
            Size = startSize
        })

        t:Play()
        t.Completed:Connect(function()
            frame.Visible = false
            mainGui.Enabled = false
        end)
    end
end)

--================ AUTO MENU (เพิ่มใหม่) =================--

local btnAuto = makeButton(menu,"Auto",125)

local pageAuto = Instance.new("Frame", pages)
pageAuto.Size = UDim2.new(1,0,1,0)
pageAuto.BackgroundTransparency = 1
pageAuto.Visible = false

--================ AUTO SKILL GUI =================--
-- ใช้ GUI แบบเก่าสวย + Auto Skill กดติดจริง
local autoSkillLabel = Instance.new("TextLabel", pageAuto)
autoSkillLabel.Size = UDim2.new(1,0,0,25)
autoSkillLabel.Position = UDim2.new(0,50,0,10)
autoSkillLabel.Text = "auto skill"
autoSkillLabel.TextColor3 = Color3.fromRGB(255,255,255)
autoSkillLabel.BackgroundTransparency = 1
autoSkillLabel.Font = Enum.Font.GothamBold
autoSkillLabel.TextSize = 16
autoSkillLabel.TextXAlignment = Enum.TextXAlignment.Left

local buttonsFrame = Instance.new("Frame", pageAuto)
buttonsFrame.Size = UDim2.new(1,0,0,40)
buttonsFrame.Position = UDim2.new(0,0,0,40)
buttonsFrame.BackgroundTransparency = 1

local skills = {"Q","E","R","F"}
local skillToggles = {}

for i, skill in ipairs(skills) do
    local btn = Instance.new("TextButton", buttonsFrame)
    btn.Size = UDim2.new(0.2, -5,1,0)
    btn.Position = UDim2.new(0.2*(i-1), 5, 0,0)
    btn.Text = skill.." OFF"
    btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    skillToggles[skill] = false

    btn.MouseButton1Click:Connect(function()
        skillToggles[skill] = not skillToggles[skill]
        btn.Text = skill..(skillToggles[skill] and " ON" or " OFF")
        btn.BackgroundColor3 = skillToggles[skill] and Color3.fromRGB(255,0,0) or Color3.fromRGB(100,100,100)
    end)
end

--================ AUTO SKILL LOOP =================--
task.spawn(function()
    local VirtualInput = game:GetService("VirtualInputManager") -- สำหรับกดสกิลจริง
    while task.wait(0.1) do
        local char = player.Character
        if char then
            for skill, enabled in pairs(skillToggles) do
                if enabled then
                    pcall(function()
                        -- กดปุ่มจริง
                        VirtualInput:SendKeyEvent(true, skill, false, game)
                        VirtualInput:SendKeyEvent(false, skill, false, game)
                    end)
                end
            end
        end
    end
end)

--================ FIX MENU =================--

btnAuto.MouseButton1Click:Connect(function()
    pageAura.Visible = false
    pageTeleport.Visible = false
    pageAuto.Visible = true
end)

btnTeleport.MouseButton1Click:Connect(function()
    pageAura.Visible = false
    pageAuto.Visible = false
    pageTeleport.Visible = true
end)

btnAura.MouseButton1Click:Connect(function()
    pageTeleport.Visible = false
    pageAuto.Visible = false
    pageAura.Visible = true
end)

print("👾 FINAL PERFECT MAX LOADED 🔥")
