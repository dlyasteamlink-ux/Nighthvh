-- ⚡ FameSence Main | PART 1/3 ⚡
local TweenService=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local Workspace=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local Debris=game:GetService("Debris")
local RS=game:GetService("ReplicatedStorage")
local LP=Players.LocalPlayer
local Camera=Workspace.CurrentCamera

local Config={
    SilentAim=false, FOV=150, Wallbang=false,
    Tracers=false, ESP=false, Hitbox=false, HitboxSize=2,
    Night=false, Atmosphere=false, ATMDensity=40, CustomScope=true, HitSound=false,
    ThirdPerson=false, CamDist=11, FakeAngles=false, FakeMode="Back",
    HeadDown=false, Spinbot=false,
    SoundId="rbxassetid://4817809188",
}

local OldLighting={
    Ambient=Lighting.Ambient, OutdoorAmbient=Lighting.OutdoorAmbient,
    Brightness=Lighting.Brightness, ClockTime=Lighting.ClockTime,
    FogEnd=Lighting.FogEnd, FogStart=Lighting.FogStart,
    Sky=Lighting:FindFirstChildOfClass("Sky"),
}

local PU=Color3.fromRGB(160,50,255)
local WH=Color3.fromRGB(255,255,255)
local GL=Color3.fromRGB(240,240,240)
local GM=Color3.fromRGB(140,140,140)
local GD=Color3.fromRGB(90,90,90)
local AC=Color3.fromRGB(100,180,255)
local BG1=Color3.fromRGB(14,14,14)
local BG2=Color3.fromRGB(20,20,20)
local BG3=Color3.fromRGB(26,26,26)
local LINE=Color3.fromRGB(38,38,38)

local function GetContainer()
    local s,r=pcall(function()
        if gethui then return gethui() end
        return LP:FindFirstChildOfClass("PlayerGui") or CoreGui
    end)
    return s and r or CoreGui
end

local TargetContainer=GetContainer()
if TargetContainer:FindFirstChild("FameSenceUI") then
    TargetContainer.FameSenceUI:Destroy()
end

local Gui=Instance.new("ScreenGui")
Gui.Name="FameSenceUI"
Gui.Parent=TargetContainer
Gui.ResetOnSpawn=false

local Main=Instance.new("Frame",Gui)
Main.Size=UDim2.new(0,620,0,440)
Main.Position=UDim2.new(0.5,-310,0.5,-220)
Main.BackgroundColor3=BG1
Main.BorderSizePixel=0
Main.Active=true
Main.ClipsDescendants=true
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",Main).Color=LINE

local Header=Instance.new("Frame",Main)
Header.Size=UDim2.new(1,0,0,55)
Header.BackgroundColor3=BG2
Header.BorderSizePixel=0
Header.ZIndex=10
Instance.new("UICorner",Header).CornerRadius=UDim.new(0,10)

local IconFrame=Instance.new("Frame",Header)
IconFrame.Size=UDim2.new(0,30,0,30)
IconFrame.Position=UDim2.new(0,18,0.5,-15)
IconFrame.BackgroundColor3=Color3.fromRGB(24,24,24)
IconFrame.BorderSizePixel=0
IconFrame.ZIndex=11
Instance.new("UICorner",IconFrame).CornerRadius=UDim.new(0,7)
Instance.new("UIStroke",IconFrame).Color=AC

local TB1=Instance.new("Frame",IconFrame)
TB1.Size=UDim2.new(0,2,0,16)
TB1.Position=UDim2.new(0,9,0.5,-8)
TB1.BackgroundColor3=AC
TB1.BorderSizePixel=0
TB1.ZIndex=12
Instance.new("UICorner",TB1).CornerRadius=UDim.new(0,1)

local TB2=Instance.new("Frame",IconFrame)
TB2.Size=UDim2.new(0,9,0,2)
TB2.Position=UDim2.new(0,10,0,9)
TB2.BackgroundColor3=AC
TB2.BorderSizePixel=0
TB2.ZIndex=12
Instance.new("UICorner",TB2).CornerRadius=UDim.new(0,1)

local TB3=Instance.new("Frame",IconFrame)
TB3.Size=UDim2.new(0,6,0,2)
TB3.Position=UDim2.new(0,10,0,15)
TB3.BackgroundColor3=AC
TB3.BorderSizePixel=0
TB3.ZIndex=12
Instance.new("UICorner",TB3).CornerRadius=UDim.new(0,1)

local Logo=Instance.new("TextLabel",Header)
Logo.Size=UDim2.new(0,250,1,0)
Logo.Position=UDim2.new(0,58,0,0)
Logo.BackgroundTransparency=1
Logo.Text="FameSence"
Logo.TextColor3=GL
Logo.Font=Enum.Font.GothamBold
Logo.TextSize=20
Logo.TextXAlignment=Enum.TextXAlignment.Left
Logo.ZIndex=11

