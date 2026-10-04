local hi = "https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/"
local gu, ex = pcall(function()
  return loadstring(game:HttpGet(hi .. "Library.lua"))()
end)

if not gu or type(ex) ~= "table" then
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "XK Hub", Text = "界面库加载失败", Duration = 6
	})
	return
end

local ThemeManager, SaveManager
pcall(function()
	ThemeManager = loadstring(game:HttpGet(hi .. "addons/ThemeManager.lua"))()
end)
pcall(function()
	SaveManager = loadstring(game:HttpGet(hi .. "addons/SaveManager.lua"))()
end)

local fe = ex.Options
local ff = ex.Toggles

local P = game:GetService("Players")
local RS = game:GetService("RunService")
local W = game:GetService("Workspace")
local jc = game:GetService("UserInputService")
local LP = P.LocalPlayer
local ja = W.CurrentCamera
local gr = LP:GetMouse()

local ds = false
pcall(function()
	local t = Drawing.new("Square")
	t.Visible = false
	t:Remove()
	ds = true
end)

local function bm()
	local ok, h = pcall(function()
		if type(gethui) == "function" then return gethui() end
		return nil
	end)
  if ok and h then return h end
	local jb, cg = pcall(function() return game:GetService("CoreGui") end)
	if jb and cg then return cg end
  return LP:WaitForChild("PlayerGui")
end

local dq = Instance.new("Folder")
dq.Name = "XK_ESP"
pcall(function() dq.Parent = bm() end)

local ih = {}
local ez = {}
local dh = nil
local dm = nil

local cl = false
local co = nil
local br = false

local function bu(fo)
	if fo:IsA("Player") then
		local gz = fo.Character
		return gz and gz:FindFirstChildOfClass("Humanoid") or nil
  elseif fo:IsA("Model") then
		return fo:FindFirstChildOfClass("Humanoid")
  end
	return nil
end

local function by(fo)
	if fo:IsA("Player") then
		local gz = fo.Character
		if not gz then return nil end

    return gz:FindFirstChild("HumanoidRootPart") or gz:FindFirstChild("Head")
	elseif fo:IsA("Model") then
		return fo:FindFirstChild("HumanoidRootPart")
      or fo.PrimaryPart
			or fo:FindFirstChildWhichIsA("BasePart", true)
	elseif fo:IsA("BasePart") then
		return fo
	end

	return nil
end

local function dt(fo, gx)
  if fo:IsA("Player") and fo.Character then
		local hd = fo.Character:FindFirstChild("Head")
    if hd then return hd end
	end
  return gx
end

local function ae()
  for d in pairs(ez) do
		if d.ge and (d.ge.Box or d.ge.Line) then return true end
	end
	return false
end

local function as()
	for d in pairs(ez) do
		if d.ge and d.ge.Distance then return true end
	end
	return false
end

local function ce()
	if not ja or not ja.Parent then ja = W.CurrentCamera end
  if not ja then return end

	for d in pairs(ez) do
    local e = d.Entity

		local p = d.Part
		local c = d.ge
		if not d.Enabled or not e or not e.Parent or not p or not p.Parent then
			if d.Box then d.Box.Visible = false end
      if d.Line then d.Line.Visible = false end
		else
			pcall(function()

				local sp = ja:WorldToViewportPoint(p.Position)
				local hs = Vector2.new(sp.X, sp.Y)

				if c.Box and d.Box then
					local gz = e:IsA("Player") and e.Character or e
					local cf, sz = nil, nil
					if gz and gz:IsA("Model") then
						local he, iu, ir = pcall(gz.GetBoundingBox, gz)
						if he and iu then cf, sz = iu, ir end
					end
					if not cf then cf, sz = p.CFrame, p.Size end

					local fl = {

						cf * CFrame.new(-sz.X / 2, -sz.Y / 2, -sz.Z / 2),
						cf * CFrame.new(sz.X / 2, -sz.Y / 2, -sz.Z / 2),
            cf * CFrame.new(sz.X / 2, sz.Y / 2, -sz.Z / 2),
						cf * CFrame.new(-sz.X / 2, sz.Y / 2, -sz.Z / 2),
						cf * CFrame.new(-sz.X / 2, -sz.Y / 2, sz.Z / 2),
						cf * CFrame.new(sz.X / 2, -sz.Y / 2, sz.Z / 2),
						cf * CFrame.new(sz.X / 2, sz.Y / 2, sz.Z / 2),
						cf * CFrame.new(-sz.X / 2, sz.Y / 2, sz.Z / 2),
          }

					local x1, y1 = math.huge, math.huge
					local x2, y2 = -math.huge, -math.huge
					local ji = false
					for _, cn in ipairs(fl) do
						local s, o = ja:WorldToViewportPoint(cn.Position)
            if o then
							ji = true
							if s.X < x1 then x1 = s.X end
							if s.Y < y1 then y1 = s.Y end
              if s.X > x2 then x2 = s.X end
							if s.Y > y2 then y2 = s.Y end
						end
					end
					if ji then
						d.Box.Position = Vector2.new(x1, y1)
						d.Box.Size = Vector2.new(x2 - x1, y2 - y1)
						d.Box.Color = c.Color
            d.Box.Visible = true
					else
            d.Box.Visible = false
          end

				elseif d.Box then
					d.Box.Visible = false
        end

        if c.Line and d.Line then
					local fa = nil
					local lc = LP.Character
					local hu = lc and lc:FindFirstChild("HumanoidRootPart")
					if hu then
						local jg = ja:WorldToViewportPoint(hu.Position)
						if jg.Z > 0 then fa = Vector2.new(jg.X, jg.Y) end
					end
          if not fa then
						local vp = ja.ViewportSize
            fa = Vector2.new(vp.X / 2, vp.Y)
          end
					d.Line.From = fa
					d.Line.To = hs
					d.Line.Color = c.Color
					d.Line.Visible = true
				elseif d.Line then
					d.Line.Visible = false
				end
      end)
    end
	end
end

local function ah()
	local lc = LP.Character
  local hu = lc and lc:FindFirstChild("HumanoidRootPart")
	if not hu then return end
  for d in pairs(ez) do
    if d.ge and d.ge.Distance and d.qw then
			local p = d.Part
			if p and p.Parent then
				pcall(function()
					local hm = math.floor((hu.Position - p.Position).Magnitude)
          local ig = tostring(hm) .. "m"
					if d.qw.Text ~= ig then d.qw.Text = ig end
				end)
			end
		end
  end
end

local function cy()
	local gw = ae()
	if gw and not dh then
		dh = RS.RenderStepped:Connect(ce)
	elseif not gw and dh then
		dh:Disconnect()
		dh = nil
		for d in pairs(ez) do
      if d.Box then d.Box.Visible = false end
			if d.Line then d.Line.Visible = false end
		end
	end

	local gi = as()
	if gi and not dm then
    cl = true
    dm = task.spawn(function()
			while cl do
				task.wait(0.5)
        pcall(ah)
			end
		end)
	elseif not gi and dm then
		cl = false

		local t = dm
    dm = nil

		pcall(function() task.cancel(t) end)
	end
end

local function cq(d)
	if not d.gp then return end
	local ie = bu(d.Entity)
	if not ie or not d.ge.Health then
    d.gp.Visible = false
		return
	end
	pcall(function()
		local gn = math.clamp(ie.Health / math.max(ie.MaxHealth, 1), 0, 1)
		local ig = "HP " .. tostring(math.floor(gn * 100)) .. "%"
		if d.gp.Text ~= ig then d.gp.Text = ig end
		d.gp.Visible = true
	end)
end

local ec = false
local bj = 1
local de = 0

local function es(h)
  h = h - math.floor(h)
  local i = math.floor(h * 6)

	local f = h * 6 - i
	local p, q, t = 0, 1 - f, f
	i = i % 6
  if i == 0 then return Color3.new(1, t, p)
	elseif i == 1 then return Color3.new(q, 1, p)
	elseif i == 2 then return Color3.new(p, 1, t)
	elseif i == 3 then return Color3.new(p, q, 1)
	elseif i == 4 then return Color3.new(t, p, 1)
	else return Color3.new(1, p, q) end
end
local av = nil

local function bb()
  if av then return end
	av = task.spawn(function()
		while ec do
      task.wait(0.05)
			de = (de + 0.005 * bj) % 1
			local c = es(de)
			for d in pairs(ez) do
				if d.ge then d.ge.Color = c end
				if d.qt then d.qt.FillColor = c; d.qt.OutlineColor = c end
				if d.qv then d.qv.TextColor3 = c end
				if d.qw then d.qw.TextColor3 = c end
				if d.gp then d.gp.TextColor3 = c end
        if d.Box then d.Box.Color = c end
				if d.Line then d.Line.Color = c end
      end
		end
		av = nil
	end)
