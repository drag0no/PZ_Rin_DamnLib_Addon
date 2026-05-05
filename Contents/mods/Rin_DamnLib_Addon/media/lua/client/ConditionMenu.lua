local wheelList = {
    "Base.V100Tire2",
    "Base.M923Axle2",
    "Base.V100Tires2",
	"Base.V100Axle2",
	"Base.V103Tire2",
	"Base.V103Axle2",
	"Base.V101Tire2",
	"Base.BushmasterTire",
	"Base.NormalHeavyDutyTire",
	"Base.ModernHeavyDutyTire",
	"Base.OldHeavyDutyTire",
}

local function onFillInventoryObjectContextMenu(player, context, items)
    local item = nil
    
    for _, v in ipairs(items) do
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        else
            item = v
        end
        break
    end

    if not item then return end

    local isTargetWheel = false
    for _, wheelID in ipairs(wheelList) do
        if item:getFullType() == wheelID then
            isTargetWheel = true
            break
        end
    end


    if isTargetWheel then
        local condition = item:getCondition()
        local maxCondition = item:getConditionMax()
        
        if maxCondition <= 0 then maxCondition = 100 end

        local option = context:addOption("Condition: " .. condition .. " / " .. maxCondition)
        option.notAvailable = true
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)
