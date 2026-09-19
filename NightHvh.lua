-- NIGHTFALL GUI
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Config={
    SilentAim=false, FOV=150, Wallbang=false,
    Tracers=false, ESP=false, ThirdPerson=false, CamDist=11,
    Hitbox=false, HitboxSize=2, Night=false, CustomScope=true,
    Atmosphere=false, ATMDensity=40,
    Spinbot=false, HitSound=false, SoundId="rbxassetid://4817809188",
}

local OldLighting={
    Ambient=Lighting.Ambient, OutdoorAmbient=Lighting.OutdoorAmbient,
    Brightness=Lighting.Brightness, ClockTime=Lighting.ClockTime,
    FogEnd=Lighting.FogEnd, FogStart=Lighting.FogStart,
    GlobalShadows=Lighting.GlobalShadows,
    Sky=Lighting:FindFirstChildOfClass("Sky"),
}

local PU=Color3.fromRGB(160,50,255)
local WH=Color3.fromRGB(255,255,255)
local GL=Color3.fromRGB(240,240,240)
local GM=Color3.fromRGB(140,140,140)
local GD=Color3.fromRGB(90,90,90)

local function GetContainer()
    local success, result = pcall(function()
        if gethui then return gethui() end
        if syn and syn.protect_gui then return CoreGui end
        return LP:FindFirstChildOfClass("PlayerGui") or CoreGui
    end)
    return success and result or CoreGui
end

local TargetContainer = GetContainer()
if TargetContainer:FindFirstChild("NightFallWexsideUI") then
    TargetContainer.NightFallWexsideUI:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "NightFallWexsideUI"
Gui.Parent = TargetContainer
Gui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "OpenToggle"
ToggleBtn.Parent = Gui
ToggleBtn.Size = UDim2.new(0, 35, 0, 35)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = GL
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(40, 40, 40)
ToggleStroke.Thickness = 1

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Gui
Main.Size = UDim2.new(0, 600, 0, 390)
Main.Position = UDim2.new(0.5, -300, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = Main
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 8)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.ZIndex = 10

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Logo = Instance.new("TextLabel")
Logo.Parent = Sidebar
Logo.Size = UDim2.new(1, -20, 0, 40)
Logo.Position = UDim2.new(0, 15, 0, 15)
Logo.BackgroundTransparency = 1
Logo.Text = "NIGHTFALL\nVERSION-1.0"
Logo.TextColor3 = GL
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 13
Logo.TextXAlignment = Enum.TextXAlignment.Left

local Separator = Instance.new("Frame")
Separator.Parent = Sidebar
Separator.Size = UDim2.new(1, -30, 0, 1)
Separator.Position = UDim2.new(0, 15, 0, 60)
Separator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Separator.BorderSizePixel = 0

local TabHolder = Instance.new("Frame")
TabHolder.Parent = Sidebar
TabHolder.Size = UDim2.new(1, 0, 0, 240)
TabHolder.Position = UDim2.new(0, 0, 0, 70)
TabHolder.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabHolder
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)

local ProfileFrame = Instance.new("Frame")
ProfileFrame.Parent = Sidebar
ProfileFrame.Size = UDim2.new(1, -30, 0, 40)
ProfileFrame.Position = UDim2.new(0, 15, 1, -50)
ProfileFrame.BackgroundTransparency = 1

local ProfileName = Instance.new("TextLabel")
ProfileName.Parent = ProfileFrame
ProfileName.Size = UDim2.new(1, 0, 0, 16)
ProfileName.Position = UDim2.new(0, 0, 0, 2)
ProfileName.BackgroundTransparency = 1
ProfileName.Text = LP.Name
ProfileName.TextColor3 = Color3.fromRGB(220, 220, 220)
ProfileName.Font = Enum.Font.GothamBold
ProfileName.TextSize = 11
ProfileName.TextXAlignment = Enum.TextXAlignment.Left

local ProfileTill = Instance.new("TextLabel")
ProfileTill.Parent = ProfileFrame
ProfileTill.Size = UDim2.new(1, 0, 0, 14)
ProfileTill.Position = UDim2.new(0, 0, 0, 20)
ProfileTill.BackgroundTransparency = 1
ProfileTill.Text = "Till: Lifetime"
ProfileTill.TextColor3 = Color3.fromRGB(110, 110, 110)
ProfileTill.Font = Enum.Font.Gotham
ProfileTill.TextSize = 10
ProfileTill.TextXAlignment = Enum.TextXAlignment.Left