end
function ih:Add(config)
	local fo = config.Entity
  if not fo then return nil end
	local gx = config.Part or by(fo)
	if not gx then return nil end

	if ih:Find(fo) then ih:RemoveEntity(fo) end

	local jh = {
		Name = config.Name or fo.Name,
		Color = config.Color or Color3.fromRGB(255, 255, 255),
		Highlight = config.Highlight ~= false,
		Box = config.Box == true,
		Line = config.Line == true,
		Text = config.Text ~= false,
		Distance = config.Distance == true,
		Health = config.Health == true,
    TextSize = config.TextSize or 11,
		AlwaysOnTop = config.AlwaysOnTop ~= false,
		StudsOffset = config.StudsOffset or Vector3.new(0, 3, 0),

    Size = UDim2.new(0, 150, 0, 52),
	}
	if not ds then
		jh.Box = false
		jh.Line = false
	end

	local d = {
    Entity = fo,
		Part = gx,
    ge = jh,
		Enabled = true,
    qt = nil, iw = nil, qv = nil, qw = nil, qx = nil, gp = nil,
		Box = nil, Line = nil,
    Conns = {},
	}

	if ds then
    pcall(function()
			d.Box = Drawing.new("Square")
			d.Box.Thickness = 1
      d.Box.Filled = false
      d.Box.Visible = false
			d.Line = Drawing.new("Line")
			d.Line.Thickness = 1
			d.Line.Visible = false
		end)
	end

	if jh.Highlight then
		local em = fo
		if fo:IsA("Player") and fo.Character then em = fo.Character end
		pcall(function()
			local jj = em:FindFirstChild("XK_ESP_HL")
			if jj then jj:Destroy() end
		end)
    pcall(function()
			local hl = Instance.new("Highlight")
			hl.Name = "XK_ESP_HL"
			hl.FillColor = jh.Color
			hl.OutlineColor = jh.Color

			hl.FillTransparency = 0.6
			hl.OutlineTransparency = 0.1
      if jh.AlwaysOnTop then hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end
			hl.Adornee = em
      hl.Parent = em
			d.qt = hl
		end)
	end

  pcall(function()
		local jd = Instance.new("BillboardGui")
		jd.Name = "XK_ESP_BB"
		jd.Size = jh.Size
		jd.StudsOffset = jh.StudsOffset
		jd.AlwaysOnTop = true
		jd.LightInfluence = 0
    jd.MaxDistance = 100000
		jd.Adornee = dt(fo, gx)
		jd.Parent = dq
    local n = Instance.new("TextLabel")
		n.Name = "qv"
    n.Size = UDim2.new(1, 0, 0, jh.TextSize + 2)
    n.BackgroundTransparency = 1

		n.Text = jh.Name
		n.TextColor3 = jh.Color
		n.TextStrokeTransparency = 0
    n.TextStrokeColor3 = Color3.new(0, 0, 0)
    n.TextSize = jh.TextSize
		n.Font = Enum.Font.SourceSansBold
		n.Visible = jh.Text
		n.Parent = jd

		local hp = Instance.new("TextLabel")
		hp.Name = "HP"
		hp.Size = UDim2.new(1, 0, 0, jh.TextSize + 2)
		hp.Position = UDim2.new(0, 0, 0, jh.TextSize + 2)
		hp.BackgroundTransparency = 1
		hp.Text = ""
		hp.TextColor3 = jh.Color
		hp.TextStrokeTransparency = 0
		hp.TextStrokeColor3 = Color3.new(0, 0, 0)
    hp.TextSize = jh.TextSize - 1
		hp.Font = Enum.Font.SourceSans
		hp.Visible = false
		hp.Parent = jd

		local dl = Instance.new("TextLabel")

		dl.Name = "qw"
		dl.Size = UDim2.new(1, 0, 0, jh.TextSize)
		dl.Position = UDim2.new(0, 0, 0, jh.TextSize * 2 + 4)
		dl.BackgroundTransparency = 1
		dl.Text = "-"
		dl.TextColor3 = jh.Color
		dl.TextStrokeTransparency = 0
		dl.TextStrokeColor3 = Color3.new(0, 0, 0)
		dl.TextSize = jh.TextSize - 1

		dl.Font = Enum.Font.SourceSans
		dl.Visible = jh.Distance
		dl.Parent = jd
    local il = Instance.new("TextLabel")
    il.Name = "qx"
		il.Size = UDim2.new(1, 0, 0, jh.TextSize)
		il.Position = UDim2.new(0, 0, 0, jh.TextSize * 3 + 4)
		il.BackgroundTransparency = 1
		il.Text = ""
		il.TextColor3 = Color3.new(1, 1, 1)
    il.TextStrokeTransparency = 0
		il.TextStrokeColor3 = Color3.new(0, 0, 0)
		il.TextSize = jh.TextSize - 1
    il.Font = Enum.Font.SourceSans
		il.Visible = false

		il.Parent = jd
    d.iw, d.qv, d.qw, d.qx, d.gp = jd, n, dl, il, hp
  end)

	local ie = bu(fo)
	if ie then
		cq(d)
		d.Conns[#d.Conns + 1] = ie.HealthChanged:Connect(function()
			cq(d)
		end)
	end
	d.Conns[#d.Conns + 1] = fo.AncestryChanged:Connect(function(_, gg)
    if gg == nil then
			for _, c in ipairs(d.Conns) do pcall(function() c:Disconnect() end) end
      pcall(function() if d.qt then d.qt:Destroy() end end)
			pcall(function() if d.iw then d.iw:Destroy() end end)
			pcall(function() if d.Box then d.Box:Remove() end end)
			pcall(function() if d.Line then d.Line:Remove() end end)
			ez[d] = nil
			cy()
		end
	end)
  ez[d] = true

	local ix = {}
  ix.Data = d
	ix.Entity = fo

	function ix:SetText(t)
		jh.Name = t
    if d.qv then d.qv.Text = t end
	end
  function ix:SetColor(c)
    jh.Color = c
		if d.qt then d.qt.FillColor = c; d.qt.OutlineColor = c end
    if d.qv then d.qv.TextColor3 = c end
		if d.qw then d.qw.TextColor3 = c end
		if d.gp then d.gp.TextColor3 = c end
		if d.Box then d.Box.Color = c end
		if d.Line then d.Line.Color = c end
	end
	function ix:SetEnabled(v)
    d.Enabled = v
		if d.qt then d.qt.Enabled = v end
    if d.iw then d.iw.Enabled = v end
    if not v then
			if d.Box then d.Box.Visible = false end
			if d.Line then d.Line.Visible = false end
    end
  end

	function ix:SetInfo(t)
		if d.qx then
			if t and t ~= "" then
				d.qx.Text = t
				d.qx.Visible = true
			else
				d.qx.Visible = false
			end
		end
	end

	function ix:SetPart(p)
    d.Part = p
		if d.iw then pcall(function() d.iw.Adornee = dt(fo, p) end) end
	end

	function ix:SetConfig(jf, val)
    jh[jf] = val
		if jf == "Text" then
      if d.qv then d.qv.Visible = val end

    elseif jf == "Distance" then
			if d.qw then d.qw.Visible = val end
			cy()
    elseif jf == "Box" or jf == "Line" then

			if not ds then jh[jf] = false end
      cy()
		elseif jf == "Health" then
			cq(d)
		elseif jf == "TextSize" then
			if d.qv then d.qv.TextSize = val end
			if d.qw then d.qw.TextSize = val - 1 end
			if d.qx then d.qx.TextSize = val - 1 end
			if d.gp then d.gp.TextSize = val - 1 end
		elseif jf == "Highlight" then
			if d.qt then d.qt.Enabled = val end
		elseif jf == "Color" then
			ix:SetColor(val)
		elseif jf == "Name" then
			ix:SetText(val)
    end
	end

	function ix:Remove()
		for _, c in ipairs(d.Conns) do pcall(function() c:Disconnect() end) end
		pcall(function() if d.qt then d.qt:Destroy() end end)
    pcall(function() if d.iw then d.iw:Destroy() end end)

		pcall(function() if d.Box then d.Box:Remove() end end)

		pcall(function() if d.Line then d.Line:Remove() end end)
		ez[d] = nil
		cy()
	end

	return ix
end
function ih:Find(fo)
	for d in pairs(ez) do
    if d.Entity == fo then return true end
	end
	return false
end

function ih:RemoveEntity(fo)
  for d in pairs(ez) do
		if d.Entity == fo then

			for _, c in ipairs(d.Conns) do pcall(function() c:Disconnect() end) end
			pcall(function() if d.qt then d.qt:Destroy() end end)
			pcall(function() if d.iw then d.iw:Destroy() end end)
			pcall(function() if d.Box then d.Box:Remove() end end)
			pcall(function() if d.Line then d.Line:Remove() end end)
			ez[d] = nil
		end
	end
	cy()
end

function ih:RemoveAll()
	for d in pairs(ez) do
		for _, c in ipairs(d.Conns) do pcall(function() c:Disconnect() end) end
		pcall(function() if d.qt then d.qt:Destroy() end end)
		pcall(function() if d.iw then d.iw:Destroy() end end)
		pcall(function() if d.Box then d.Box:Remove() end end)
		pcall(function() if d.Line then d.Line:Remove() end end)
		ez[d] = nil
	end
	cy()
end

function ih:Count()
	local n = 0
	for _ in pairs(ez) do n = n + 1 end
	return n
end

local dx = {
	Enabled = false,
  Highlight = true,
	Box = false,
	Line = false,
	Text = true,
	Distance = true,
	Health = true,
	TextSize = 11,
	TeamCheck = true,
  TeamColor = Color3.fromRGB(80, 230, 120),
	EnemyColor = Color3.fromRGB(255, 70, 70),
  MaxDist = 1000,
}
local di = {}
local cr = {}
local function cc(player)
	if not dx.TeamCheck then return dx.TeamColor end
	local ok, hb = pcall(function()
    return player.Team ~= nil and LP.Team ~= nil and player.Team == LP.Team
	end)
	if ok and hb then return dx.TeamColor end
  return dx.EnemyColor
end

local function bz(player, gz)
	if player == LP or not gz then return end
	local jk = gz:FindFirstChild("HumanoidRootPart")
	if not jk then return end
	if di[player] then
		di[player]:Remove()
		di[player] = nil
	end
	di[player] = ih:Add({
		Entity = player,
    Part = jk,
    Name = player.Name,
		Color = cc(player),

		Highlight = dx.Highlight,
		Box = dx.Box,
		Line = dx.Line,
		Text = dx.Text,
		Distance = dx.Distance,
		Health = dx.Health,
		TextSize = dx.TextSize,
		AlwaysOnTop = false,
	})
end
local function bc(player)
	if cr[player] then
		for _, c in ipairs(cr[player]) do
      pcall(function() c:Disconnect() end)
		end
		cr[player] = nil
	end
	if di[player] then
		di[player]:Remove()
		di[player] = nil
	end
end
local function cx(player)
	if player == LP then return end
	bc(player)
	local hz = {}
	cr[player] = hz

	hz[#hz + 1] = player.CharacterAdded:Connect(function(gz)
		task.wait(0.15)
		if dx.Enabled then bz(player, gz) end
	end)

	hz[#hz + 1] = player.CharacterRemoving:Connect(function()

    if di[player] then
      di[player]:Remove()
			di[player] = nil
		end
  end)
	hz[#hz + 1] = player:GetPropertyChangedSignal("Team"):Connect(function()
    if di[player] then
			di[player]:SetColor(cc(player))
		end
	end)

	if dx.Enabled and player.Character then

		bz(player, player.Character)
	end
end
local function ad()
  for p in pairs(di) do
		if di[p] then di[p]:Remove() end
		di[p] = nil
	end
end

local function y()
  ad()
	for _, p in ipairs(P:GetPlayers()) do
		if p ~= LP then cx(p) end
	end
end

local function bd(jf, val)
	dx[jf] = val
	for _, ix in pairs(di) do
		ix:SetConfig(jf, val)
  end
	if jf == "TeamCheck" or jf == "TeamColor" or jf == "EnemyColor" then
		for p, ix in pairs(di) do
      ix:SetColor(cc(p))
		end
	end