local LogoGrad=Instance.new("UIGradient",Logo)
LogoGrad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(190,190,190)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(90,90,90))
})

local CloseBtn=Instance.new("TextButton",Header)
CloseBtn.Size=UDim2.new(0,32,0,32)
CloseBtn.Position=UDim2.new(1,-44,0.5,-16)
CloseBtn.BackgroundColor3=BG3
CloseBtn.Text="×"
CloseBtn.TextColor3=GM
CloseBtn.Font=Enum.Font.GothamBold
CloseBtn.TextSize=20
CloseBtn.BorderSizePixel=0
CloseBtn.AutoButtonColor=false
CloseBtn.ZIndex=11
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,8)

local Sidebar=Instance.new("Frame",Main)
Sidebar.Size=UDim2.new(0,160,1,-55)
Sidebar.Position=UDim2.new(0,0,0,55)
Sidebar.BackgroundColor3=BG2
Sidebar.BorderSizePixel=0
Sidebar.ZIndex=10

local SideLine=Instance.new("Frame",Sidebar)
SideLine.Size=UDim2.new(0,1,1,0)
SideLine.Position=UDim2.new(1,-1,0,0)
SideLine.BackgroundColor3=LINE
SideLine.BorderSizePixel=0

local TabHolder=Instance.new("Frame",Sidebar)
TabHolder.Size=UDim2.new(1,-16,1,-20)
TabHolder.Position=UDim2.new(0,8,0,10)
TabHolder.BackgroundTransparency=1
TabHolder.ZIndex=11

local TabLayout=Instance.new("UIListLayout",TabHolder)
TabLayout.SortOrder=Enum.SortOrder.LayoutOrder
TabLayout.Padding=UDim.new(0,4)

local ContentHolder=Instance.new("Frame",Main)
ContentHolder.Size=UDim2.new(1,-160,1,-55)
ContentHolder.Position=UDim2.new(0,160,0,55)
ContentHolder.BackgroundTransparency=1
ContentHolder.ZIndex=10

local Pages={}
local TabBtns={}
local TabLines={}

local function CreateTab(name)
    local btn=Instance.new("TextButton",TabHolder)
    btn.Size=UDim2.new(1,0,0,38)
    btn.BackgroundColor3=BG3
    btn.BackgroundTransparency=0.5
    btn.Text=""
    btn.AutoButtonColor=false
    btn.ZIndex=11
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)

    local line=Instance.new("Frame",btn)
    line.Size=UDim2.new(0,3,0.5,0)
    line.Position=UDim2.new(0,0,0.5,0)
    line.AnchorPoint=Vector2.new(0,0.5)
    line.BackgroundColor3=AC
    line.BorderSizePixel=0
    line.Visible=false
    line.ZIndex=12
    Instance.new("UICorner",line).CornerRadius=UDim.new(1,0)

    local title=Instance.new("TextLabel",btn)
    title.Size=UDim2.new(1,-20,1,0)
    title.Position=UDim2.new(0,18,0,0)
    title.BackgroundTransparency=1
    title.Text=name
    title.TextColor3=Color3.fromRGB(110,110,110)
    title.Font=Enum.Font.GothamBold
    title.TextSize=13
    title.TextXAlignment=Enum.TextXAlignment.Left
    title.ZIndex=12

    local page=Instance.new("Frame",ContentHolder)
    page.Size=UDim2.new(1,0,1,0)
    page.BackgroundTransparency=1
    page.Visible=false
    page.ZIndex=11

    local leftCol=Instance.new("ScrollingFrame",page)
    leftCol.Size=UDim2.new(0.5,-15,1,-20)
    leftCol.Position=UDim2.new(0,10,0,10)
    leftCol.BackgroundTransparency=1
    leftCol.ScrollBarThickness=0
    leftCol.CanvasSize=UDim2.new(0,0,0,0)
    leftCol.AutomaticCanvasSize=Enum.AutomaticSize.Y
    leftCol.ZIndex=12

    local rightCol=Instance.new("ScrollingFrame",page)
    rightCol.Size=UDim2.new(0.5,-15,1,-20)
    rightCol.Position=UDim2.new(0.5,5,0,10)
    rightCol.BackgroundTransparency=1
    rightCol.ScrollBarThickness=0
    rightCol.CanvasSize=UDim2.new(0,0,0,0)
    rightCol.AutomaticCanvasSize=Enum.AutomaticSize.Y
    rightCol.ZIndex=12

    Instance.new("UIListLayout",leftCol).Padding=UDim.new(0,10)
    Instance.new("UIListLayout",rightCol).Padding=UDim.new(0,10)

    Pages[name]=page
    TabBtns[name]=title
    TabLines[name]=line

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(Pages) do p.Visible=false end
        for tName,t in pairs(TabBtns) do
            TweenService:Create(t,TweenInfo.new(0.2),{TextColor3=Color3.fromRGB(110,110,110)}):Play()
            TabLines[tName].Visible=false
        end
        page.Visible=true
        TweenService:Create(title,TweenInfo.new(0.2),{TextColor3=GL}):Play()
        line.Visible=true
    end)
    return leftCol,rightCol
