-- Bow down to your lord and saviour, the king of cucking Troll, Ego!

local plugin = PluginManager():CreatePlugin();
local toolbar = plugin:CreateToolbar("EgoMoose's plugins");
local button = toolbar:CreateButton("sync", "Syncs with outside files", "");

local port = 8080;
local http = game:GetService("HttpService");

local enabled = false;

local syncScripts = {};

function getSyncCode(source)
	return string.sub(string.match(source, "$sync-[^%s]+"), 7);
end;

function gather(children, class, tab)
	local tab = tab and tab or {};
	for _, child in pairs(children) do
		pcall(function()
			if child:IsA(class) then
				table.insert(tab, child);
			end;
			tab = gather(type(child) == "table" and child or child:GetChildren(), class, tab);
		end);
	end;
	return tab;
end;

gather(game:GetChildren(), "Script", syncScripts);
gather(game:GetChildren(), "LocalScript", syncScripts);
gather(game:GetChildren(), "ModuleScript", syncScripts);

game.DescendantAdded:connect(function(child)
	pcall(function()
		if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
			syncScripts[child:GetDebugId()] = child;
		end;
	end);
end);

game.DescendantRemoving:connect(function(child)
	pcall(function()
		if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
			syncScripts[child:GetDebugId()] = nil;
		end;
	end);
end);

button.Click:connect(function()
	enabled = not enabled;
	if enabled then
		print("sync is on");
		while enabled do
			for id, child in pairs(syncScripts) do
				local source, code;
				success, message = pcall(function()
					code = getSyncCode(child.Source);
					source = http:GetAsync("http://localhost:" .. port .. "/" .. code);
				end);
				if success then
					child.Source = "-- $sync-"..code.."\n\n"..source;
				end;
			end;
			wait(0.1);
		end;
	else
		print("sync is off");
	end;
end);