end
P.PlayerAdded:Connect(function(p)
	if dx.Enabled then
		task.wait(0.3)
		cx(p)
	else
		cx(p)
	end
end)
P.PlayerRemoving:Connect(bc)

LP.CharacterAdded:Connect(function()
	task.wait(0.5)
	if dx.Enabled then y() end
end)

local fy = {
	Enabled = false,
	Highlight = true,
	Box = false,
	Line = false,
	Text = true,
	Distance = true,
  Health = true,
	TextSize = 11,
	Color = Color3.fromRGB(255, 160, 60),
	Keyword = "",
  Fuzzy = true,
	MaxDist = 1000,
	Limit = 120,
}

local fh = {}

local function bf(model)
	for _, p in ipairs(P:GetPlayers()) do
		if p.Character == model then return true end
  end
	return false
end

local function ee(model)
	if not fy.Enabled then return false end
	if model == LP.Character then return false end
  if bf(model) then return false end

	local ok, sz = pcall(function() return model:GetExtentsSize() end)
	if ok and sz and sz.Magnitude > 500 then return false end

	if fy.Keyword ~= "" then
		local ho = string.lower(model.Name or "")
		local jf = string.lower(fy.Keyword)
		if fy.Fuzzy then
      return string.find(ho, jf, 1, true) ~= nil
		end
		return ho == jf
	end

	return model:FindFirstChildOfClass("Humanoid") ~= nil
end

local function ei()
  local n = 0
	for _ in pairs(fh) do n = n + 1 end
	return n
end

local function ej(model)
	if fh[model] then return end
  if ei() >= fy.Limit then return end
	local gx = by(model)
  if not gx then return end
  fh[model] = ih:Add({
		Entity = model,
    Part = gx,
		Name = model.Name,
		Color = fy.Color,
		Highlight = fy.Highlight,
    Box = fy.Box,
		Line = fy.Line,
		Text = fy.Text,
		Distance = fy.Distance,
		Health = fy.Health,
		TextSize = fy.TextSize,
		AlwaysOnTop = true,
	})
end

local function ek()
  if not fy.Enabled then return end
  pcall(function()
		for _, v in ipairs(W:GetDescendants()) do
      if v:IsA("Model") and ee(v) then ej(v) end
		end
	end)
end

local function bg()
  for m, ix in pairs(fh) do
		if ix then ix:Remove() end
		fh[m] = nil
	end
end

local function cz()
  bg()
	ek()
end
local function ea(jf, val)
	fy[jf] = val
	for _, ix in pairs(fh) do
		ix:SetConfig(jf, val)
	end
end

local function cu()
	if co then return end
  br = true
  co = task.spawn(function()
    while br do
      task.wait(0.5)
			if dx.Enabled then
				for _, p in ipairs(P:GetPlayers()) do
          if p ~= LP then
						if not di[p] and p.Character then
							local jk = p.Character:FindFirstChild("HumanoidRootPart")
							if jk then
								if not cr[p] then cx(p) end
								bz(p, p.Character)
							end
						elseif di[p] then
							local d = di[p].Data
							if d and d.Part and d.Part.Parent == nil then
								di[p]:Remove()
								di[p] = nil
              end
						end
          end
				end
			end
			if fy.Enabled then
				for m, ix in pairs(fh) do
					if not m.Parent or not ix then
            if ix then ix:Remove() end
						fh[m] = nil
					end
				end
      end
    end
	end)
end

task.spawn(function()
	cu()
end)

W.DescendantAdded:Connect(function(v)
	if not v:IsA("Model") then return end
	if not fy.Enabled then return end
	task.wait(0.3)
	if ee(v) then ej(v) end
end)

local fp = ex:CreateWindow({
	Title = "Xk Hub(cn-zh)🇨🇳",
	Footer = LP.Name .. " | " .. (function()
		local ok, n = pcall(function()
			return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
		end)
    return ok and n or "通用"
	end)(),
	Center = true,
	AutoShow = true,
  Resizable = true,
  NotifySide = "Right",
  ShowCustomCursor = true,
})

local hq = {
	Main = fp:AddTab("基本功能", "layout-dashboard"),
	Exploit = fp:AddTab("剥削", "bug"),
	Aim = fp:AddTab("自瞄", "crosshair"),
	Hit = fp:AddTab("打击盒", "maximize"),
	Settings = fp:AddTab("设置", "settings"),
	Vis = fp:AddTab("视觉", "eye"),
}

if not ds then
  hq.Vis:UpdateWarningBox({
    Visible = true,
    Title = "Drawing 不可用",
		Text = "当前执行器不支持 Drawing，方框、追踪线、FOV 圈已禁用。其余功能不受影响。",
    IsNormal = false,
		LockSize = true,
	})
end
local function fu(title, text, time)
	pcall(function()
		ex:Notify({ Title = title, Description = text, Time = time or 4 })
	end)
end
local function fi()
	return LP.Character
end

local function gb()
	local c = fi()
	return c and c:FindFirstChild("HumanoidRootPart") or nil
end

local function fz()
  local c = fi()
  return c and c:FindFirstChildOfClass("Humanoid") or nil
end
local gs = hq.Main:AddLeftGroupbox("玩家", "user")
local gt = hq.Main:AddRightGroupbox("移动", "move")

local en = { Walk = 16, Jump = 50, On = false }
local bw = "未检测"
local eb = nil

local function dg()
	local h = fz()
	if not h then return nil end
	local iy = pcall(function() h.WalkSpeed = en.Walk end)
	local iz = pcall(function()

    h.UseJumpPower = true
		h.JumpPower = en.Jump
	end)
	return (iy or iz) and h or nil
end

local function aa()
	local h = dg()
	if not h then
    bw = "无角色"
		return
	end
	task.wait(0.35)
	local h2 = fz()
  if not h2 then
		bw = "角色丢失"
		return
	end
	local it, iv = false, false
	pcall(function() it = math.abs(h2.WalkSpeed - en.Walk) < 0.6 end)
	pcall(function() iv = math.abs(h2.JumpPower - en.Jump) < 0.6 end)
	if it and iv then
		bw = "支持"
	elseif it or iv then
		bw = "部分支持"
  else
    bw = "不支持(服务器覆盖)"
	end
end

gs:AddSlider("JumpPower", {
  Text = "跳跃强度",
  Default = 50, Min = 0, Max = 500, Rounding = 0,
  Callback = function(v)
		en.Jump = v
		if en.On then pcall(dg) end
  end,
})
local function dn()
	en.On = false
	if eb then
		eb:Disconnect()
		eb = nil
	end
	pcall(function()
		local h = fz()

		if h then
			h.WalkSpeed = 16
			h.JumpPower = 50
		end
	end)
end

local function dd()
	en.On = true
	aa()
	if not eb then
    eb = RS.Heartbeat:Connect(function()
      if not en.On then return end
			pcall(dg)
		end)
	end
	task.delay(0.6, function()
		if en.On then
			fu("XK Hub", "　　　速度检测: " .. bw .. "　　　", 4)
		end
	end)
end
gs:AddSlider("WalkSpeed", {
	Text = "行走速度",
	Default = 16, Min = 0, Max = 500, Rounding = 0,
	Callback = function(v)
		en.Walk = v
		if en.On then pcall(dg) end
	end,
})


gs:AddToggle("SpeedEnable", {
  Text = "启用速度修改",
	Default = false,
	Tooltip = "开启时持续写入并检测服务器是否允许",
	Callback = function(v)
		if v then
			dd()
		else
			dn()
		end
	end,
})
gs:AddButton({
	Text = "检测是否支持",

	Icon = "search",

	Func = function()
    aa()
		fu("XK Hub", "　　　速度: " .. bw .. "　　　", 5)
	end,
})
local fd = 50

gs:AddSlider("FlySpeed", { Text = "飞行速度", Default = 50, Min = 5, Max = 300, Rounding = 0, Callback = function(v) fd = v end })

gs:AddDivider()
gs:AddButton({
  Text = "重置速度",
  Icon = "rotate-cw",
	Func = function()
    local h = fz()
    if h then

			pcall(function() h.WalkSpeed = 16; h.JumpPower = 50 end)
		end
		fu("XK Hub", "　　　已重置　　　", 3)
	end,
})

local fn = nil

local function ed()
	local ey = LP
	local dz = ey.Character
	if not dz then return end

	local el = dz:FindFirstChildOfClass("Humanoid")
	local hx = dz:FindFirstChild("Head")
  if not el or not hx then return end
	el.PlatformStand = true
	hx.Anchored = true

  if fn then
		fn:Disconnect()
		fn = nil
	end
  fn = RS.Heartbeat:Connect(function(deltaTime)
		if not dz or not el or not hx then
			if fn then

				fn:Disconnect()
				fn = nil
      end
			return
		end

		local ar = el.MoveDirection * (fd * deltaTime)
		local dj = hx.CFrame
		local gf = W.CurrentCamera
		local ax = gf.CFrame

		local be = dj:ToObjectSpace(ax).Position
		ax = ax * CFrame.new(-be.X, -be.Y, -be.Z + 1)
		local aj = ax.Position
		local bn = dj.Position

		local a = CFrame.new(aj, Vector3.new(bn.X, aj.Y, bn.Z)):VectorToObjectSpace(ar)

    hx.CFrame = CFrame.new(bn) * (ax - aj) * CFrame.new(a)
	end)
end

local function eh()
	local ey = LP
	local dz = ey.Character

	if fn then
    fn:Disconnect()
		fn = nil
  end

  if dz then
		local el = dz:FindFirstChildOfClass("Humanoid")
		local hx = dz:FindFirstChild("Head")
		if el then el.PlatformStand = false end
		if hx then hx.Anchored = false end
	end
end


gt:AddToggle("FlyToggle", {
	Text = "飞行",
	Default = false,
  Tooltip = "用 WASD 控制方向",
	Callback = function(v)
		if v then ed() else eh() end
	end,
}):AddKeyPicker("FlyKey", { Default = "F", Mode = "Toggle", SyncToggleState = true, Text = "飞行" })

gt:AddToggle("InfJump", {
	Text = "无限跳",
	Default = false,
  Callback = function(v) io = v end,
})
io = false
jc.JumpRequest:Connect(function()
	if io then
		local h = fz()

		if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end) end
	end