end

local RageL,RageR=CreateTab("Rage")
local VisualsL,VisualsR=CreateTab("Visuals")
local MovementL,MovementR=CreateTab("Movement")
local InfoL,InfoR=CreateTab("Info")
local NewsL,NewsR=CreateTab("News")

Pages["Rage"].Visible=true
TabBtns["Rage"].TextColor3=GL
TabLines["Rage"].Visible=true

local ToggleBtn=Instance.new("TextButton",Gui)
ToggleBtn.Size=UDim2.new(0,50,0,50)
ToggleBtn.Position=UDim2.new(0.05,0,0.1,0)
ToggleBtn.BackgroundColor3=BG2
ToggleBtn.Text=""
ToggleBtn.Visible=false
ToggleBtn.Active=true
Instance.new("UICorner",ToggleBtn).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",ToggleBtn).Color=AC

local T1=Instance.new("Frame",ToggleBtn)
T1.Size=UDim2.new(0,3,0,24)
T1.Position=UDim2.new(0,17,0.5,-12)
T1.BackgroundColor3=AC
T1.BorderSizePixel=0
Instance.new("UICorner",T1).CornerRadius=UDim.new(0,1)

local T2=Instance.new("Frame",ToggleBtn)
T2.Size=UDim2.new(0,14,0,3)
T2.Position=UDim2.new(0,19,0,14)
T2.BackgroundColor3=AC
T2.BorderSizePixel=0
Instance.new("UICorner",T2).CornerRadius=UDim.new(0,1)

local T3=Instance.new("Frame",ToggleBtn)
T3.Size=UDim2.new(0,10,0,3)
T3.Position=UDim2.new(0,19,0,23)
T3.BackgroundColor3=AC
T3.BorderSizePixel=0
Instance.new("UICorner",T3).CornerRadius=UDim.new(0,1)

local origSize=UDim2.new(0,620,0,440)
local origPos=UDim2.new(0.5,-310,0.5,-220)

local function OpenMenu()
    Main.Visible=true
    Main.Size=UDim2.new(0,0,0,0)
    Main.Position=UDim2.new(0.5,0,0.5,0)
    TweenService:Create(Main,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=origSize,Position=origPos
    }):Play()
    ToggleBtn.Visible=false
end

local function CloseMenu()
    TweenService:Create(Main,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{
        Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)
    }):Play()
    task.wait(0.3)
    Main.Visible=false
    ToggleBtn.Visible=true
    ToggleBtn.Size=UDim2.new(0,0,0,0)
    TweenService:Create(ToggleBtn,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=UDim2.new(0,50,0,50)
    }):Play()
end

CloseBtn.MouseButton1Click:Connect(CloseMenu)
ToggleBtn.MouseButton1Click:Connect(OpenMenu)

local dg,ds,sp
Header.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        dg=true ds=i.Position sp=Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dg and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=i.Position-ds
        Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dg=false end
end)
-- ⚡ FameSence Main | PART 2/3 ⚡

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

-- ===== TOGGLE (как в тесте — работает на телефоне) =====
local function Toggle(parent,text,default,cb)
    local btn=Instance.new("TextButton",parent)
    btn.Size=UDim2.new(1,0,0,32)
    btn.BackgroundColor3=BG3
    btn.BackgroundTransparency=0.5
    btn.Text=text..": OFF"
    btn.TextColor3=GM
    btn.Font=Enum.Font.GothamBold
    btn.TextSize=11
    btn.TextXAlignment=Enum.TextXAlignment.Left
    btn.AutoButtonColor=false
    btn.BorderSizePixel=0
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
    
    local pad=Instance.new("UIPadding",btn)
    pad.PaddingLeft=UDim.new(0,12)
    
    local state=default
    if cb then cb(state) end
    if state then
        btn.Text=text..": ON"
        btn.BackgroundColor3=Color3.fromRGB(80,0,140)
        btn.TextColor3=GL
    end
    
    btn.MouseButton1Click:Connect(function()
        state=not state
        if state then
            btn.Text=text..": ON"
            btn.BackgroundColor3=Color3.fromRGB(80,0,140)
            btn.TextColor3=GL
        else
            btn.Text=text..": OFF"
            btn.BackgroundColor3=BG3
            btn.TextColor3=GM
        end
        if cb then cb(state) end
    end)