local ContentHolder = Instance.new("Frame")
ContentHolder.Parent = Main
ContentHolder.Size = UDim2.new(1, -150, 1, 0)
ContentHolder.Position = UDim2.new(0, 150, 0, 0)
ContentHolder.BackgroundTransparency = 1

local Pages = {}
local TabBtns = {}

local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 18)

    local title = Instance.new("TextLabel")
    title.Parent = btn
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(120, 120, 120)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left

    local page = Instance.new("Frame")
    page.Parent = ContentHolder
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    local leftCol = Instance.new("ScrollingFrame", page)
    leftCol.Name = "LeftCol"
    leftCol.Size = UDim2.new(0.5, -15, 1, -20)
    leftCol.Position = UDim2.new(0, 10, 0, 10)
    leftCol.BackgroundTransparency = 1
    leftCol.ScrollBarThickness = 0
    leftCol.CanvasSize = UDim2.new(0,0,0,0)
    leftCol.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local rightCol = Instance.new("ScrollingFrame", page)
    rightCol.Name = "RightCol"
    rightCol.Size = UDim2.new(0.5, -15, 1, -20)
    rightCol.Position = UDim2.new(0.5, 5, 0, 10)
    rightCol.BackgroundTransparency = 1
    rightCol.ScrollBarThickness = 0
    rightCol.CanvasSize = UDim2.new(0,0,0,0)
    rightCol.AutomaticCanvasSize = Enum.AutomaticSize.Y

    Instance.new("UIListLayout", leftCol).Padding = UDim.new(0, 10)
    Instance.new("UIListLayout", rightCol).Padding = UDim.new(0, 10)

    Pages[name] = page
    TabBtns[name] = title

    btn.MouseButton1Click:Connect(function()
        for pName, pFrame in pairs(Pages) do
            pFrame.Visible = false
        end
        for tName, tTitle in pairs(TabBtns) do
            TweenService:Create(tTitle, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(120, 120, 120)}):Play()
        end
        page.Visible = true
        TweenService:Create(title, TweenInfo.new(0.2), {TextColor3 = GL}):Play()
    end)

    return leftCol, rightCol
end

local CombatL,CombatR = CreateTab("Combat")
local VisualsL,VisualsR = CreateTab("Visuals")
local HUDL,HUDR = CreateTab("HUD")
local MovementL,MovementR = CreateTab("Movement")
local PlayerL,PlayerR = CreateTab("Player")

Pages["Combat"].Visible = true
TabBtns["Combat"].TextColor3 = GL

local isOpen = true
local originalSize = UDim2.new(0, 600, 0, 390)
local originalPos = UDim2.new(0.5, -300, 0.5, -195)

local function OpenMenu()
    isOpen = true
    Main.Visible = true
    Main.Size = UDim2.new(0, 540, 0, 350)
    Main.Position = UDim2.new(0.5, -270, 0.5, -175)
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = originalSize,
        Position = originalPos
    }):Play()
    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.2)
    ToggleBtn.Visible = false
end

local function CloseMenu()
    isOpen = false
    ToggleBtn.Size = UDim2.new(0, 0, 0, 0)
    ToggleBtn.Visible = true
    TweenService:Create(ToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 35, 0, 35)}):Play()
    local tween = TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 540, 0, 350),
        Position = UDim2.new(0.5, -270, 0.5, -175)
    })
    tween:Play()
    tween.Completed:Connect(function()
        if not isOpen then
            Main.Visible = false
        end
    end)
end

MinimizeBtn.MouseButton1Click:Connect(CloseMenu)
ToggleBtn.MouseButton1Click:Connect(OpenMenu)
OpenMenu()

-- ===== ЭЛЕМЕНТЫ =====
local function Desc(parent,text)
    local d=Instance.new("TextLabel",parent)
    d.Size=UDim2.new(1,0,0,16)
    d.BackgroundTransparency=1
    d.Text=text
    d.TextColor3=GD
    d.Font=Enum.Font.Gotham
    d.TextSize=10
    d.TextXAlignment=Enum.TextXAlignment.Left
end