end)
local bl = nil
gt:AddToggle("InfStamina", {
	Text = "无限体力",
	Default = false,
	Callback = function(v)
		if v then
			pcall(function()
				bl = {}
				for _, ix in pairs(getgc(true)) do
          if type(ix) == "table" and rawget(ix, "Stamina") ~= nil then
            table.insert(bl, { t = ix, v = rawget(ix, "Stamina") })
						local mt = getrawmetatable(ix)
            if mt then
              setreadonly(mt, false)
							mt.__index = newcclosure(function(t, k)
								if k == "Stamina" then return 100 end
								return rawget(t, k)
							end)
							setreadonly(mt, true)
						end
          end
				end
      end)
      fu("XK Hub", "　　　无限体力已开启　　　", 3)
		else
			pcall(function()
				if bl then
					for _, d in ipairs(bl) do
            rawset(d.t, "Stamina", d.v)
          end
					bl = nil
				end
      end)
		end
	end,
})
local eq = false
local da = nil

gt:AddToggle("NoClip", {
	Text = "穿墙",

	Default = false,
	Callback = function(v)
    eq = v
		if v then

      da = RS.Stepped:Connect(function()
				local c = fi()
				if not c then return end
				for _, p in ipairs(c:GetDescendants()) do
					if p:IsA("BasePart") then pcall(function() p.CanCollide = false end) end
				end
			end)
		else
			if da then da:Disconnect() da = nil end
      local c = fi()
			if c then
        for _, p in ipairs(c:GetDescendants()) do
					if p:IsA("BasePart") then pcall(function() p.CanCollide = true end) end
				end
			end
    end
	end,
}):AddKeyPicker("NoClipKey", { Default = "N", Mode = "Toggle", SyncToggleState = true, Text = "穿墙" })

gt:AddToggle("AntiAFK", {
	Text = "防挂机被踢",
	Default = false,
  Callback = function(v)
		jm = v
	end,
})
jm = false
pcall(function()
  LP.Idled:Connect(function()
    if jm then
			pcall(function()
        local vu = game:GetService("VirtualUser")
        vu:Button2Down(Vector2.new(0, 0), W.CurrentCamera.CFrame)
				task.wait(1)
				vu:Button2Up(Vector2.new(0, 0), W.CurrentCamera.CFrame)
			end)
    end
  end)
end)

local fm = nil

local ap = nil

local function bo()
	if ap then return end
  ap = task.spawn(function()
		while jn do

      task.wait(1)
			pcall(function()
				local jk = gb()
				if jk then
					if jk.Position.Y > -50 then fm = jk.Position end
        end
			end)
		end
    ap = nil
  end)
end
local bq = nil

gt:AddToggle("AntiVoid", {
	Text = "禁止虚空伤害",
	Default = false,
	Callback = function(v)
		jn = v
		if v then
			bo()
      if bq then return end
			bq = RS.Heartbeat:Connect(function()
				if not jn then return end
				pcall(function()

					local jk = gb()
					if jk and jk.Position.Y < -80 and fm then
						jk.CFrame = CFrame.new(fm + Vector3.new(0, 5, 0))
					end
				end)
			end)
		else
			if bq then bq:Disconnect() bq = nil end
		end
  end,
})
jn = false