end

-- ===== SLIDER (как в тесте) =====
local function Slider(parent,text,mn,mx,dv,cb)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,50)
    f.BackgroundColor3=BG3
    f.BackgroundTransparency=0.5
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
    b.Size=UDim2.new(1,-24,0,6)
    b.Position=UDim2.new(0,12,1,-18)
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
    bt.Size=UDim2.new(0,20,0,20)
    bt.Position=UDim2.new(ip,-10,0.5,-10)
    bt.BackgroundColor3=Color3.fromRGB(220,200,255)
    bt.Text=""
    bt.BorderSizePixel=0
    Instance.new("UICorner",bt).CornerRadius=UDim.new(1,0)
    
    local dragging=false
    bt.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=false
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseMovement then return end
        local p=math.clamp((i.Position.X-b.AbsolutePosition.X)/b.AbsoluteSize.X,0,1)
        local v=math.floor((mx-mn)*p+mn+0.5)
        fl.Size=UDim2.new(p,0,1,0)
        bt.Position=UDim2.new(p,-10,0.5,-10)
        l.Text=text..": "..v
        if cb then cb(v) end
    end)
end

local function Button(parent,text,cb)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,0,0,30)
    b.BackgroundColor3=BG3
    b.BackgroundTransparency=0.5
    b.Text=text
    b.TextColor3=GL
    b.Font=Enum.Font.GothamBold
    b.TextSize=11
    b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(function() if cb then cb(b) end end)
    return b
end

-- ===== SETNIGHT / SETATM =====
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

-- ===== НАПОЛНЕНИЕ RAGE =====
Desc(RageL,"Silent Aim — наводит пули в голову врага")
Toggle(RageL,"Silent Aim",false,function(v) Config.SilentAim=v end)
Desc(RageL,"FOV — радиус поиска врага")
Slider(RageL,"FOV",20,400,150,function(v) Config.FOV=v end)
Desc(RageR,"Wallbang — стрельба через стены")
Toggle(RageR,"Wallbang",false,function(v) Config.Wallbang=v end)

-- ===== НАПОЛНЕНИЕ VISUALS =====
Desc(VisualsL,"Bullet Tracers — белые трассеры")
Toggle(VisualsL,"Bullet Tracers",false,function(v) Config.Tracers=v end)
Desc(VisualsL,"ESP — боксы, скелет, HP, имена")
Toggle(VisualsL,"ESP",false,function(v) Config.ESP=v end)
Desc(VisualsL,"Hitbox — увеличенная голова")
Toggle(VisualsL,"Hitbox",false,function(v) Config.Hitbox=v end)
Slider(VisualsL,"Hitbox Size",1,16,2,function(v) Config.HitboxSize=v end)

Desc(VisualsR,"Night — ночное небо")
Toggle(VisualsR,"Night",false,function(v) Config.Night=v SetNight(v) end)
Desc(VisualsR,"Custom Scope — белый прицел")
Toggle(VisualsR,"Custom Scope",true,function(v) Config.CustomScope=v end)
Desc(VisualsR,"Atmosphere — туман CS:GO")
Toggle(VisualsR,"Atmosphere",false,function(v) Config.Atmosphere=v SetAtm(v) end)
Slider(VisualsR,"ATM Density",1,100,40,function(v) Config.ATMDensity=v if Config.Atmosphere then SetAtm(true) end end)
Desc(VisualsR,"Hit Sound — звук попадания")
Toggle(VisualsR,"Hit Sound",false,function(v) Config.HitSound=v end)

-- ===== НАПОЛНЕНИЕ MOVEMENT =====
Desc(MovementL,"Third Person — вид от 3-го лица")
Toggle(MovementL,"Third Person",false,function(v) Config.ThirdPerson=v end)
Slider(MovementL,"Cam Distance",5,30,11,function(v) Config.CamDist=v end)
Desc(MovementL,"Fake Angles — тело смотрит назад")
Toggle(MovementL,"Fake Angles",false,function(v) Config.FakeAngles=v end)
Desc(MovementL,"Head Down — лицо в пол")
Toggle(MovementL,"Head Down",false,function(v) Config.HeadDown=v end)

Desc(MovementR,"Spinbot — вращение")
Toggle(MovementR,"Spinbot",false,function(v) Config.Spinbot=v end)

Button(MovementR,"Mode: Back",function(b)
    local modes={"Back","Down","Random"}
    local i=1
    for idx,m in ipairs(modes) do if m==Config.FakeMode then i=idx break end end
    i=i%#modes+1
    Config.FakeMode=modes[i]
    b.Text="Mode: "..Config.FakeMode
end)