local function Toggle(parent,text,default,cb)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,0,0,32)
    b.BackgroundColor3=Color3.fromRGB(24,24,24)
    b.Text="" b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local l=Instance.new("TextLabel",b)
    l.Size=UDim2.new(1,-50,1,0)
    l.Position=UDim2.new(0,12,0,0)
    l.BackgroundTransparency=1
    l.Text=text
    l.TextColor3=GM
    l.Font=Enum.Font.GothamBold
    l.TextSize=11
    l.TextXAlignment=Enum.TextXAlignment.Left
    local ind=Instance.new("Frame",b)
    ind.Size=UDim2.new(0,28,0,14)
    ind.Position=UDim2.new(1,-40,0.5,-7)
    ind.BackgroundColor3=Color3.fromRGB(40,40,40)
    ind.BorderSizePixel=0
    Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
    local dot=Instance.new("Frame",ind)
    dot.Size=UDim2.new(0,10,0,10)
    dot.Position=UDim2.new(0,2,0.5,-5)
    dot.BackgroundColor3=GL
    dot.BorderSizePixel=0
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local state=default
    local function update()
        if state then
            ind.BackgroundColor3=Color3.fromRGB(90,90,100)
            dot.Position=UDim2.new(1,-12,0.5,-5)
            l.TextColor3=GL
        else
            ind.BackgroundColor3=Color3.fromRGB(40,40,40)
            dot.Position=UDim2.new(0,2,0.5,-5)
            l.TextColor3=GM
        end
    end
    update()
    b.MouseButton1Click:Connect(function()
        state=not state
        update()
        if cb then cb(state) end
    end)
end

local function Slider(parent,text,mn,mx,dv,cb)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,42)
    f.BackgroundColor3=Color3.fromRGB(24,24,24)
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
    local l=Instance.new("TextLabel",f)
    l.Size=UDim2.new(1,-20,0,20)
    l.Position=UDim2.new(0,12,0,2)
    l.BackgroundTransparency=1
    l.Text=text..": "..dv
    l.TextColor3=GM
    l.Font=Enum.Font.GothamBold
    l.TextSize=11
    l.TextXAlignment=Enum.TextXAlignment.Left
    local b=Instance.new("Frame",f)
    b.Size=UDim2.new(1,-24,0,4)
    b.Position=UDim2.new(0,12,1,-12)
    b.BackgroundColor3=Color3.fromRGB(40,40,40)
    b.BorderSizePixel=0
    Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
    local fl=Instance.new("Frame",b)
    local ip=(dv-mn)/(mx-mn)
    fl.Size=UDim2.new(ip,0,1,0)
    fl.BackgroundColor3=PU
    fl.BorderSizePixel=0
    Instance.new("UICorner",fl).CornerRadius=UDim.new(1,0)
    local bt=Instance.new("TextButton",b)
    bt.Size=UDim2.new(0,16,0,16)
    bt.Position=UDim2.new(ip,-8,0.5,-8)
    bt.BackgroundColor3=Color3.fromRGB(220,200,255)
    bt.Text=""
    Instance.new("UICorner",bt).CornerRadius=UDim.new(1,0)
    local dr=false
    bt.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dr and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local p=math.clamp((i.Position.X-b.AbsolutePosition.X)/b.AbsoluteSize.X,0,1)
            local v=math.floor((mx-mn)*p+mn+0.5)
            fl.Size=UDim2.new(p,0,1,0)
            bt.Position=UDim2.new(p,-8,0.5,-8)
            l.Text=text..": "..v
            if cb then cb(v) end
        end
    end)
end
-- ===== COMBAT =====
Desc(CombatL,"Silent Aim — стрельба в голову в FOV")
Toggle(CombatL,"Silent Aim",false,function(v) Config.SilentAim=v end)
Desc(CombatL,"FOV — радиус поиска")
Slider(CombatL,"FOV",20,400,150,function(v) Config.FOV=v end)

Desc(CombatR,"Wallbang — стрельба через стены")
Toggle(CombatR,"Wallbang",false,function(v) Config.Wallbang=v end)

-- ===== VISUALS =====
Desc(VisualsL,"Bullet Tracers — фиолетовые трассеры")
Toggle(VisualsL,"Bullet Tracers",false,function(v) Config.Tracers=v end)
Desc(VisualsL,"ESP — боксы + имена")
Toggle(VisualsL,"ESP",false,function(v) Config.ESP=v end)
Desc(VisualsL,"Hitbox — прозрачная голова")
Toggle(VisualsL,"Hitbox",false,function(v) Config.Hitbox=v end)
Slider(VisualsL,"Hitbox Size",1,16,2,function(v) Config.HitboxSize=v end)

