--GunClient
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local GunUI_upvr = script.GunUI
local module = {}
local mouse_upvr = LocalPlayer_upvr:GetMouse()
local GunData_upvr = loadstring(game:HttpGet("https://raw.githubusercontent.com/MaPrawLynx/MaPraw-s-Test/main/GunData.lua"))()
local TweenService_upvr = game:GetService("TweenService")
local FieldOfView_upvr = CurrentCamera_upvr.FieldOfView
local Reload_upvr = ReplicatedStorage.WeaponFramework.Remotes.Reload
local Network_upvr = ReplicatedStorage.WeaponFramework.Remotes.Network
local Click_upvr = game:GetService("SoundService"):WaitForChild("Click")
local UserInputService_upvr = game:GetService("UserInputService")
local Xp_upvr = script:WaitForChild("Xp")
function module.BindGun(arg1) -- Line 30
	--[[ Upvalues[12]:
		[1]: GunUI_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: mouse_upvr (readonly)
		[4]: GunData_upvr (readonly)
		[5]: TweenService_upvr (readonly)
		[6]: CurrentCamera_upvr (readonly)
		[7]: FieldOfView_upvr (readonly)
		[8]: Reload_upvr (readonly)
		[9]: Network_upvr (readonly)
		[10]: Click_upvr (readonly)
		[11]: UserInputService_upvr (readonly)
		[12]: Xp_upvr (readonly)
	]]
	local clone_2_upvr = GunUI_upvr:Clone()
	local Character = LocalPlayer_upvr.Character
	mouse_upvr.TargetFilter = LocalPlayer_upvr.Character
	local var19_upvr = GunData_upvr[arg1.Name]
	var19_upvr.Ammo = 999999999999999
	local DefRecoil_upvw = var19_upvr.DefRecoil
	local Animations = arg1:WaitForChild("Animations")
	local Mag_upvr = clone_2_upvr:WaitForChild("Frame"):WaitForChild("Mag")
	local Mode_upvr = clone_2_upvr:WaitForChild("Frame"):WaitForChild("Mode")
	local Viewmodel = Character:WaitForChild("Viewmodel")
	local AimOffset = Viewmodel:WaitForChild("AimOffset")
	local Aiming_upvr = Viewmodel:WaitForChild("Aiming")
	local Humanoid = Character:WaitForChild("Humanoid")
	local Animator = Humanoid:WaitForChild("Animator")
	local any_LoadAnimation_result1_upvr_2 = Animator:LoadAnimation(Animations.Idle)
	local any_LoadAnimation_result1_upvr_3 = Animator:LoadAnimation(Animations.Shoot)
	local any_LoadAnimation_result1_upvr = Animator:LoadAnimation(Animations.Reload)
	any_LoadAnimation_result1_upvr_2.Priority = Enum.AnimationPriority.Action2
	any_LoadAnimation_result1_upvr_3.Priority = Enum.AnimationPriority.Action2
	any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action2
	local any_Create_result1_3_upvr = TweenService_upvr:Create(AimOffset, TweenInfo.new(0.2), {
		Value = var19_upvr.FocusOffset;
	})
	local any_Create_result1_upvr_2 = TweenService_upvr:Create(AimOffset, TweenInfo.new(0.2), {
		Value = var19_upvr.InitialOffset;
	})
	local any_Create_result1_4_upvr = TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.25), {
		FieldOfView = var19_upvr.ZoomInFov;
	})
	local any_Create_result1_2_upvr = TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.25), {
		FieldOfView = FieldOfView_upvr;
	})
	local var42_upvw = false
	local var43_upvw = false
	local var44_upvw = false
	local var45_upvw = true
	mouse_upvr.Icon = "rbxassetid://126381229318420"
	any_LoadAnimation_result1_upvr_2:Play()
	any_Create_result1_2_upvr:Play()
	any_Create_result1_upvr_2:Play()
	clone_2_upvr.Parent = LocalPlayer_upvr.PlayerGui
	clone_2_upvr:WaitForChild("Frame"):WaitForChild("Name").Text = arg1.Name
	local function _() -- Line 75, Named "updateUI"
		--[[ Upvalues[2]:
			[1]: Mag_upvr (readonly)
			[2]: var19_upvr (readonly)
		]]
		Mag_upvr.Text = var19_upvr.Mag..'/'.."∞"
		Mag_upvr.Text = var19_upvr.Mag..'/'..var19_upvr.Ammo
	end
	Mag_upvr.Text = var19_upvr.Mag..'/'.."∞"
	Mag_upvr.Text = var19_upvr.Mag..'/'..var19_upvr.Ammo
	local function recoil_upvr() -- Line 80, Named "recoil"
		--[[ Upvalues[3]:
			[1]: DefRecoil_upvw (read and write)
			[2]: CurrentCamera_upvr (copied, readonly)
			[3]: var19_upvr (readonly)
		]]
		task.delay(0.1, function() -- Line 82
			--[[ Upvalues[2]:
				[1]: CurrentCamera_upvr (copied, readonly)
				[2]: DefRecoil_upvw (copied, read and write)
			]]
			CurrentCamera_upvr.CFrame *= CFrame.Angles(math.rad(DefRecoil_upvw), 0, 0)
		end)
		local randint_upvr = math.random(-DefRecoil_upvw, DefRecoil_upvw)
		task.delay(var19_upvr.FireRate, function() -- Line 85
			--[[ Upvalues[3]:
				[1]: CurrentCamera_upvr (copied, readonly)
				[2]: DefRecoil_upvw (copied, read and write)
				[3]: randint_upvr (readonly)
			]]
			for _ = 1, 10 do
				CurrentCamera_upvr.CFrame *= CFrame.Angles(math.rad(-DefRecoil_upvw / 15), math.rad(randint_upvr / 15), math.rad(randint_upvr / 15))
				task.wait(0.01)
			end
		end)
	end
	local function reload_upvr() -- Line 93, Named "reload"
		--[[ Upvalues[14]:
			[1]: var19_upvr (readonly)
			[2]: var43_upvw (read and write)
			[3]: var45_upvw (read and write)
			[4]: var44_upvw (read and write)
			[5]: var42_upvw (read and write)
			[6]: Aiming_upvr (readonly)
			[7]: DefRecoil_upvw (read and write)
			[8]: mouse_upvr (copied, readonly)
			[9]: any_Create_result1_2_upvr (readonly)
			[10]: any_Create_result1_upvr_2 (readonly)
			[11]: any_LoadAnimation_result1_upvr (readonly)
			[12]: Reload_upvr (copied, readonly)
			[13]: arg1 (readonly)
			[14]: Mag_upvr (readonly)
		]]
		if var19_upvr.Ammo <= 0 or var43_upvw or var19_upvr.Mag == var19_upvr.Cap or not var45_upvw then
		else
			var44_upvw = false
			var42_upvw = false
			Aiming_upvr.Value = false
			DefRecoil_upvw = var19_upvr.DefRecoil
			mouse_upvr.Icon = "rbxassetid://126381229318420"
			any_Create_result1_2_upvr:Play()
			any_Create_result1_upvr_2:Play()
			var43_upvw = true
			any_LoadAnimation_result1_upvr:Play()
			Reload_upvr:FireServer(arg1.Name)
			task.wait(any_LoadAnimation_result1_upvr.Length)
			var43_upvw = false
			local minimum = math.min(var19_upvr.Ammo, var19_upvr.Cap - var19_upvr.Mag)
			local var51 = var19_upvr
			var51.Mag += minimum
			local var52 = var19_upvr
			var52.Ammo -= minimum
			Mag_upvr.Text = var19_upvr.Mag..'/'.."∞"
			Mag_upvr.Text = var19_upvr.Mag..'/'..var19_upvr.Ammo
		end
	end
	local Muzzle_upvr = arg1:WaitForChild("Muzzle")
	local function fireBullet_upvr() -- Line 113, Named "fireBullet"
		--[[ Upvalues[9]:
			[1]: Network_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: mouse_upvr (copied, readonly)
			[4]: Muzzle_upvr (readonly)
			[5]: var19_upvr (readonly)
			[6]: Mag_upvr (readonly)
			[7]: recoil_upvr (readonly)
			[8]: var44_upvw (read and write)
			[9]: any_LoadAnimation_result1_upvr_3 (readonly)
		]]
		Network_upvr:FireServer(arg1.Name, mouse_upvr.Hit.Position, Muzzle_upvr.Position)
		local var54 = var19_upvr
		var54.Mag -= 1
		Mag_upvr.Text = var19_upvr.Mag..'/'.."∞"
		Mag_upvr.Text = var19_upvr.Mag..'/'..var19_upvr.Ammo
		recoil_upvr()
		if var44_upvw then
			if var19_upvr.Scope then
				any_LoadAnimation_result1_upvr_3:Stop()
			else
				any_LoadAnimation_result1_upvr_3:Play()
			end
		else
			any_LoadAnimation_result1_upvr_3:Play()
		end
		task.wait(var19_upvr.FireRate)
	end
	local var55_upvw = false
	local function fire_upvr() -- Line 129, Named "fire"
		--[[ Upvalues[7]:
			[1]: var43_upvw (read and write)
			[2]: var55_upvw (read and write)
			[3]: var45_upvw (read and write)
			[4]: var19_upvr (readonly)
			[5]: reload_upvr (readonly)
			[6]: var42_upvw (read and write)
			[7]: fireBullet_upvr (readonly)
		]]
		if var43_upvw or var55_upvw or not var45_upvw then
		else
			if var19_upvr.Mag <= 0 then
				reload_upvr()
				return
			end
			var42_upvw = true
			while var42_upvw do
				if var19_upvr.Mag <= 0 then
					reload_upvr()
					return
				end
				if var19_upvr.FullAuto then
					fireBullet_upvr()
				elseif var19_upvr.BurstMode then
					var55_upvw = true
					for _ = 1, var19_upvr.Burst do
						fireBullet_upvr()
					end
					task.wait(var19_upvr.BurstSpeed * var19_upvr.Burst * 2)
					var55_upvw = false
				else
					var42_upvw = false
					fireBullet_upvr()
				end
			end
		end
	end
	local var57_upvw = false
	local any_Create_result1_upvr = TweenService_upvr:Create(Mode_upvr, TweenInfo.new(0.01), {
		TextTransparency = 0;
	})
	local any_Create_result1_upvr_3 = TweenService_upvr:Create(Mode_upvr, TweenInfo.new(0.25), {
		TextTransparency = 1;
	})
	local function switch_upvr() -- Line 152, Named "switch"
		--[[ Upvalues[6]:
			[1]: var57_upvw (read and write)
			[2]: var19_upvr (readonly)
			[3]: any_Create_result1_upvr (readonly)
			[4]: Click_upvr (copied, readonly)
			[5]: Mode_upvr (readonly)
			[6]: any_Create_result1_upvr_3 (readonly)
		]]
		if var57_upvw or not var19_upvr.CanSwitch then
		else
			any_Create_result1_upvr:Play()
			Click_upvr:Play()
			if var19_upvr.FullAuto then
				var19_upvr.FullAuto = false
				var19_upvr.BurstMode = true
				Mode_upvr.Text = "Burst Mode"
			elseif var19_upvr.BurstMode then
				var19_upvr.BurstMode = false
				var19_upvr.SemiAuto = true
				Mode_upvr.Text = "Semi Auto"
			else
				var19_upvr.SemiAuto = false
				var19_upvr.FullAuto = true
				Mode_upvr.Text = "Full Auto"
			end
			task.delay(Click_upvr.TimeLength, function() -- Line 171
				--[[ Upvalues[2]:
					[1]: var57_upvw (copied, read and write)
					[2]: any_Create_result1_upvr_3 (copied, readonly)
				]]
				var57_upvw = false
				any_Create_result1_upvr_3:Play()
			end)
		end
	end
	local function _(arg1_2) -- Line 176, Named "aim"
		--[[ Upvalues[11]:
			[1]: CurrentCamera_upvr (copied, readonly)
			[2]: var43_upvw (read and write)
			[3]: var44_upvw (read and write)
			[4]: Aiming_upvr (readonly)
			[5]: DefRecoil_upvw (read and write)
			[6]: var19_upvr (readonly)
			[7]: any_Create_result1_4_upvr (readonly)
			[8]: any_Create_result1_3_upvr (readonly)
			[9]: mouse_upvr (copied, readonly)
			[10]: any_Create_result1_2_upvr (readonly)
			[11]: any_Create_result1_upvr_2 (readonly)
		]]
		local var61
		if var61 <= 1 then
			var61 = var43_upvw
			if var61 then
			else
				var44_upvw = arg1_2
				var61 = Aiming_upvr
				var61.Value = arg1_2
				local function INLINED() -- Internal function, doesn't exist in bytecode
					var61 = var19_upvr.AimRecoil
					return var61
				end
				if not arg1_2 or not INLINED() then
					var61 = var19_upvr.DefRecoil
				end
				DefRecoil_upvw = var61
				if arg1_2 then
					any_Create_result1_4_upvr:Play()
					any_Create_result1_3_upvr:Play()
					
					var61 = mouse_upvr
					var61.Icon = "rbxassetid://2300836745"
					return
				end
				var61 = mouse_upvr
				var61.Icon = "rbxassetid://126381229318420"
				any_Create_result1_2_upvr:Play()
				any_Create_result1_upvr_2:Play()
				
			end
		end
		mouse_upvr.Icon = "rbxassetid://126381229318420"
		any_Create_result1_2_upvr:Play()
		any_Create_result1_upvr_2:Play()
	end
	UserInputService_upvr.InputBegan:Connect(function(arg1_3, arg2) -- Line 200
		--[[ Upvalues[15]:
			[1]: var45_upvw (read and write)
			[2]: fire_upvr (readonly)
			[3]: CurrentCamera_upvr (copied, readonly)
			[4]: var43_upvw (read and write)
			[5]: var44_upvw (read and write)
			[6]: Aiming_upvr (readonly)
			[7]: DefRecoil_upvw (read and write)
			[8]: var19_upvr (readonly)
			[9]: any_Create_result1_4_upvr (readonly)
			[10]: any_Create_result1_3_upvr (readonly)
			[11]: mouse_upvr (copied, readonly)
			[12]: any_Create_result1_2_upvr (readonly)
			[13]: any_Create_result1_upvr_2 (readonly)
			[14]: reload_upvr (readonly)
			[15]: switch_upvr (readonly)
		]]
		if arg2 then
		elseif var45_upvw then
			if arg1_3.UserInputType == Enum.UserInputType.MouseButton1 or arg1_3.UserInputType == Enum.UserInputType.Touch or arg1_3.KeyCode == Enum.KeyCode.ButtonR2 then
				fire_upvr()
			end
			if arg1_3.UserInputType == Enum.UserInputType.MouseButton2 then
				if (CurrentCamera_upvr.focus.p - CurrentCamera_upvr.CFrame.p).magnitude <= 1 then
					if var43_upvw then
					else
						var44_upvw = true
						Aiming_upvr.Value = true
						local AimRecoil = var19_upvr.AimRecoil
						if not AimRecoil then
							AimRecoil = var19_upvr.DefRecoil
						end
						DefRecoil_upvw = AimRecoil
						any_Create_result1_4_upvr:Play()
						any_Create_result1_3_upvr:Play()
						mouse_upvr.Icon = "rbxassetid://2300836745"
					end
				else
					mouse_upvr.Icon = "rbxassetid://126381229318420"
					any_Create_result1_2_upvr:Play()
					any_Create_result1_upvr_2:Play()
				end
			end
			if arg1_3.KeyCode == Enum.KeyCode.R then
				reload_upvr()
			end
			if arg1_3.KeyCode == Enum.KeyCode.E then
				switch_upvr()
			end
		end
	end)
	UserInputService_upvr.InputEnded:Connect(function(arg1_4, arg2) -- Line 212
		--[[ Upvalues[11]:
			[1]: var45_upvw (read and write)
			[2]: var42_upvw (read and write)
			[3]: CurrentCamera_upvr (copied, readonly)
			[4]: var43_upvw (read and write)
			[5]: var44_upvw (read and write)
			[6]: Aiming_upvr (readonly)
			[7]: DefRecoil_upvw (read and write)
			[8]: var19_upvr (readonly)
			[9]: mouse_upvr (copied, readonly)
			[10]: any_Create_result1_2_upvr (readonly)
			[11]: any_Create_result1_upvr_2 (readonly)
		]]
		if arg2 then
		elseif var45_upvw then
			if arg1_4.UserInputType == Enum.UserInputType.MouseButton1 or arg1_4.UserInputType == Enum.UserInputType.Touch or arg1_4.KeyCode == Enum.KeyCode.ButtonR2 then
				var42_upvw = false
			end
			if arg1_4.UserInputType == Enum.UserInputType.MouseButton2 then
				if (CurrentCamera_upvr.focus.p - CurrentCamera_upvr.CFrame.p).magnitude <= 1 then
					if var43_upvw then
					else
						var44_upvw = false
						Aiming_upvr.Value = false
						DefRecoil_upvw = var19_upvr.DefRecoil
						mouse_upvr.Icon = "rbxassetid://126381229318420"
						any_Create_result1_2_upvr:Play()
						any_Create_result1_upvr_2:Play()
					end
				end
				mouse_upvr.Icon = "rbxassetid://126381229318420"
				any_Create_result1_2_upvr:Play()
				any_Create_result1_upvr_2:Play()
			end
		end
	end)
	UserInputService_upvr.InputChanged:Connect(function(arg1_5, arg2) -- Line 221
		--[[ Upvalues[11]:
			[1]: var45_upvw (read and write)
			[2]: var42_upvw (read and write)
			[3]: CurrentCamera_upvr (copied, readonly)
			[4]: var43_upvw (read and write)
			[5]: var44_upvw (read and write)
			[6]: Aiming_upvr (readonly)
			[7]: DefRecoil_upvw (read and write)
			[8]: var19_upvr (readonly)
			[9]: mouse_upvr (copied, readonly)
			[10]: any_Create_result1_2_upvr (readonly)
			[11]: any_Create_result1_upvr_2 (readonly)
		]]
		if arg2 then
		elseif var45_upvw then
			if arg1_5.UserInputType == Enum.UserInputType.MouseButton1 or arg1_5.UserInputType == Enum.UserInputType.Touch or arg1_5.KeyCode == Enum.KeyCode.ButtonR2 then
				var42_upvw = false
			end
			if arg1_5.UserInputType == Enum.UserInputType.MouseButton2 then
				if (CurrentCamera_upvr.focus.p - CurrentCamera_upvr.CFrame.p).magnitude <= 1 then
					if var43_upvw then
					else
						var44_upvw = false
						Aiming_upvr.Value = false
						DefRecoil_upvw = var19_upvr.DefRecoil
						mouse_upvr.Icon = "rbxassetid://126381229318420"
						any_Create_result1_2_upvr:Play()
						any_Create_result1_upvr_2:Play()
					end
				end
				mouse_upvr.Icon = "rbxassetid://126381229318420"
				any_Create_result1_2_upvr:Play()
				any_Create_result1_upvr_2:Play()
			end
		end
	end)
	arg1.AncestryChanged:Connect(function() -- Line 232
		--[[ Upvalues[17]:
			[1]: arg1 (readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: mouse_upvr (copied, readonly)
			[4]: CurrentCamera_upvr (copied, readonly)
			[5]: var43_upvw (read and write)
			[6]: var44_upvw (read and write)
			[7]: Aiming_upvr (readonly)
			[8]: DefRecoil_upvw (read and write)
			[9]: var19_upvr (readonly)
			[10]: any_Create_result1_2_upvr (readonly)
			[11]: any_Create_result1_upvr_2 (readonly)
			[12]: clone_2_upvr (readonly)
			[13]: var45_upvw (read and write)
			[14]: var42_upvw (read and write)
			[15]: any_LoadAnimation_result1_upvr_2 (readonly)
			[16]: any_LoadAnimation_result1_upvr_3 (readonly)
			[17]: any_LoadAnimation_result1_upvr (readonly)
		]]
		if arg1.Parent ~= LocalPlayer_upvr.Character then
			mouse_upvr.Icon = "rbxassetid://68308747"
			if (CurrentCamera_upvr.focus.p - CurrentCamera_upvr.CFrame.p).magnitude <= 1 then
				if var43_upvw then
				else
					var44_upvw = false
					Aiming_upvr.Value = false
					DefRecoil_upvw = var19_upvr.DefRecoil
					mouse_upvr.Icon = "rbxassetid://126381229318420"
					any_Create_result1_2_upvr:Play()
					any_Create_result1_upvr_2:Play()
				end
			else
				mouse_upvr.Icon = "rbxassetid://126381229318420"
				any_Create_result1_2_upvr:Play()
				any_Create_result1_upvr_2:Play()
			end
			var44_upvw = false
			clone_2_upvr:Destroy()
			var45_upvw = false
			var42_upvw = false
			var43_upvw = false
			any_LoadAnimation_result1_upvr_2:Stop()
			any_LoadAnimation_result1_upvr_3:Stop()
			any_LoadAnimation_result1_upvr:Stop()
		end
	end)
	Humanoid.Died:Connect(function() -- Line 246
		--[[ Upvalues[1]:
			[1]: clone_2_upvr (readonly)
		]]
		clone_2_upvr:Destroy()
	end)
	for _, v in Character:GetDescendants(), nil do
		if v:IsA("Part") then
			v.Touched:Connect(function(arg1_6) -- Line 252
				--[[ Upvalues[1]:
					[1]: var19_upvr (readonly)
				]]
				if arg1_6.Name == "AmmoBox" then
					local var69 = var19_upvr
					var69.Ammo += arg1_6.Value.Value
					arg1_6:Destroy()
				end
			end)
		end
	end
	Network_upvr.OnClientEvent:Connect(function(arg1_7, arg2, arg3) -- Line 260
		--[[ Upvalues[3]:
			[1]: Xp_upvr (copied, readonly)
			[2]: clone_2_upvr (readonly)
			[3]: TweenService_upvr (copied, readonly)
		]]
		if arg1_7 == "XpEffect" then
			local clone = Xp_upvr:Clone()
			clone.Parent = clone_2_upvr.XpFrame
			clone.Text = '+'..arg2.."XP"
			local any_Create_result1 = TweenService_upvr:Create(clone, TweenInfo.new(0.3), {
				TextTransparency = 1;
			})
			TweenService_upvr:Create(clone, TweenInfo.new(0.2), {
				Position = clone_2_upvr.XpFrame.Pos.Position;
			}):Play()
			any_Create_result1:Play()
			any_Create_result1.Completed:Wait()
			clone:Destroy()
		end
	end)
end
return module