-- ===== ИНФО =====
local function InfoLine(parent,label,value)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,32)
    f.BackgroundColor3=BG3
    f.BackgroundTransparency=0.5
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
    local l=Instance.new("TextLabel",f)
    l.Size=UDim2.new(1,-20,1,0)
    l.Position=UDim2.new(0,12,0,0)
    l.BackgroundTransparency=1
    l.Text=label
    l.TextColor3=GM
    l.Font=Enum.Font.GothamBold
    l.TextSize=11
    l.TextXAlignment=Enum.TextXAlignment.Left
    local v=Instance.new("TextLabel",f)
    v.Size=UDim2.new(1,-20,1,0)
    v.Position=UDim2.new(0,12,0,0)
    v.BackgroundTransparency=1
    v.Text=value
    v.TextColor3=GL
    v.Font=Enum.Font.GothamBold
    v.TextSize=11
    v.TextXAlignment=Enum.TextXAlignment.Right
end

InfoLine(InfoL,"Версия","v1.0")
InfoLine(InfoL,"Автор","Squez3")
InfoLine(InfoL,"Игрок",LP.Name)
InfoLine(InfoR,"Статус","Online")
InfoLine(InfoR,"Режим","Rage")
InfoLine(InfoR,"Дата","26.09.2026")

-- ===== НОВОСТИ =====
local function NewsCard(parent,title,text,date)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,100)
    f.BackgroundColor3=BG3
    f.BackgroundTransparency=0.5
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
    Instance.new("UIStroke",f).Color=AC
    local l1=Instance.new("TextLabel",f)
    l1.Size=UDim2.new(1,-20,0,22)
    l1.Position=UDim2.new(0,12,0,10)
    l1.BackgroundTransparency=1
    l1.Text=title
    l1.TextColor3=GL
    l1.Font=Enum.Font.GothamBold
    l1.TextSize=13
    l1.TextXAlignment=Enum.TextXAlignment.Left
    local l2=Instance.new("TextLabel",f)
    l2.Size=UDim2.new(1,-20,0,50)
    l2.Position=UDim2.new(0,12,0,34)
    l2.BackgroundTransparency=1
    l2.Text=text
    l2.TextColor3=GM
    l2.Font=Enum.Font.Gotham
    l2.TextSize=10
    l2.TextXAlignment=Enum.TextXAlignment.Left
    l2.TextYAlignment=Enum.TextYAlignment.Top
    l2.TextWrapped=true
    local l3=Instance.new("TextLabel",f)
    l3.Size=UDim2.new(1,-20,0,14)
    l3.Position=UDim2.new(0,12,1,-20)
    l3.BackgroundTransparency=1
    l3.Text=date
    l3.TextColor3=GD
    l3.Font=Enum.Font.Gotham
    l3.TextSize=9
    l3.TextXAlignment=Enum.TextXAlignment.Left
end

NewsCard(NewsL,"Добро пожаловать!","FameSence v1.0 загружен. Настраивай функции во вкладках.","26.09.2026")
NewsCard(NewsL,"Обновление","Добавлены: Silent Aim, Wallbang, ESP, Tracers.","26.09.2026")

-- ===== FOV CIRCLE =====
local FovGui=Instance.new("ScreenGui")
FovGui.Name="FOVCircle"
FovGui.ResetOnSpawn=false
FovGui.IgnoreGuiInset=true
FovGui.DisplayOrder=999
FovGui.Parent=GetContainer()

local FovFrame=Instance.new("Frame",FovGui)
FovFrame.Size=UDim2.new(0,300,0,300)
FovFrame.AnchorPoint=Vector2.new(0.5,0.5)
FovFrame.Position=UDim2.new(0.5,0,0.5,0)
FovFrame.BackgroundTransparency=1

local FovCorner=Instance.new("UICorner",FovFrame)
FovCorner.CornerRadius=UDim.new(1,0)

local FovStroke=Instance.new("UIStroke",FovFrame)
FovStroke.Thickness=2
FovStroke.Color=WH
FovStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

local FovGrad=Instance.new("UIGradient",FovStroke)
FovGrad.Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
}

RunService.RenderStepped:Connect(function()
    FovGrad.Rotation=FovGrad.Rotation+1
    FovFrame.Size=UDim2.new(0,Config.FOV*2,0,Config.FOV*2)
    FovFrame.Visible=Config.SilentAim
end)

-- Открытие
Main.Size=UDim2.new(0,0,0,0)
Main.Position=UDim2.new(0.5,0,0.5,0)
task.wait(0.1)
TweenService:Create(Main,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    Size=origSize,Position=origPos
}):Play()