Desc(VisualsR,"Night — ночное небо")
Toggle(VisualsR,"Night",false,function(v) Config.Night=v SetNight(v) end)
Desc(VisualsR,"Custom Scope — свой прицел")
Toggle(VisualsR,"Custom Scope",true,function(v) Config.CustomScope=v end)
Desc(VisualsR,"Atmosphere — туман как CS:GO")
Toggle(VisualsR,"Atmosphere",false,function(v) Config.Atmosphere=v SetAtm(v) end)
Slider(VisualsR,"ATM Density",1,100,40,function(v) Config.ATMDensity=v if Config.Atmosphere then SetAtm(true) end end)

-- ===== HUD =====
Desc(HUDL,"Hit Sound — звук попадания")
Toggle(HUDL,"Hit Sound",false,function(v) Config.HitSound=v end)
Desc(HUDL,"Spinbot — вращение")
Toggle(HUDL,"Spinbot",false,function(v) Config.Spinbot=v end)

-- ===== MOVEMENT =====
Desc(MovementL,"Third Person — вид от 3-го лица")
Toggle(MovementL,"Third Person",false,function(v) Config.ThirdPerson=v end)
Slider(MovementL,"Cam Distance",5,20,11,function(v) Config.CamDist=v end)

-- ===== PLAYER =====
Desc(PlayerL,"Информация")
local InfoLbl=Instance.new("TextLabel",PlayerL)
InfoLbl.Size=UDim2.new(1,0,0,60)
InfoLbl.BackgroundColor3=Color3.fromRGB(24,24,24)
InfoLbl.Text="NightFall v1.0\nby gradient.pub"
InfoLbl.TextColor3=GM
InfoLbl.Font=Enum.Font.Gotham
InfoLbl.TextSize=11
InfoLbl.TextWrapped=true
Instance.new("UICorner",InfoLbl).CornerRadius=UDim.new(0,6)
-- ===== SILENT AIM =====
local RaycastModule,BulletModule,GetRayIgnore
pcall(function()
    RaycastModule=require(RS:WaitForChild("Shared",5):WaitForChild("Raycast",5))
    BulletModule=require(RS:WaitForChild("Components",5):WaitForChild("Weapon",5):WaitForChild("Classes",5):WaitForChild("Bullet",5))
    GetRayIgnore=require(RS:WaitForChild("Components",5):WaitForChild("Common",5):WaitForChild("GetRayIgnore",5))
end)

local target=nil
local targetCache=nil
local cacheTime=0
local isProcessing=false
local originalPerformRaycast=nil
local originalCreate=nil

if BulletModule then
    originalPerformRaycast=BulletModule._performRaycast
    originalCreate=BulletModule.create
end

local function GetClosestPlayer()
    local ct=tick()
    if ct-cacheTime<0.033 then return targetCache end
    local cd=Config.FOV
    local cl=nil
    local cam=Workspace.CurrentCamera
    if not cam then return nil end
    local mt=LP:GetAttribute("Team")
    if not LP.Character then return nil end
    local center=cam.ViewportSize/2
    for _,v in pairs(Players:GetPlayers()) do
        if v==LP then continue end
        local char=v.Character
        if not char or char:GetAttribute("Dead") then continue end
        if v:GetAttribute("Team")==mt then continue end
        local head=char:FindFirstChild("Head")
        if not head then continue end
        local sp,on=cam:WorldToViewportPoint(head.Position)
        if not on then continue end
        local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
        if d<cd then cd=d cl=head end
    end
    targetCache=cl
    cacheTime=ct
    return cl
end

RunService.RenderStepped:Connect(function()
    if not Config.SilentAim then target=nil return end
    target=GetClosestPlayer()
end)