gt:AddToggle("InstantInteract", {
	Text = "即时互动",
  Default = false,
	Callback = function(v)
		pcall(function()
      for _, d in ipairs(W:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
          pcall(function() d.HoldDuration = v and 0 or 1 end)
				elseif d:IsA("ClickDetector") then
					pcall(function() d.MaxActivationDistance = v and 500 or 32 end)
				end
      end
    end)
	end,
})
W.DescendantAdded:Connect(function(d)
  if ff.InstantInteract and ff.InstantInteract.Value then
		pcall(function()
			if d:IsA("ProximityPrompt") then d.HoldDuration = 0
			elseif d:IsA("ClickDetector") then d.MaxActivationDistance = 500 end
    end)
  end
end)

gt:AddToggle("AutoInteract", {
	Text = "自动互动",
	Default = false,
	Callback = function(v)
		jo = v
	end,
})

jo = false

local ca = {}
local au = false

local function g()
	for i = #ca, 1, -1 do ca[i] = nil end
  pcall(function()
		for _, d in ipairs(W:GetDescendants()) do
      if d:IsA("ProximityPrompt") then
        table.insert(ca, d)
			end
		end
	end)
  au = true
end

W.DescendantAdded:Connect(function(d)
  if d:IsA("ProximityPrompt") then
		table.insert(ca, d)
	end
end)

task.spawn(function()

	while true do
		task.wait(0.6)
		if jo then

      if not au then g() end
			pcall(function()
				local jk = gb()

				if not jk then return end
				for _, d in ipairs(ca) do
					if d.Parent and d.Enabled then
						local gg = d:FindFirstAncestorWhichIsA("BasePart")
							or d:FindFirstAncestorWhichIsA("Model")
						if gg then
							local je = gg:IsA("BasePart") and gg.Position
								or (gg:FindFirstChild("HumanoidRootPart") and gg.HumanoidRootPart.Position)
              if je and (je - jk.Position).Magnitude < 20 then

								pcall(function() fireproximityprompt(d) end)
              end
						end
					end
        end
      end)
    end
	end
end)
local gv = hq.Main:AddLeftGroupbox("控制", "gamepad-2")

local ci = {}
local ai = nil

local function l()
  ci = {}
  for _, p in ipairs(P:GetPlayers()) do
    if p ~= LP then table.insert(ci, p.Name) end
	end
end
l()
P.PlayerAdded:Connect(l)

P.PlayerRemoving:Connect(l)

local az = gv:AddDropdown("SelectPlayer", {
	Values = ci,
	Default = 1,
  Multi = false,
  Text = "选择玩家",
	Callback = function(v)
    ai = v
	end,
})

gv:AddButton({
	Text = "刷新玩家列表",
	Icon = "refresh-cw",
  Func = function()

		l()
		pcall(function() az:SetValues(ci) end)
    fu("XK Hub", "　　　已刷新，共 " .. tostring(#ci) .. " 人　　　", 3)
	end,
})

local function bt()
	if not ai then return nil end
  for _, p in ipairs(P:GetPlayers()) do
		if p.Name == ai then return p end
	end
	return nil
end

gv:AddButton({
	Text = "传送到玩家",
	Icon = "navigation",
  Func = function()
		local t = bt()
		local jk = gb()
		if t and t.Character and jk then
			local ha = t.Character:FindFirstChild("HumanoidRootPart")
			if ha then pcall(function() jk.CFrame = ha.CFrame + Vector3.new(0, 3, 0) end) end
		end
	end,
})

gv:AddButton({

	Text = "下方传送",
	Icon = "move-down",
	Func = function()
		local t = bt()
    local jk = gb()
		if t and t.Character and jk then
			local ha = t.Character:FindFirstChild("HumanoidRootPart")
			if ha then pcall(function() jk.CFrame = ha.CFrame - Vector3.new(0, 8, 0) end) end
    end
	end,
})

local ag = false
pcall(function()
	if type(gb) == "function" then
    local r = gb()
    if r and r.CanSetNetworkOwnership then ag = true end
	end
end)
gv:AddButton({
	Text = "甩飞[需网络所有权]",
	Icon = "sparkles",
	Func = function()
    local t = bt()
		if not t or not t.Character then
			fu("XK Hub", "　　　未选择目标　　　", 3)
      return
		end
		local ha = t.Character:FindFirstChild("HumanoidRootPart")
    if not ha then
			fu("XK Hub", "　　　目标无 HumanoidRootPart　　　", 3)

			return
		end
		local fk = false
		pcall(function()
      if ha.CanSetNetworkOwnership and ha:CanSetNetworkOwnership() then
				ha:SetNetworkOwner(LP)
        fk = true
      end
			for _, bp in ipairs(t.Character:GetDescendants()) do
				if bp:IsA("BasePart") then
					pcall(function()
						if bp.CanSetNetworkOwnership and bp:CanSetNetworkOwnership() then bp:SetNetworkOwner(LP) end
					end)
        end
      end
    end)

		local gk = 0
    local fc
		fc = RS.Heartbeat:Connect(function()
			gk = gk + 1
			if gk > 90 then
        fc:Disconnect()
				return
			end
			pcall(function()
				if not ha.Parent then fc:Disconnect() return end
        ha.AssemblyAngularVelocity = Vector3.new(0, 250, 0)
        ha.AssemblyLinearVelocity = Vector3.new(math.random(-1, 1) * 350, 950, math.random(-1, 1) * 350)
      end)
		end)
    if fk then

			fu("XK Hub", "　　　已取得所有权，甩飞中　　　", 4)
		else
			fu("XK Hub", "　　　未取得所有权，服务器通常会拉回　　　", 5)
		end
	end,
})

local ew = false
local dr = nil

gv:AddToggle("BringPlayer", {
	Text = "带来[客户端]",
	Default = false,

	Tooltip = "每帧把目标拉到身边，服务器可能拉回",
	Callback = function(v)
    ew = v
		if v then
			if dr then return end
			dr = RS.RenderStepped:Connect(function()
        if not ew then return end
				local t = bt()
        local jk = gb()
				if not t or not jk then return end
				local gz = t.Character
				if not gz then return end
        pcall(function()
					local ha = gz:FindFirstChild("HumanoidRootPart")
					if ha then
						ha.CFrame = jk.CFrame + jk.CFrame.LookVector * 4
          end
        end)
			end)
		else
      if dr then
        dr:Disconnect()
        dr = nil
      end
		end
  end,
})

local fx = false
local eo = nil

gv:AddToggle("ViewPlayer", {
	Text = "查看玩家[观察]",
	Default = false,
	Tooltip = "目标死亡重生后自动重新锁定",

	Callback = function(v)
    fx = v
		if v then
			if eo then return end
			eo = RS.RenderStepped:Connect(function()
				if not fx then return end
				local t = bt()

        if not t then return end

				local gz = t.Character
				if not gz then return end
        pcall(function()
          local h = gz:FindFirstChildOfClass("Humanoid")
					if h and ja.CameraSubject ~= h then
            ja.CameraSubject = h
					end
        end)
			end)
		else
			if eo then
        eo:Disconnect()
				eo = nil
			end
			pcall(function()
				local h = fz()
				if h then ja.CameraSubject = h end
			end)
		end
	end,
})

gv:AddButton({
  Text = "退出观察",
	Icon = "x",
	Func = function()
		pcall(function()
			local h = fz()
			if h then ja.CameraSubject = h end
    end)
	end,
})
local gd = false
local ef = nil

gv:AddToggle("LockBack", {
	Text = "锁背",
	Default = false,
	Callback = function(v)
    gd = v
		if v then
      ef = RS.RenderStepped:Connect(function()

				if not gd then return end
        local t = bt()
				local jk = gb()
        if t and t.Character and jk then
					local ha = t.Character:FindFirstChild("HumanoidRootPart")
          if ha then
						pcall(function()
							jk.CFrame = ha.CFrame * CFrame.new(0, 0, 3)
							ja.CFrame = CFrame.new(ja.CFrame.Position, ha.Position)
            end)
					end
        end
			end)
		else
			if ef then ef:Disconnect() ef = nil end
    end
	end,
})

local fb = false
local du = nil

local df = 0
local dc = 0.15

gv:AddToggle("Orbit", {
	Text = "环绕",
	Default = false,
	Callback = function(v)
		fb = v
		if v then
			du = RS.RenderStepped:Connect(function()
				if not fb then return end
				local t = bt()
        local jk = gb()
				if t and t.Character and jk then
          local ha = t.Character:FindFirstChild("HumanoidRootPart")
					if ha then
						df = df + dc
						local im = Vector3.new(math.cos(df) * 8, 0, math.sin(df) * 8)
            pcall(function()
							jk.CFrame = CFrame.new(ha.Position + im)
							ja.CFrame = CFrame.new(ja.CFrame.Position, ha.Position)
						end)
					end
				end
      end)
    else
			if du then du:Disconnect() du = nil end
    end
  end,
})

gv:AddSlider("OrbitSpeed", {
	Text = "环绕速度",
	Default = 0.15, Min = 0.01, Max = 2, Rounding = 2,
	Callback = function(v) dc = v end,
})
local gj = hq.Main:AddRightGroupbox("传送", "navigation")
gj:AddInput("CoordInput", { Text="输入坐标", Default="0, 5, 0", Placeholder="X, Y, Z", Finished=true, Callback=function() end })
gj:AddButton({
  Text = "获取当前位置",
	Icon = "locate",
	Func = function()
		local jk = gb()
		if not jk then
			fu("XK Hub", "　　　无角色　　　", 3)
      return
		end
		local p = jk.Position
		local s = string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z)
		pcall(function() fe.CoordInput:SetValue(s) end)
    local fv = false
		pcall(function()
			if type(setclipboard) == "function" then
				setclipboard(s)
        fv = true
			end
    end)
		fu("XK Hub", "　　　" .. s .. (fv and " (已复制)" or " (剪贴板不可用)") .. "　　　", 4)
	end,
})
gj:AddButton({
  Text = "复制坐标到剪贴板",
	Icon = "clipboard-copy",
  Func = function()
    local is = fe.CoordInput.Value or ""
		if is == "" then
			fu("XK Hub", "　　　坐标为空　　　", 3)
      return
		end
		local ok = false
		pcall(function()
			if type(setclipboard) == "function" then
				setclipboard(is)
				ok = true
			end
		end)
    fu("XK Hub", ok and ("　　　已复制: " .. is .. "　　　") or "　　　剪贴板不可用　　　", 4)
  end,
})

gj:AddButton({
  Text = "传送",
	Icon = "navigation",
	Func = function()
		local jk = gb()
		if not jk then return end
    local is = fe.CoordInput.Value or ""
		local xs, ys, zs = is:match("([%-%.%d]+)%s*,%s*([%-%.%d]+)%s*,%s*([%-%.%d]+)")
		if xs and ys and zs then
      pcall(function()
				jk.CFrame = CFrame.new(tonumber(xs), tonumber(ys), tonumber(zs))
			end)
			fu("XK Hub", "　　　已传送　　　", 3)
		else
      fu("XK Hub", "　　　坐标格式错误　　　", 4)
		end
  end,
})

gj:AddDivider()

gj:AddInput("ModelInput", { Text = "模型名字", Default = "", Placeholder = "例如 Door", Finished = true, Callback = function() end })

gj:AddButton({
	Text = "dex++",
	Icon = "boxes",
	Func = function()
		fu("XK Hub", "　　　正在加载 dex++　　　", 3)
    pcall(function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-PlusPlus-Decompiler-Fix-206651"))()
		end)
	end,
})

gj:AddToggle("ModelLoop", {
	Text = "持续传送",
	Default = false,

	Callback = function() end,
})
gj:AddButton({
  Text = "传送",
	Icon = "navigation",
	Func = function()
		local ho = fe.ModelInput.Value or ""
		if ho == "" then return end
		pcall(function()
			local jk = gb()
			if not jk then return end
			for _, v in ipairs(W:GetDescendants()) do
				if v.Name == ho then
					local je = nil
					if v:IsA("BasePart") then je = v.Position
          elseif v:IsA("Model") then
            local pp = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
            if pp then je = pp.Position end
					end

					if je then
						jk.CFrame = CFrame.new(je + Vector3.new(0, 3, 0))
						return
					end
				end
			end
		end)
	end,
})

gj:AddButton({

  Text = "删除",
  Icon = "trash",
  Func = function()
		local ho = fe.ModelInput.Value or ""
		if ho == "" then return end
		pcall(function()
			for _, v in ipairs(W:GetDescendants()) do
				if v.Name == ho then pcall(function() v:Destroy() end) end
      end
    end)
    fu("XK Hub", "　　　已删除　　　", 3)
	end,
})
task.spawn(function()
	while true do
    task.wait(1.5)
		if ff.ModelLoop and ff.ModelLoop.Value then
			local ho = fe.ModelInput.Value or ""
      if ho ~= "" then
				pcall(function()
					local jk = gb()
					if jk then
						for _, v in ipairs(W:GetDescendants()) do
              if v.Name == ho then
								local je = nil
								if v:IsA("BasePart") then je = v.Position
								elseif v:IsA("Model") then
									local pp = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                  if pp then je = pp.Position end
								end
								if je then
									jk.CFrame = CFrame.new(je + Vector3.new(0, 3, 0))
									return
                end
							end
            end
					end
        end)
			end
		end
  end
end)

local hc = hq.Exploit:AddLeftGroupbox("世界", "globe")
local hj = hq.Exploit:AddRightGroupbox("角色", "person-standing")
hc:AddToggle("RemoveFog", {

	Text = "移除雾气",
  Default = false,
	Callback = function(v)
    pcall(function()
			local L = game:GetService("Lighting")
			if v then
        FogSaved = L.FogEnd
				L.FogEnd = 1e6
			else
				if FogSaved then L.FogEnd = FogSaved end
			end
    end)
	end,
})
hc:AddToggle("NoShadows", {
	Text = "移除阴影",
	Default = false,
	Callback = function(v)
		pcall(function()
			local L = game:GetService("Lighting")
			L.GlobalShadows = not v
		end)
  end,
})

hc:AddSlider("Brightness", {
	Text = "亮度",
  Default = 2, Min = 0, Max = 10, Rounding = 1,
	Callback = function(v)
		pcall(function() game:GetService("Lighting").Brightness = v end)
	end,
})
hc:AddDivider()

hc:AddButton({
	Text = "移除所有门",
  Icon = "door-open",
	Func = function()
		pcall(function()

			for _, v in ipairs(W:GetDescendants()) do
				if v.Name:lower():find("door") then pcall(function() v:Destroy() end) end
			end
		end)
		fu("XK Hub", "　　　已移除门　　　", 3)
	end,
})
hc:AddButton({
	Text = "移除装饰贴图",
	Icon = "eraser",
	Func = function()
		pcall(function()
			for _, v in ipairs(W:GetDescendants()) do
				if v:IsA("Decal") or v:IsA("Texture") then
					pcall(function() v:Destroy() end)
				end
			end
    end)
		fu("XK Hub", "　　　已移除贴图　　　", 3)
  end,
})

hc:AddButton({
	Text = "移除座椅",
	Icon = "armchair",
	Func = function()
		pcall(function()
			for _, v in ipairs(W:GetDescendants()) do
				if v:IsA("Seat") or v:IsA("VehicleSeat") then

          pcall(function() v:Destroy() end)
        end
			end
		end)
    fu("XK Hub", "　　　已移除座椅　　　", 3)
	end,
})

hc:AddButton({
	Text = "移除所有杀砖",
	Icon = "skull",
	Func = function()
		pcall(function()
			for _, v in ipairs(W:GetDescendants()) do
				if v:IsA("BasePart") and (v.Name:lower():find("kill") or v.Name:lower():find("lava")) then
          pcall(function() v:Destroy() end)
        end
			end
    end)
    fu("XK Hub", "　　　已移除　　　", 3)
  end,
})
local db = { On = false, Value = 0, Saved = nil }
local cp = nil

hj:AddToggle("GravityEnable", {
	Text = "低重力",
	Default = false,
	Tooltip = "开启时持续写入 workspace.Gravity 并检测",
  Callback = function(v)
		db.On = v
    if v then
			pcall(function() db.Saved = W.Gravity end)
      pcall(function() W.Gravity = db.Value end)
      task.wait(0.35)
			local ok = false

			pcall(function()
				ok = math.abs(W.Gravity - db.Value) < 1
      end)
      fu("XK Hub", "　　　重力: " .. (ok and "支持" or "不支持(服务器覆盖)") .. "　　　", 4)
			if cp then return end
			cp = RS.Heartbeat:Connect(function()
				if not db.On then return end
				pcall(function() W.Gravity = db.Value end)
			end)
    else
			if cp then
				cp:Disconnect()
        cp = nil
			end
			pcall(function()
				W.Gravity = db.Saved or 196.2
      end)
		end
	end,
})
hj:AddSlider("GravityValue", {
  Text = "重力值",
	Default = 0, Min = 0, Max = 300, Rounding = 0,
	Callback = function(v)
		db.Value = v
		if db.On then pcall(function() W.Gravity = v end) end
  end,
})
local eg = { On = false, Value = 3 }

local function at(h)
	local ij = {}
	for _, n in ipairs({ "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "BodyProportionScale" }) do
		local hg = h:FindFirstChild(n)
		if hg then table.insert(ij, hg) end
	end
	return ij
end
local function dk(v)
	local h = fz()
	if not h then return false end
	local hz = at(h)
	if #hz == 0 then return false end
  for _, hg in ipairs(hz) do
		pcall(function() hg.Value = v end)
	end
	return true
end

hj:AddToggle("CharScaleEnable", {
	Text = "角色变大",
  Default = false,
	Tooltip = "需要角色有 BodyHeightScale 等缩放值",
  Callback = function(v)
		eg.On = v
    if v then
      local ok = dk(eg.Value)
			if not ok then
				fu("XK Hub", "　　　该角色不支持缩放(R6或无缩放值)　　　", 5)
				eg.On = false
        pcall(function() ff.CharScaleEnable:SetValue(false) end)
				return
			end
			task.wait(0.35)
			local go = false
			pcall(function()
				local h = fz()
				if h then
					local b = h:FindFirstChild("BodyHeightScale")
					if b then go = math.abs(b.Value - eg.Value) < 0.2 end
				end
			end)
      fu("XK Hub", "　　　角色缩放: " .. (go and "支持" or "被服务器重置") .. "　　　", 4)
		else
			dk(1)
		end
	end,
})

hj:AddSlider("CharScaleValue", {
	Text = "缩放倍数",
  Default = 3, Min = 0.5, Max = 8, Rounding = 1,
	Callback = function(v)
		eg.Value = v
    if eg.On then dk(v) end
  end,
})

hj:AddToggle("Invisible", {

	Text = "隐形[客户端]",
	Default = false,
  Callback = function(v)
    pcall(function()
			local c = fi()
			if not c then return end
			for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then

          pcall(function() p.LocalTransparencyModifier = v and 1 or 0 end)
				end
			end
		end)
	end,
})
local cv = nil

hj:AddToggle("NoFall", {
  Text = "免疫摔落",
	Default = false,
	Callback = function(v)
		jp = v

		if v then
			if cv then return end
			cv = RS.Heartbeat:Connect(function()
				if not jp then return end
				pcall(function()
					local h = fz()
					if h and h:GetState() == Enum.HumanoidStateType.Freefall then
            local jk = gb()
						if jk then jk.Velocity = Vector3.new(jk.Velocity.X, 0, jk.Velocity.Z) end
					end
        end)
			end)
		else
			if cv then cv:Disconnect() cv = nil end
    end
	end,
})
jp = false

hj:AddButton({
  Text = "自杀",
  Icon = "skull",
  Func = function()
		pcall(function()
			local h = fz()
			if h then h.Health = 0 end
		end)
  end,
})
hj:AddButton({
	Text = "重新加入服务器",
	Icon = "rotate-cw",
  Func = function()
		pcall(function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end)
	end,
})

local hw = hq.Aim:AddLeftGroupbox("自瞄", "crosshair")
local hh = hq.Aim:AddRightGroupbox("无声自瞄", "target")
local hf = hq.Aim:AddRightGroupbox("自瞄检测", "shield-check")

local fq = {
	Device = "Camera",
	Enabled = false,
  Smooth = 20,
  ShowFOV = false,
	Radius = 120,
	Silent = false,
	Range = 100,
	TeamCheck = true,
	AliveCheck = true,
  Part = "Head",
	Predict = false,
	BulletSpeed = 1000,
	HardLock = false,
  SmoothLock = false,
	FovColor = Color3.fromRGB(255, 255, 255),
}

local dv = nil
if ds then
  pcall(function()
		dv = Drawing.new("Circle")
		dv.Thickness = 1
		dv.NumSides = 64
		dv.Filled = false
    dv.Color = fq.FovColor
    dv.Radius = fq.Radius
		dv.Visible = true
	end)
end

hw:AddDropdown("AimDevice", { Values = { "Camera", "Mouse" },Default = 1,Multi = false,Text = "瞄准设备",Callback = function(v) fq.Device = v end })

hw:AddToggle("AimEnabled", { Text = "启用自瞄", Default = false, Callback = function(v) fq.Enabled = v end }):AddKeyPicker("AimKey", { Default = "B", Mode = "Toggle", SyncToggleState = true, Text = "自瞄" })

hw:AddSlider("AimSmooth", { Text = "顺畅度", Default = 20, Min = 0, Max = 100, Rounding = 0, Tooltip = "0 = 瞬间锁定，越大越平滑", Callback = function(v) fq.Smooth = v end })

local dp = nil

local function ak()
	if dp then return end
	dp = task.spawn(function()
		while fq.ShowFOV and dv do
			task.wait(0.25)
			pcall(function()
				local vp = ja.ViewportSize

				dv.Position = Vector2.new(vp.X / 2, vp.Y / 2)
      end)
		end
		dp = nil
	end)
end
hw:AddToggle("AimShowFOV", {
	Text = "显示FOV圈",
	Default = false,
	Callback = function(v)
		fq.ShowFOV = v
		if dv then pcall(function() dv.Visible = v and ds end) end
		if v then ak() end
	end,
}):AddColorPicker("AimFovColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Text = "FOV圈颜色",
	Transparency = 0,
	Callback = function(v)
		fq.FovColor = v
		if dv then pcall(function() dv.Color = v end) end
	end,
})
hw:AddSlider("AimRadius", {
  Text = "视野半径",
	Default = 120, Min = 10, Max = 800, Rounding = 0,
	Tooltip = "FOV 圈半径，同时决定自瞄判定范围",
  Callback = function(v)
		fq.Radius = v
		if dv then pcall(function() dv.Radius = v end) end
  end,
})
hw:AddToggle("AimHardLock", {
	Text = "强自瞄",

	Default = false,
	Tooltip = "瞬间锁定，不做插值",
	Callback = function(v)
		fq.HardLock = v
    if v and ff.AimSmoothLock then
			pcall(function() ff.AimSmoothLock:SetValue(false) end)
		end
	end,
})

hw:AddToggle("AimSmoothLock", {
	Text = "平滑自瞄",
	Default = false,
	Tooltip = "按顺畅度插值跟随，不会瞬移",
	Callback = function(v)
		fq.SmoothLock = v
		if v and ff.AimHardLock then
			pcall(function() ff.AimHardLock:SetValue(false) end)
    end
  end,
})
hw:AddToggle("AimPredict", {
  Text = "移动预判",
	Default = false,
	Tooltip = "按目标速度与子弹飞行时间提前量瞄准",
	Callback = function(v) fq.Predict = v end,
})

hw:AddSlider("AimBulletSpeed", { Text="子弹速度",Default=1000, Min = 50, Max = 5000, Rounding = 0,Tooltip="越大提前量越小，不确定就保持 1000",Callback=function(v) fq.BulletSpeed = v end })

hw:AddDropdown("AimPart", { Values = { "Head", "HumanoidRootPart", "Torso", "UpperTorso" }, Default = 1, Multi = false, Text = "打击目标", Callback = function(v) fq.Part = v end })


local function bk(gz)
  if not gz then return nil end
  local p = gz:FindFirstChild(fq.Part)
	if p and p:IsA("BasePart") then return p end
  local h = gz:FindFirstChild("Head")
	if h then return h end
  return gz:FindFirstChild("HumanoidRootPart")
end

local function bv(targetPart)
	if not targetPart then return false end
	local ok, fj = pcall(function()
    local ft = ja.CFrame.Position
		local gl = targetPart.Position - ft
    local fw = RaycastParams.new()
    fw.FilterType = Enum.RaycastFilterType.Blacklist
		local fr = { ja }
		local lc = LP.Character
    if lc then table.insert(fr, lc) end
		fw.FilterDescendantsInstances = fr
		local ik = W:Raycast(ft, gl, fw)
		if not ik then return false end
		local jl = ik.Instance

		if not jl then return false end
		if jl:IsDescendantOf(targetPart.Parent) then return false end
		return true
	end)
  return ok and fj or false
end

local function cs(gx)
	local je = gx.Position
  if not fq.Predict then return je end
	local bs = fq.BulletSpeed or 0
	if bs <= 0 then return je end
  local hm = (je - ja.CFrame.Position).Magnitude
  local t = hm / bs
	if t > 1.5 then t = 1.5 end
  local ii = Vector3.zero
  pcall(function() ii = gx.AssemblyLinearVelocity or Vector3.zero end)
	return je + ii * t
end
local function cb(player)
	if player == LP then return false end
	local gz = player.Character
	if not gz then return false end
  local ie = gz:FindFirstChildOfClass("Humanoid")
  if fq.AliveCheck and (not ie or ie.Health <= 0) then return false end
  if fq.TeamCheck then
		local ok, hb = pcall(function()
			return player.Team ~= nil and LP.Team ~= nil and player.Team == LP.Team
		end)
		if ok and hb then return false end
	end
	local gx = bk(gz)
  if not gx then return false end
  if jq and bv(gx) then return false end
	return true
end
local function ba()
	local ia, er = nil, math.huge
	local vp = ja.ViewportSize
	local fs = Vector2.new(vp.X / 2, vp.Y / 2)
	for _, p in ipairs(P:GetPlayers()) do
		if cb(p) then

      local gx = bk(p.Character)
			local sp, on = ja:WorldToViewportPoint(gx.Position)
			if on then
				local d = (Vector2.new(sp.X, sp.Y) - fs).Magnitude
				if d <= fq.Radius and d < er then
          ia, er = p, d
				end
			end
		end
  end
	return ia
end
RS.RenderStepped:Connect(function()
	if not fq.Enabled then return end
	local t = ba()
	if not t then return end
	local gx = bk(t.Character)
	if not gx then return end
	pcall(function()
		local gc = cs(gx)
		local ht = CFrame.new(ja.CFrame.Position, gc)
		if fq.HardLock or fq.Smooth <= 0 then
			ja.CFrame = ht
		else
			ja.CFrame = ja.CFrame:Lerp(ht, math.clamp(1 / fq.Smooth, 0.02, 1))
		end
	end)
end)
local z = nil
local u = nil
local bh = nil
local ay = false
local al = 0
hh:AddToggle("SilentEnabled", {
  Text = "无声自瞄",
	Default = false,
	Tooltip = "首次开启时才装载钩子，关闭期间零开销",
	Callback = function(v)
    fq.Silent = v
		if v then
			if u then pcall(u) end
			if not ay and z then pcall(z) end
    end
  end,
}):AddKeyPicker("SilentKey", { Default = "M", Mode = "Toggle", SyncToggleState = true, Text = "无声" })

hh:AddSlider("SilentRange", {
	Text = "自瞄距离",
  Default = 100, Min = 10, Max = 1000, Rounding = 0,
	Callback = function(v) fq.Range = v end,
})
hh:AddToggle("SilentTeamCheck", {
  Text = "队伍检测",
	Default = true,
	Callback = function(v) fq.TeamCheck = v end,
})

local function an()
	local ia, gq = nil, math.huge
	local jk = gb()
	if not jk then return nil end
	for _, p in ipairs(P:GetPlayers()) do

		if cb(p) then
			local gx = bk(p.Character)
			if gx then
				local d = (gx.Position - jk.Position).Magnitude
				if d <= fq.Range and d < gq then ia, gq = p, d end
      end
		end
	end
  return ia
end
local ct = nil

u = function()
	if bh then return end
	bh = task.spawn(function()
		while fq.Silent do
			task.wait(0.1)
      local t = an()

			local p = nil
			if t and t.Character then p = bk(t.Character) end
			ct = p
		end
		ct = nil
		bh = nil
	end)
end

local cd = { "shoot", "fire", "hit", "bullet", "damage", "gun", "weapon", "projectile", "ray", "cast", "attack" }
local function am(hg)
	local n = ""
  pcall(function() n = string.lower(hg.Name or "") end)
  if n == "" then return false end
  for _, w in ipairs(cd) do
		if string.find(n, w, 1, true) then return true end
  end
	return false
end

z = function()
	if type(getrawmetatable) ~= "function" then return end
	if type(newcclosure) ~= "function" then return end
  if type(getnamecallmethod) ~= "function" then return end
	local mt = getrawmetatable(game)
	if not mt then return end
	local cj = mt.__namecall
  if not cj then return end
	local bx = pcall(function() setreadonly(mt, false) end)
	if not bx then
		pcall(function() make_writeable(mt) end)
	end
	mt.__namecall = newcclosure(function(self, ...)
    if fq.Silent and ct and ct.Parent then
			local ga = nil
			pcall(function() ga = getnamecallmethod() end)
      if ga == "FireServer" or ga == "InvokeServer" then
				if am(self) then
					local hk = { ... }
          local id = cs(ct)
          local ip = nil
					local hu = gb()
					if hu then ip = hu.Position end
					local ep = 0
					for i, v in ipairs(hk) do
						local tv = typeof(v)
            if tv == "Vector3" then
              local gy = false
							if ip and (v - ip).Magnitude < 6 then gy = true end
							if not gy then

                hk[i] = id
								ep = ep + 1
							end
						elseif tv == "CFrame" then
              hk[i] = CFrame.new(v.Position, id)
							ep = ep + 1
						end
					end
					if ep > 0 then
						al = al + 1
						return cj(self, unpack(hk))
					end
				end
			end
    end
		return cj(self, ...)
	end)
	pcall(function() setreadonly(mt, true) end)

	ay = true
end

local function ab()
	local gm = {}
	pcall(function()
		for _, d in ipairs(game:GetDescendants()) do
			if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
				if am(d) then
          table.insert(gm, d.Name)
				end
			end
		end
	end)
	return gm
end

local ac = hh:AddLabel("　　　未检测　　　", true)

hh:AddButton({

	Text = "检测无声自瞄",
	Icon = "scan-search",
	Tooltip = "扫描射击远端并检查钩子状态",
	Func = function()

		local hz = ab()
		local ev = ay and "已装载" or "未装载"
		local s
		if #hz == 0 then
			s = "　　　钩子: " .. ev .. "　　　\n未发现射击远端，该武器不适用"
		else
			s = "　　　钩子: " .. ev .. "　　　\n发现 " .. #hz .. " 个射击远端:\n"
			for i = 1, math.min(#hz, 6) do
				s = s .. hz[i] .. "\n"
      end
			if #hz > 6 then s = s .. "..." end
		end
		s = s .. "\n已重定向: " .. tostring(al) .. " 次"
		pcall(function() ac:SetText(s) end)
    fu("XK Hub", "　　　检测完成，详见右侧　　　", 5)
	end,
})
hh:AddLabel("原理: 改写射击远端的坐标参数")
hh:AddLabel("开启后才装载钩子，关闭无开销")

hf:AddToggle("AimTeamCheck", { Text = "队伍检测",Default = true,Callback = function(v) fq.TeamCheck = v end })

hf:AddToggle("AimAliveCheck", { Text = "存活检测",Default = true,Callback = function(v) fq.AliveCheck = v end })
hf:AddDivider()
jq = false

hf:AddToggle("AimWallCheck", {
	Text = "墙检测",
	Default = false,
	Tooltip = "目标被墙挡住时不锁定",
	Callback = function(v) jq = v end,
})


local hv = hq.Hit:AddLeftGroupbox("玩家/NPC 打击盒", "maximize")
local hr = hq.Hit:AddRightGroupbox("目标", "target")

local gh = {
	Enabled = false,
	Size = 15,
	Part = "HumanoidRootPart",
  Transparency = 0.4,
	TeamCheck = true,
	Collide = false,
	TargetPlayer = true,
  TargetNPC = true,
	PlayerColor = "黑色",
	NPCColor = "白色",
}

local et = {}
local fg = {}
local eu = nil

local dy = {
	["黑色"] = Color3.fromRGB(0, 0, 0),
	["白色"] = Color3.fromRGB(255, 255, 255),
	["红色"] = Color3.fromRGB(255, 0, 0),
	["绿色"] = Color3.fromRGB(0, 255, 0),
	["蓝色"] = Color3.fromRGB(0, 120, 255),
	["黄色"] = Color3.fromRGB(255, 255, 0),
	["紫色"] = Color3.fromRGB(200, 100, 255),

}

local function ch(gx, isPlayer)
	if fg[gx] == nil then
		fg[gx] = {
			Size = gx.Size,
			Transparency = gx.Transparency,
			CanCollide = gx.CanCollide,
			Color = gx.Color,
		}
	end
	pcall(function()
    gx.Size = Vector3.new(gh.Size, gh.Size, gh.Size)
		gx.Transparency = gh.Transparency

    gx.CanCollide = gh.Collide
		gx.Color = dy[isPlayer and gh.PlayerColor or gh.NPCColor] or Color3.fromRGB(255, 255, 255)
		gx.Massless = true
	end)
end
local function aq(gx)
	local o = fg[gx]
  if not o then return end
	pcall(function()
    gx.Size = o.Size
		gx.Transparency = o.Transparency
		gx.CanCollide = o.CanCollide
		gx.Color = o.Color
    gx.Massless = false
	end)
	fg[gx] = nil
end

local function aw()

	local ij = {}
  if gh.TargetPlayer then
		for _, p in ipairs(P:GetPlayers()) do
      if p ~= LP and p.Character then
				local gy = false
				if gh.TeamCheck then
					local ok, hb = pcall(function()
						return p.Team ~= nil and LP.Team ~= nil and p.Team == LP.Team
					end)
					if ok and hb then gy = true end
				end
				if not gy then
          local gx = p.Character:FindFirstChild(gh.Part)
					if gx and gx:IsA("BasePart") then
						table.insert(ij, { gx = gx, isPlayer = true })
          end
        end
			end
		end
  end
	if gh.TargetNPC then
		pcall(function()
			for _, v in ipairs(W:GetDescendants()) do
				if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and not bf(v) then
					local gx = v:FindFirstChild(gh.Part)
					if gx and gx:IsA("BasePart") then
						table.insert(ij, { gx = gx, isPlayer = false })
					end
        end
			end
		end)
	end
	return ij
end

local function ao()
	for gx in pairs(et) do
		aq(gx)
		et[gx] = nil
	end
  if not gh.Enabled then return end
	for _, t in ipairs(aw()) do
		ch(t.gx, t.isPlayer)
		et[t.gx] = true
	end
end

local function af()
  if eu then return end
	eu = task.spawn(function()
		while gh.Enabled do
      pcall(ao)
			task.wait(0.5)
		end
    eu = nil
	end)
end
local function j()
	local hz = aw()
	if #hz == 0 then
    fu("XK Hub", "　　　范围内无目标，无法检测　　　", 4)
    return "无目标"
	end
  local t = hz[1]
	local gx = t.gx
  ch(gx, t.isPlayer)
	local ib = gh.Size
	local iq = nil
	task.wait(0.5)
	pcall(function() iq = gx.Size.X end)
	aq(gx)
	if iq and math.abs(iq - ib) < 0.6 then
		fu("XK Hub", "　　　打击盒: 服务器支持　　　", 5)
		return "支持"
	end
	fu("XK Hub", "　　　打击盒: 服务器已重置，不支持　　　", 6)
	return "不支持"
end

hv:AddToggle("HitEnabled", {
  Text = "启用范围",
	Default = false,
	Callback = function(v)
		gh.Enabled = v
		if v then
      ao()
      af()
			task.delay(0.8, j)
		else
			for gx in pairs(et) do
        aq(gx)
				et[gx] = nil
      end
		end
	end,
})

hv:AddButton({
	Text = "检测服务器是否支持",
  Icon = "scan-search",
	Func = function()
		j()
  end,
})
hv:AddSlider("HitSize", {
	Text = "Hitbox大小",

	Default = 15, Min = 1, Max = 100, Rounding = 0,
	Callback = function(v)
		gh.Size = v
		if gh.Enabled then ao() end
	end,
})
hv:AddDropdown("HitPart", {
	Values = { "HumanoidRootPart", "Head", "Torso", "UpperTorso", "LeftArm", "RightArm" },
	Default = 1,
  Multi = false,
	Text = "Hitbox部位",
  Callback = function(v)
    gh.Part = v
    if gh.Enabled then
      for gx in pairs(et) do
        aq(gx)
				et[gx] = nil
			end
			ao()
		end
  end,
})

hv:AddSlider("HitTrans", {
	Text = "透明度",
  Default = 0.4, Min = 0, Max = 1, Rounding = 2,
	Callback = function(v)
		gh.Transparency = v
		if gh.Enabled then ao() end
	end,
})

hv:AddToggle("HitTeamCheck", {
	Text = "队伍检查",
	Default = true,
  Callback = function(v)
		gh.TeamCheck = v
    if gh.Enabled then ao() end
	end,
})

hr:AddToggle("HitCollide", {
  Text = "可碰撞",
  Default = false,
  Callback = function(v)
    gh.Collide = v
		if gh.Enabled then ao() end
  end,
})

hr:AddToggle("HitTargetPlayer", {
	Text = "目标玩家",

	Default = true,
  Callback = function(v)
    gh.TargetPlayer = v
		if gh.Enabled then ao() end
	end,
})

hr:AddToggle("HitTargetNPC", {
	Text = "目标NPC",
	Default = true,
  Callback = function(v)
		gh.TargetNPC = v
    if gh.Enabled then ao() end
	end,
})

hr:AddDivider()

hr:AddDropdown("HitPlayerColor", {
	Values = { "黑色", "白色", "红色", "绿色", "蓝色", "黄色", "紫色" },
	Default = 1,
	Multi = false,
	Text = "玩家颜色",
	Callback = function(v)
		gh.PlayerColor = v
		if gh.Enabled then ao() end
	end,
})

hr:AddDropdown("HitNPCColor", {
  Values = { "黑色", "白色", "红色", "绿色", "蓝色", "黄色", "紫色" },
	Default = 2,
	Multi = false,
	Text = "NPC颜色",
	Callback = function(v)
		gh.NPCColor = v
		if gh.Enabled then ao() end
	end,
})

hr:AddButton({
  Text = "还原全部",
	Icon = "rotate-cw",
  Func = function()
		for gx in pairs(et) do
			aq(gx)
			et[gx] = nil
		end
		fu("XK Hub", "　　　已还原　　　", 3)
	end,
})
local ic = hq.Vis:AddLeftGroupbox("玩家 ESP", "users")
local hn = hq.Vis:AddRightGroupbox("NPC ESP", "bug")

local hy = hq.Vis:AddRightGroupbox("视觉", "sun")

ic:AddToggle("ESPToggle", {
	Text = "透视",
	Default = false,
	Callback = function(v)
		dx.Enabled = v
		if v then
			y()
		else
			ad()
    end
	end,
})

ic:AddToggle("ESPHighlight", { Text = "高亮", Default = true, Callback = function(v) bd("Highlight", v) end })

ic:AddToggle("ESPText", { Text="显示名字",Default=true,Callback=function(v) bd("Text", v) end })

ic:AddToggle("ESPHealth", { Text = "血量文字", Default = true, Callback = function(v) bd("Health", v) end })

ic:AddToggle("ESPDistance", { Text = "距离文字",Default = true,Callback = function(v) bd("Distance", v) end })

ic:AddToggle("ESPBox", { Text = "方框", Default = false, Callback = function(v) bd("Box", v) end })

ic:AddToggle("ESPLine", { Text="射线",Default=false,Callback=function(v) bd("Line", v) end })

ic:AddToggle("ESPTeamCheck", { Text="队伍区分",Default=true,Callback=function(v) bd("TeamCheck", v) end })

ic:AddSlider("ESPTextSize", { Text="血量文本大小",Default=11, Min = 7, Max = 18, Rounding = 0,Callback=function(v) bd("TextSize", v) end })

ic:AddDropdown("ESPLineFrom", {
  Values = { "Bottom", "Top", "Center", "Mouse" },
	Default = 1,
	Multi = false,
	Text = "追踪线位置",
	Callback = function(v)
    jr = v
	end,
})
jr = "Bottom"

ic:AddToggle("ESPRainbow", {
	Text = "彩虹文本",
	Default = false,
  Callback = function(v)
		ec = v
		if v then bb() end
  end,
})

ic:AddSlider("ESPRainbowSpeed", {
	Text = "彩虹速度",
	Default = 1, Min = 0.1, Max = 5, Rounding = 1,
	Callback = function(v) bj = v end,
})
ic:AddDivider()

ic:AddLabel("队友颜色"):AddColorPicker("ESPTeamColor", { Default = dx.TeamColor, Title = "队友颜色", Transparency = 0, Callback = function(v) bd("TeamColor", v) end })

ic:AddLabel("敌人颜色"):AddColorPicker("ESPEnemyColor", { Default = dx.EnemyColor, Title = "敌人颜色", Transparency = 0, Callback = function(v) bd("EnemyColor", v) end })

ic:AddButton({
	Text = "刷新玩家 ESP",
	Icon = "refresh-cw",
	Func = function()
		y()
		fu("XK Hub", "　　　已刷新　　　", 3)
	end,
})

hn:AddToggle("NpcESP", {
	Text = "NPC ESP",
	Default = false,
	Callback = function(v)
		fy.Enabled = v
    if v then
      ek()
    else
			bg()
		end
	end,
})

hn:AddInput("NpcKeyword", {
	Text = "模型名字",
  Default = "",
	Placeholder = "留空=NPC模式",
  Finished = true,
  Tooltip = "填名字即按名字标记任意模型",
	Callback = function(v)
		fy.Keyword = v or ""
		if fy.Enabled then cz() end
	end,
})

hn:AddToggle("NpcFuzzy", {
	Text = "包含匹配",
	Default = true,
	Tooltip = "关掉则要求名字完全一致",
	Callback = function(v)
    fy.Fuzzy = v
		if fy.Enabled then cz() end
	end,
})
hn:AddToggle("NpcHighlight", {
	Text = "高亮",
	Default = true,
  Callback = function(v) ea("Highlight", v) end,
})

hn:AddToggle("NpcText", { Text="显示名字", Default=true, Callback=function(v) ea("Text", v) end })
hn:AddToggle("NpcHealth", { Text="血量文字",Default=true,Callback=function(v) ea("Health", v) end })
hn:AddToggle("NpcDistance", { Text = "距离文字", Default = true, Callback = function(v) ea("Distance", v) end })
hn:AddSlider("NpcLimit", {
	Text = "最多画几个",
	Default = 120, Min = 10, Max = 300, Rounding = 0,
  Callback = function(v) fy.Limit = v end,
})

hn:AddDivider()
hn:AddLabel("NPC 颜色"):AddColorPicker("NpcColor", {
	Default = fy.Color,
	Title = "NPC 颜色",
  Transparency = 0,
	Callback = function(v) ea("Color", v) end,
})
hn:AddButton({
	Text = "重新扫描",
	Icon = "refresh-cw",
	Func = function()
		cz()
		fu("XK Hub", "　　　NPC ESP: " .. tostring(ei()) .. " 个　　　", 3)
	end,
})
hn:AddButton({ Text = "清空 NPC ESP", Icon = "trash", Func = function() bg() end })

local bi = nil

hy:AddToggle("ApplyFOV", {
	Text = "应用视野",
	Default = false,
	Callback = function(v)
    js = v
    if v then
			if bi then return end
      bi = RS.RenderStepped:Connect(function()
				if not js then return end
				if fe.FOVSize then
					pcall(function() ja.FieldOfView = fe.FOVSize.Value end)
				end
			end)
		else
			if bi then bi:Disconnect() bi = nil end
			pcall(function() ja.FieldOfView = 70 end)
		end
	end,
})

js = false
hy:AddSlider("FOVSize", {
	Text = "视野大小",
	Default = 70, Min = 30, Max = 120, Rounding = 0,

	Callback = function(v)
		if js then pcall(function() ja.FieldOfView = v end) end
	end,
})

hy:AddToggle("NightVision", {
	Text = "夜视",
	Default = false,
	Callback = function(v)
		pcall(function()

			local L = game:GetService("Lighting")

			if v then
        L.Ambient = Color3.fromRGB(255, 255, 255)
        L.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			else
        L.Ambient = Color3.fromRGB(0, 0, 0)
        L.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      end
		end)
	end,
})

hy:AddToggle("AntiShadow", {
	Text = "反阴影",
  Default = false,
	Callback = function(v)
		pcall(function()
			local L = game:GetService("Lighting")
			L.GlobalShadows = not v
			if v then
				for _, d in ipairs(W:GetDescendants()) do
					if d:IsA("BasePart") then pcall(function() d.CastShadow = false end) end
				end
			end
		end)
	end,
})
hy:AddToggle("AntiFog", {
	Text = "反雾",
	Default = false,
  Callback = function(v)
		pcall(function()
			local L = game:GetService("Lighting")
			if v then
				L.FogEnd = 1e6
			else
				L.FogEnd = 100000
			end
		end)
	end,
})
hy:AddToggle("FreeZoom", {
	Text = "自由缩放",
	Default = false,
	Callback = function(v)
		pcall(function()
      if v then
        LP.CameraMinZoomDistance = 0.5
				LP.CameraMaxZoomDistance = 1000
			else
        LP.CameraMinZoomDistance = 0.5
        LP.CameraMaxZoomDistance = 400
			end
		end)
	end,
})
local dw = hq.Settings:AddLeftGroupbox("调试功能", "wrench")

dw:AddToggle("KeybindMenuOpen", { Default = ex.KeybindFrame.Visible, Text = "快捷菜单", Callback = function(v) ex.KeybindFrame.Visible = v end })
dw:AddToggle("ShowCustomCursor", { Text = "自定义光标", Default = true, Callback = function(v) ex.ShowCustomCursor = v end })
dw:AddDropdown("NotificationSide", { Values = { "Left", "Right" }, Default = "Right", Text = "通知位置", Callback = function(v) ex:SetNotifySide(v) end })

dw:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "200%" },
	Default = "100%",
  Text = "UI大小",
	Callback = function(v)
		pcall(function() ex:SetDPIScale(tonumber(v:gsub("%%", ""))) end)
	end,
})

dw:AddDivider()
dw:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu bind" })
ex.ToggleKeybind = fe.MenuKeybind

dw:AddButton({ Text = "卸载脚本", Icon = "power", Func = function() ex:Unload() end })

local ck = hq.Settings:AddRightGroupbox("运行状态", "gauge")
local cm = ck:AddLabel("加载中...", true)

task.spawn(function()
	while true do
		task.wait(2)
    pcall(function()
      cm:SetText(string.format(
				"玩家 ESP: %d\nNPC ESP: %d\n逐帧层: %s\n距离层: %s\n监视层: %s\nDrawing: %s",
				(function() local n = 0 for _ in pairs(di) do n = n + 1 end return n end)(),
        ei(),
				dh and "运行中" or "已停止",
				cl and "运行中" or "已停止",
				br and "运行中" or "已停止",
				ds and "可用" or "不可用"
			))
		end)
	end
end)
if ThemeManager and SaveManager then
	ThemeManager:SetLibrary(ex)
	SaveManager:SetLibrary(ex)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

	ThemeManager:SetFolder("XKScript")
  SaveManager:SetFolder("XKScript/configs")
	SaveManager:BuildConfigSection(hq.Settings)
  ThemeManager:ApplyToTab(hq.Settings)
	SaveManager:LoadAutoloadConfig()
end
for _, p in ipairs(P:GetPlayers()) do
	if p ~= LP then cx(p) end
end

ex:OnUnload(function()
	dx.Enabled = false
  fy.Enabled = false
	flyOn = false
	eq = false
	ec = false
	br = false
  cl = false
	stopFly()
	ad()
	bg()
	for gx in pairs(et) do
		aq(gx)
		et[gx] = nil
  end
	ih:RemoveAll()
	if dh then dh:Disconnect() dh = nil end
	if dv then pcall(function() dv:Remove() end) end
  pcall(function() dq:Destroy() end)
end)

ex:Notify({
  Title = "XK Hub",
	Description = "加载完成",
	Time = 5,
	Icon = "circle-check",
})