print("✅ FameSence PART 2 loaded!")
-- ⚡ FameSence Main | PART 3/3 ⚡

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
                if Config.Wallbang then
                    return {Origin=origin,Direction=nd.Unit,Distance=d,
                        Hits={{Position=hp,Instance=target,Material="Plastic",Normal=Vector3.new(0,0,0),Exit=false}}}
                else
                    local ri=GetRayIgnore()
                    local params=RaycastParams.new()
                    params.FilterType=Enum.RaycastFilterType.Exclude
                    params.IgnoreWater=true
                    params.CollisionGroup="Bullet"
                    params.FilterDescendantsInstances=ri
                    local check=Workspace:Raycast(origin,nd,params)
                    if check and check.Instance and check.Instance:IsDescendantOf(target.Parent) then
                        return {Origin=origin,Direction=nd.Unit,Distance=d,
                            Hits={{Position=check.Position,Instance=check.Instance,Material=check.Material and check.Material.Name or "Plastic",Normal=check.Normal or Vector3.new(0,0,0),Exit=false}}}
                    end
                    return originalPerformRaycast(self,spreadAngle)
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
                    if Config.Wallbang then
                        return {Origin=origin,Direction=nd.Unit,Distance=d,
                            Hits={{Position=hp,Instance=target,Material="Plastic",Normal=Vector3.new(0,0,0),Exit=false}}}
                    else
                        local ri=GetRayIgnore()
                        local params=RaycastParams.new()
                        params.FilterType=Enum.RaycastFilterType.Exclude
                        params.IgnoreWater=true
                        params.CollisionGroup="Bullet"
                        params.FilterDescendantsInstances=ri
                        local check=Workspace:Raycast(origin,nd,params)
                        if check and check.Instance and check.Instance:IsDescendantOf(target.Parent) then
                            return {Origin=origin,Direction=nd.Unit,Distance=d,
                                Hits={{Position=check.Position,Instance=check.Instance,Material=check.Material and check.Material.Name or "Plastic",Normal=check.Normal or Vector3.new(0,0,0),Exit=false}}}
                        end
                    end
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

-- ===== TRACERS + HIT SOUND =====
local lastTracer=0
local function CreateTracer(s,e)
    local d=(s-e).Magnitude
    if d<3 then return end
    local model=Instance.new("Model")
    local segs=8
    local segLen=d/segs
    for i=1,segs do
        local t1=(i-1)/segs
        local t2=i/segs
        local s1=s:Lerp(e,t1)
        local s2=s:Lerp(e,t2)
        local mid=s1:Lerp(s2,0.5)
        local fade=0.1+t1*0.7
        local seg=Instance.new("Part")
        seg.Anchored=true
        seg.CanCollide=false
        seg.CanQuery=false
        seg.CastShadow=false
        seg.Material=Enum.Material.Neon
        seg.Color=WH
        seg.Transparency=fade
        seg.Size=Vector3.new(segLen,0.05,0.05)
        seg.CFrame=CFrame.new(mid)*CFrame.lookAt(s1,s2).Rotation*CFrame.Angles(0,math.rad(90),0)
        seg.Shape=Enum.PartType.Cylinder
        seg.Parent=model
        TweenService:Create(seg,TweenInfo.new(6,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1}):Play()
    end
    model.Parent=Workspace
    Debris:AddItem(model,6.2)
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
                    if t-lastTracer>=0.04 then
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
local fakeAngle=0
RunService.RenderStepped:Connect(function(dt)
    local c=LP.Character
    if not c then return end
    local root=c:FindFirstChild("HumanoidRootPart")
    local head=c:FindFirstChild("Head")

    if Config.Spinbot and root then
        root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,math.rad((tick()*2000)%360),0)
    end

    if Config.ThirdPerson and head then
        for _,p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
                p.LocalTransparencyModifier=0
            end
        end
        LP.CameraMinZoomDistance=Config.CamDist
        LP.CameraMaxZoomDistance=30
        if (Camera.CFrame.Position-head.Position).Magnitude<4 then
            Camera.CFrame=Camera.CFrame+(Camera.CFrame.LookVector*-Config.CamDist)+Vector3.new(0,3,0)
        end
    end

    if Config.FakeAngles and root then
        local look=Camera.CFrame.LookVector
        local fakeDir
        if Config.FakeMode=="Back" then
            fakeDir=-look
        elseif Config.FakeMode=="Down" then
            fakeDir=Vector3.new(look.X,-0.3,look.Z)
        elseif Config.FakeMode=="Random" then
            fakeAngle=(fakeAngle+dt*300)%360
            fakeDir=Vector3.new(math.sin(math.rad(fakeAngle)),0,math.cos(math.rad(fakeAngle)))
        else
            fakeDir=-look
        end
        local yaw=math.deg(math.atan2(-fakeDir.X,-fakeDir.Z))
        root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,math.rad(yaw),0)
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