if BulletModule and RaycastModule and GetRayIgnore then
    BulletModule._performRaycast=function(self,spreadAngle)
        if not Config.SilentAim and not Config.Wallbang then
            return originalPerformRaycast(self,spreadAngle)
        end
        if isProcessing then return originalPerformRaycast(self,spreadAngle) end
        local ok,res=pcall(function()
            local cam=Workspace.CurrentCamera
            if not cam then return originalPerformRaycast(self,spreadAngle) end
            local vp=cam.ViewportSize*0.5
            local ray=cam:ViewportPointToRay(vp.X,vp.Y)
            local origin=ray.Origin
            local dir=ray.Direction
            local maxR=self.Properties.Range or 500
            if Config.SilentAim and target then
                local hp=target.Position
                local nd=(hp-origin)
                local d=nd.Magnitude
                if d>maxR then nd=nd.Unit*maxR d=maxR end
                return {Origin=origin,Direction=nd.Unit,Distance=d,
                    Hits={{Position=hp,Instance=target,Material="Plastic",Normal=Vector3.new(0,0,0),Exit=false}}}
            end
            if Config.Wallbang then
                local ri=GetRayIgnore()
                local tr=RaycastModule.castThrough(origin,dir.Unit,maxR,ri)
                if tr and #tr>0 then
                    local hits={}
                    for _,hit in ipairs(tr) do
                        table.insert(hits,{Position=hit.position or (origin+dir.Unit*maxR),
                            Instance=hit.instance,Material=hit.material and hit.material.Name or "Plastic",
                            Normal=hit.normal or Vector3.new(0,0,0),Exit=false})
                    end
                    return {Origin=origin,Direction=dir.Unit,Distance=maxR,Hits=hits}
                end
            end
            return originalPerformRaycast(self,spreadAngle)
        end)
        if ok then return res end
        return originalPerformRaycast(self,spreadAngle)
    end

    BulletModule.create=function(self,aimMode,isScoped)
        if not Config.SilentAim and not Config.Wallbang then
            return originalCreate(self,aimMode,isScoped)
        end
        if isProcessing then return originalCreate(self,aimMode,isScoped) end
        local ok,res=pcall(function()
            local cam=Workspace.CurrentCamera
            if not cam then return originalCreate(self,aimMode,isScoped) end
            local vp=cam.ViewportSize*0.5
            local ray=cam:ViewportPointToRay(vp.X,vp.Y)
            local origin=ray.Origin
            local dir=ray.Direction
            local maxR=self.Properties.Range or 500
            if Config.SilentAim and target then
                local hp=target.Position
                local nd=(hp-origin)
                local d=nd.Magnitude
                if d<=maxR then
                    return {Origin=origin,Direction=nd.Unit,Distance=d,
                        Hits={{Position=hp,Instance=target,Material="Plastic",Normal=Vector3.new(0,0,0),Exit=false}}}
                end
            end
            if Config.Wallbang then
                local ri=GetRayIgnore()
                local tr=RaycastModule.castThrough(origin,dir.Unit,maxR,ri)
                if tr and #tr>0 then
                    local hits={}
                    for _,hit in ipairs(tr) do
                        table.insert(hits,{Position=hit.position or (origin+dir.Unit*maxR),
                            Instance=hit.instance,Material=hit.material and hit.material.Name or "Plastic",
                            Normal=hit.normal or Vector3.new(0,0,0),Exit=false})
                    end
                    return {Origin=origin,Direction=dir.Unit,Distance=maxR,Hits=hits}
                end
            end
            return originalCreate(self,aimMode,isScoped)
        end)
        if ok then return res end
        return originalCreate(self,aimMode,isScoped)
    end
end

-- ===== TRACERS =====
local lastTracer=0
local function CreateTracer(s,e)
    local d=(s-e).Magnitude
    if d<3 then return end
    local mid=s:Lerp(e,0.5)
    local model=Instance.new("Model")
    local core=Instance.new("Part")
    core.Anchored=true core.CanCollide=false
    core.Material=Enum.Material.ForceField
    core.Color=PU core.Transparency=0.5
    core.Size=Vector3.new(d,0.06,0.06)
    core.CFrame=CFrame.new(mid)*CFrame.lookAt(s,e).Rotation*CFrame.Angles(0,math.rad(90),0)
    core.Shape=Enum.PartType.Cylinder
    core.Parent=model
    local glow=Instance.new("Part")
    glow.Anchored=true glow.CanCollide=false
    glow.Material=Enum.Material.Neon
    glow.Color=PU glow.Transparency=0.75
    glow.Size=Vector3.new(d,0.18,0.18)
    glow.CFrame=core.CFrame
    glow.Shape=Enum.PartType.Cylinder
    glow.Parent=model
    model.Parent=Workspace
    local imp=Instance.new("Part")
    imp.Anchored=true imp.CanCollide=false
    imp.Material=Enum.Material.Neon
    imp.Color=PU imp.Shape=Enum.PartType.Ball
    imp.Size=Vector3.new(0.5,0.5,0.5)
    imp.CFrame=CFrame.new(e)
    imp.Transparency=0.3
    imp.Parent=model
    TweenService:Create(imp,TweenInfo.new(3),{Size=Vector3.new(0.01,0.01,0.01),Transparency=1}):Play()
    TweenService:Create(core,TweenInfo.new(3),{Transparency=1,Size=Vector3.new(d,0,0)}):Play()
    TweenService:Create(glow,TweenInfo.new(3),{Transparency=1,Size=Vector3.new(d,0,0)}):Play()
    Debris:AddItem(model,3.1)
