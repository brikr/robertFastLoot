local frame = CreateFrame("Frame");

frame:SetScript("OnEvent", function(self, event, arg1)
  if IsModifiedClick("AUTOLOOTTOGGLE") then
    -- Don't loot if auto loot key is held down
    return
  else
    -- Otherwise, try to loot items every frame until there are none
    frame:SetScript("OnUpdate", function(self)
      local numItems = GetNumLootItems()
      if numItems > 0 then
        for i = numItems, 1, -1 do
          LootSlot(i)
        end
      else
        -- No more loot, stop checking every frame
        frame:SetScript("OnUpdate", nil)
      end
    end)
  end
end)

frame:RegisterEvent("LOOT_READY")

-- Speed up built-in autolooting so it can play with us when there's a lot of loot
SetCVar("autoLootRate", "0")