local defaultNeckC0=nil
RunService.RenderStepped:Connect(function()
    local c=LP.Character
    if not c then return end
    local neck=c:FindFirstChild("Neck",true)
    if not neck then return end
    if Config.HeadDown then
        if not defaultNeckC0 then defaultNeckC0=neck.C0 end
        neck.C0=defaultNeckC0*CFrame.Angles(math.rad(-80),0,0)
    else
        if defaultNeckC0 then
            neck.C0=defaultNeckC0
            defaultNeckC0=nil
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if Config.Night then
        Lighting.Ambient=Color3.fromRGB(80,80,100)
        Lighting.OutdoorAmbient=Color3.fromRGB(90,90,110)
        Lighting.Brightness=2
        Lighting.ClockTime=0
        Lighting.FogEnd=2000
        Lighting.FogStart=200
    end
end)

-- ===== ESP =====
local ESPParent=GetContainer()
if ESPParent:FindFirstChild("BloxESP") then
    ESPParent.BloxESP:Destroy()
end

local ESPScreen=Instance.new("ScreenGui")
ESPScreen.Name="BloxESP"
ESPScreen.ResetOnSpawn=false
ESPScreen.IgnoreGuiInset=true
ESPScreen.DisplayOrder=9999
ESPScreen.Parent=ESPParent

local BONES_R15={
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}
local BONES_R6={
    {"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
    {"Torso","Left Leg"},{"Torso","Right Leg"},
}

local function GetBones(char)
    if char:FindFirstChild("UpperTorso") then return BONES_R15 end
    return BONES_R6
end

local ESPObjects={}

local function CreateESP(plr)
    if plr==LP or ESPObjects[plr] then return end

    local function SetupCharacter(char)
        if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart",10)
        if not hrp then return end

        local boxGui=Instance.new("BillboardGui",ESPScreen)
        boxGui.Size=UDim2.new(4,0,5.5,0)
        boxGui.AlwaysOnTop=true
        boxGui.MaxDistance=1500
        boxGui.Adornee=hrp
        local boxFrame=Instance.new("Frame",boxGui)
        boxFrame.Size=UDim2.new(1,0,1,0)
        boxFrame.BackgroundTransparency=1
        local boxStroke=Instance.new("UIStroke",boxFrame)
        boxStroke.Thickness=1.5
        boxStroke.Color=WH
        boxStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

        local hpGui=Instance.new("BillboardGui",ESPScreen)
        hpGui.Size=UDim2.new(0.6,0,5.5,0)
        hpGui.StudsOffset=Vector3.new(-2.3,0,0)
        hpGui.AlwaysOnTop=true
        hpGui.MaxDistance=1500
        hpGui.Adornee=hrp
        local hpBg=Instance.new("Frame",hpGui)
        hpBg.Size=UDim2.new(1,0,1,0)
        hpBg.BackgroundColor3=Color3.fromRGB(0,0,0)
        hpBg.BackgroundTransparency=0.3
        local hpFill=Instance.new("Frame",hpBg)
        hpFill.Size=UDim2.new(1,0,1,0)
        hpFill.BackgroundColor3=Color3.fromRGB(0,255,0)

        local nameGui=Instance.new("BillboardGui",ESPScreen)
        nameGui.Size=UDim2.new(5,0,1,0)
        nameGui.StudsOffset=Vector3.new(0,3.3,0)
        nameGui.AlwaysOnTop=true
        nameGui.MaxDistance=1500
        nameGui.Adornee=hrp
        local nameLbl=Instance.new("TextLabel",nameGui)
        nameLbl.Size=UDim2.new(1,0,1,0)
        nameLbl.BackgroundTransparency=1
        nameLbl.Text=plr.Name
        nameLbl.TextScaled=true
        nameLbl.TextColor3=WH
        nameLbl.TextStrokeTransparency=0.3
        nameLbl.Font=Enum.Font.GothamBold

        local distGui=Instance.new("BillboardGui",ESPScreen)
        distGui.Size=UDim2.new(5,0,0.8,0)
        distGui.StudsOffset=Vector3.new(0,-3.3,0)
        distGui.AlwaysOnTop=true
        distGui.MaxDistance=1500
        distGui.Adornee=hrp
        local distLbl=Instance.new("TextLabel",distGui)
        distLbl.Size=UDim2.new(1,0,1,0)
        distLbl.BackgroundTransparency=1
        distLbl.Text="0m"
        distLbl.TextScaled=true
        distLbl.TextColor3=Color3.fromRGB(220,220,220)
        distLbl.TextStrokeTransparency=0.3
        distLbl.Font=Enum.Font.GothamBold

        local bones=GetBones(char)
        local skLines={}
        for i=1,#bones do
            local line=Drawing.new("Line")
            line.Thickness=1
            line.Color=WH
            line.Transparency=1
            line.Visible=false
            skLines[i]=line
        end

        ESPObjects[plr]={
            box=boxGui,boxStroke=boxStroke,
            hp=hpGui,hpFill=hpFill,hpBg=hpBg,
            name=nameGui,nameLbl=nameLbl,
            dist=distGui,distLbl=distLbl,
            sk=skLines,bones=bones,char=char,
        }

        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function()
                local o=ESPObjects[plr]
                if o then
                    if o.box then o.box:Destroy() end
                    if o.hp then o.hp:Destroy() end
                    if o.name then o.name:Destroy() end
                    if o.dist then o.dist:Destroy() end
                    for _,l in ipairs(o.sk) do l:Remove() end
                    ESPObjects[plr]=nil
                end
            end)
        end
    end

    plr.CharacterAdded:Connect(SetupCharacter)
    if plr.Character then SetupCharacter(plr.Character) end