end

local lastSound=0
local function PlaySound()
    local s=Instance.new("Sound")
    s.SoundId=Config.SoundId
    s.Volume=2.5
    s.Parent=Workspace
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local oldNC
oldNC=hookmetamethod(game,"__namecall",function(self,...)
    local m=getnamecallmethod()
    local a={...}
    if not checkcaller() and (m=="FireServer" or m=="InvokeServer") then
        local n=tostring(self.Name):lower()
        if not n:find("cam") and not n:find("look") and not n:find("move") and not n:find("walk") and not n:find("step") and not n:find("rotate") then
            if n:find("shoot") or n:find("fire") or n:find("bullet") or n:find("shot") or n:find("gun") then
                if Config.HitSound then
                    local t=tick()
                    if t-lastSound>=0.1 then lastSound=t task.spawn(PlaySound) end
                end
                if Config.Tracers then
                    local t=tick()
                    if t-lastTracer>=0.05 then
                        lastTracer=t
                        local cp=Camera.CFrame.Position
                        local sp=cp+(Camera.CFrame.LookVector*1.8)+(Camera.CFrame.RightVector*0.55)-(Camera.CFrame.UpVector*0.4)
                        local tp=nil
                        for _,arg in ipairs(a) do
                            if typeof(arg)=="Vector3" then
                                if (arg-cp).Magnitude>5 and (arg-cp).Magnitude<3500 then tp=arg break end
                            elseif typeof(arg)=="Instance" and arg:IsA("BasePart") then
                                if arg.Parent~=LP.Character then tp=arg.Position break end
                            end
                        end
                        if not tp then tp=sp+(Camera.CFrame.LookVector*500) end
                        task.spawn(CreateTracer,sp,tp)
                    end
                end
            end
        end
    end
    return oldNC(self,...)
end)

-- ===== LOOPS =====
RunService.RenderStepped:Connect(function()
    if Config.Spinbot then
        local c=LP.Character
        if c then
            local r=c:FindFirstChild("HumanoidRootPart")
            if r then r.CFrame=CFrame.new(r.Position)*CFrame.Angles(0,math.rad((tick()*2000)%360),0) end
        end
    end
    if Config.ThirdPerson then
        local c=LP.Character
        if c then
            local h=c:FindFirstChild("Head")
            for _,p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.LocalTransparencyModifier=0 end
            end
            if h then
                LP.CameraMinZoomDistance=Config.CamDist
                LP.CameraMaxZoomDistance=20
                if (Camera.CFrame.Position-h.Position).Magnitude<4 then
                    Camera.CFrame=Camera.CFrame+(Camera.CFrame.LookVector*-Config.CamDist)+Vector3.new(0,3,0)
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if Config.Hitbox then
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP then
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Head")
                    if h then
                        h.Size=Vector3.new(2,1,1)*Config.HitboxSize
                        h.Massless=true
                        h.Transparency=0.3
                    end
                end
            end
        end
    end
end)

-- ===== NIGHT =====
local NightSky
function SetNight(on)
    if on then
        local os=Lighting:FindFirstChildOfClass("Sky")
        if os then os.Parent=nil end
        if not NightSky then
            NightSky=Instance.new("Sky")
            NightSky.SkyboxBk="rbxassetid://159454299"
            NightSky.SkyboxDn="rbxassetid://159454296"
            NightSky.SkyboxFt="rbxassetid://159454293"
            NightSky.SkyboxLf="rbxassetid://159454286"
            NightSky.SkyboxRt="rbxassetid://159454300"
            NightSky.SkyboxUp="rbxassetid://159454288"
            NightSky.SunTextureId="rbxassetid://0"
            NightSky.MoonTextureId="rbxassetid://0"
            NightSky.StarCount=3000
        end
        NightSky.Parent=Lighting
    else
        if NightSky then NightSky.Parent=nil end
        if OldLighting.Sky then OldLighting.Sky.Parent=Lighting end
    end
end

RunService.Heartbeat:Connect(function()
    if Config.Night then
        Lighting.Ambient=Color3.fromRGB(80,80,100)
        Lighting.OutdoorAmbient=Color3.fromRGB(90,90,110)
        Lighting.Brightness=2
        Lighting.ClockTime=0
        Lighting.FogEnd=2000
        Lighting.FogStart=200
        Lighting.GlobalShadows=true
    end
end)

-- ===== ATMOSPHERE =====
local ATMObj=nil
function SetAtm(on)
    if on then
        if not ATMObj then
            ATMObj=Instance.new("Atmosphere")
            ATMObj.Name="CSGO_Atm"
        end
        ATMObj.Density=Config.ATMDensity/100
        ATMObj.Offset=0
        ATMObj.Color=Color3.fromRGB(120,140,180)
        ATMObj.Decay=Color3.fromRGB(60,70,100)
        ATMObj.Glare=0.5
        ATMObj.Haze=1.5
        ATMObj.Parent=Lighting
    else
        if ATMObj then ATMObj.Parent=nil end
    end
end

-- ===== ESP =====
local Cont=CoreGui:FindFirstChild("ESPGui") or Instance.new("ScreenGui")
Cont.Name="ESPGui" Cont.ResetOnSpawn=false Cont.DisplayOrder=9999 Cont.Parent=CoreGui
local EspObj={}

local function ESP(player)
    if player==LP or EspObj[player] then return end
    local function Setup(char)
        if not char then return end
        local bg=Instance.new("BillboardGui",Cont)
        bg.Size=UDim2.new(4,0,5.5,0) bg.AlwaysOnTop=true bg.MaxDistance=2500
        local f=Instance.new("Frame",bg)
        f.Size=UDim2.new(1,0,1,0) f.BackgroundTransparency=1
        local st=Instance.new("UIStroke",f)
        st.Thickness=2.5 st.Color=PU
        st.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        local ng=Instance.new("BillboardGui",Cont)
        ng.Size=UDim2.new(4,0,1.2,0)
        ng.StudsOffset=Vector3.new(0,3.4,0)
        ng.AlwaysOnTop=true
        ng.MaxDistance=2500
        local nl=Instance.new("TextLabel",ng)
        nl.Size=UDim2.new(1,0,1,0)
        nl.BackgroundTransparency=1
        nl.Text=player.Name
        nl.TextScaled=true
        nl.TextColor3=Color3.fromRGB(230,200,255)
        nl.TextStrokeTransparency=0.2
        EspObj[player]={bg=bg,ng=ng}
        local conn
        conn=RunService.RenderStepped:Connect(function()
            if not Config.ESP then
                bg.Enabled=false
                ng.Enabled=false
                return
            end
            bg.Enabled=true
            ng.Enabled=true
            local r=char:FindFirstChild("HumanoidRootPart")
            local hum=char:FindFirstChildOfClass("Humanoid")
            if not char.Parent or not r or (hum and hum.Health<=0) then
                bg:Destroy()
                ng:Destroy()
                EspObj[player]=nil
                conn:Disconnect()
                return
            end
            bg.Adornee=r
            ng.Adornee=r
        end)
    end
    player.CharacterAdded:Connect(Setup)
    if player.Character then Setup(player.Character) end
end

for _,p in pairs(Players:GetPlayers()) do ESP(p) end
Players.PlayerAdded:Connect(ESP)