end

RunService.RenderStepped:Connect(function()
    for plr,esp in pairs(ESPObjects) do
        if not esp.char or not esp.char.Parent then
            if esp.box then esp.box:Destroy() end
            if esp.hp then esp.hp:Destroy() end
            if esp.name then esp.name:Destroy() end
            if esp.dist then esp.dist:Destroy() end
            for _,l in ipairs(esp.sk) do l:Remove() end
            ESPObjects[plr]=nil
            continue
        end
        local char=esp.char
        local hrp=char:FindFirstChild("HumanoidRootPart")
        local hum=char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health<=0 then
            if esp.box then esp.box:Destroy() end
            if esp.hp then esp.hp:Destroy() end
            if esp.name then esp.name:Destroy() end
            if esp.dist then esp.dist:Destroy() end
            for _,l in ipairs(esp.sk) do l:Remove() end
            ESPObjects[plr]=nil
            continue
        end
        local dist=(Camera.CFrame.Position-hrp.Position).Magnitude
        if not Config.ESP or dist>1500 then
            esp.box.Enabled=false
            esp.hp.Enabled=false
            esp.name.Enabled=false
            esp.dist.Enabled=false
            for _,l in ipairs(esp.sk) do l.Visible=false end
            continue
      end
        esp.box.Enabled=true
        esp.box.Adornee=hrp
        esp.hp.Enabled=true
        esp.hp.Adornee=hrp
        local hpRatio=math.clamp(hum.Health/hum.MaxHealth,0,1)
        esp.hpFill.Size=UDim2.new(1,0,hpRatio,0)
        esp.hpFill.Position=UDim2.new(0,0,1-hpRatio,0)
        if hpRatio>0.6 then
            esp.hpFill.BackgroundColor3=Color3.fromRGB(0,255,0)
        elseif hpRatio>0.3 then
            esp.hpFill.BackgroundColor3=Color3.fromRGB(255,200,0)
        else
            esp.hpFill.BackgroundColor3=Color3.fromRGB(255,0,0)
        end
        esp.name.Enabled=true
        esp.name.Adornee=hrp
        esp.dist.Enabled=true
        esp.dist.Adornee=hrp
        esp.distLbl.Text=math.floor(dist).."m"
        for i,bone in ipairs(esp.bones) do
            local p1=char:FindFirstChild(bone[1])
            local p2=char:FindFirstChild(bone[2])
            local line=esp.sk[i]
            if p1 and p2 and line then
                local s1,on1=Camera:WorldToViewportPoint(p1.Position)
                local s2,on2=Camera:WorldToViewportPoint(p2.Position)
                if on1 and on2 then
                    line.From=Vector2.new(s1.X,s1.Y)
                    line.To=Vector2.new(s2.X,s2.Y)
                    line.Visible=true
                else
                    line.Visible=false
                end
            elseif line then
                line.Visible=false
            end
        end
    end
end)

for _,plr in pairs(Players:GetPlayers()) do CreateESP(plr) end
Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(plr)
    local esp=ESPObjects[plr]
    if esp then
        if esp.box then esp.box:Destroy() end
        if esp.hp then esp.hp:Destroy() end
        if esp.name then esp.name:Destroy() end
        if esp.dist then esp.dist:Destroy() end
        for _,l in ipairs(esp.sk) do l:Remove() end
        ESPObjects[plr]=nil
    end
end)

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

print("✅ FameSence Main loaded!")  