-- ===== CUSTOM SCOPE =====
task.spawn(function()
    local CustomScope=CoreGui:FindFirstChild("CustomScopeGui")
    if not CustomScope then
        CustomScope=Instance.new("ScreenGui")
        CustomScope.Name="CustomScopeGui"
        CustomScope.ResetOnSpawn=false
        CustomScope.IgnoreGuiInset=true
        CustomScope.DisplayOrder=999
        CustomScope.Parent=CoreGui
    end

    local ScopeFrame=Instance.new("Frame",CustomScope)
    ScopeFrame.Size=UDim2.new(0,300,0,300)
    ScopeFrame.Position=UDim2.new(0.5,-150,0.5,-150)
    ScopeFrame.BackgroundTransparency=1
    ScopeFrame.Visible=false

    local HLeft=Instance.new("Frame",ScopeFrame)
    HLeft.Size=UDim2.new(0.4,0,0,1)
    HLeft.Position=UDim2.new(0,0,0.5,-0.5)
    HLeft.BackgroundColor3=WH
    HLeft.BorderSizePixel=0

    local HRight=Instance.new("Frame",ScopeFrame)
    HRight.Size=UDim2.new(0.4,0,0,1)
    HRight.Position=UDim2.new(0.6,0,0.5,-0.5)
    HRight.BackgroundColor3=WH
    HRight.BorderSizePixel=0

    local VTop=Instance.new("Frame",ScopeFrame)
    VTop.Size=UDim2.new(0,1,0.4,0)
    VTop.Position=UDim2.new(0.5,-0.5,0,0)
    VTop.BackgroundColor3=WH
    VTop.BorderSizePixel=0

    local VBottom=Instance.new("Frame",ScopeFrame)
    VBottom.Size=UDim2.new(0,1,0.4,0)
    VBottom.Position=UDim2.new(0.5,-0.5,0.6,0)
    VBottom.BackgroundColor3=WH
    VBottom.BorderSizePixel=0

    for i=1,3 do
        local markL=Instance.new("Frame",ScopeFrame)
        markL.Size=UDim2.new(0,6,0,1)
        markL.Position=UDim2.new(0.4-(i*0.05),0,0.5,-0.5)
        markL.BackgroundColor3=WH
        markL.BorderSizePixel=0

        local markR=Instance.new("Frame",ScopeFrame)
        markR.Size=UDim2.new(0,6,0,1)
        markR.Position=UDim2.new(0.6+(i*0.05)-0.02,0,0.5,-0.5)
        markR.BackgroundColor3=WH
        markR.BorderSizePixel=0

        local markT=Instance.new("Frame",ScopeFrame)
        markT.Size=UDim2.new(0,1,0,6)
        markT.Position=UDim2.new(0.5,-0.5,0.4-(i*0.05),0)
        markT.BackgroundColor3=WH
        markT.BorderSizePixel=0

        local markB=Instance.new("Frame",ScopeFrame)
        markB.Size=UDim2.new(0,1,0,6)
        markB.Position=UDim2.new(0.5,-0.5,0.6+(i*0.05)-0.02,0)
        markB.BackgroundColor3=WH
        markB.BorderSizePixel=0
    end

    local Dot=Instance.new("Frame",ScopeFrame)
    Dot.Size=UDim2.new(0,2,0,2)
    Dot.Position=UDim2.new(0.5,-1,0.5,-1)
    Dot.BackgroundColor3=WH
    Dot.BorderSizePixel=0

    local dotStroke=Instance.new("UIStroke",Dot)
    dotStroke.Thickness=1
    dotStroke.Color=Color3.fromRGB(0,0,0)
    dotStroke.Transparency=0.3

    local CachedSniperScope=nil
    local ScopeVisible=false

    RunService.RenderStepped:Connect(function()
        if not Config.CustomScope then
            ScopeFrame.Visible=false
            if CachedSniperScope and CachedSniperScope.Size~=UDim2.new(1,0,1,0) then
                CachedSniperScope.Size=UDim2.new(1,0,1,0)
            end
            return
        end
        if CachedSniperScope and not CachedSniperScope.Parent then
            CachedSniperScope=nil
        end
        if not CachedSniperScope then
            local pg=LP:FindFirstChild("PlayerGui")
            if pg then
                local ok,sc=pcall(function()
                    return pg.MainGui.Gameplay.Middle.SniperScope
                end)
                if ok and sc then
                    CachedSniperScope=sc
                end
            end
        end
        if CachedSniperScope then
            if CachedSniperScope.Visible then
                CachedSniperScope.Size=UDim2.new(0,0,0,0)
                CachedSniperScope.Visible=false
                ScopeVisible=true
            else
                if CachedSniperScope.Size~=UDim2.new(1,0,1,0) then
                    CachedSniperScope.Size=UDim2.new(1,0,1,0)
                end
                ScopeVisible=false
            end
        end
        ScopeFrame.Visible=ScopeVisible
    end)
end)

print("✅ NightFall Menu loaded!")
