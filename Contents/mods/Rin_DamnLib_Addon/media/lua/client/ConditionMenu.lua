-- Список ID предметов, у которых нужно показывать состояние
-- Добавляй сюда ID из модов, например: "Base.WheelStandard", "ModID.CustomWheel"
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
    
    -- Получаем сам предмет (PZ передает таблицу, берем первый элемент)
    for _, v in ipairs(items) do
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        else
            item = v
        end
        break
    end

    if not item then return end

    -- Проверяем, есть ли ID предмета в нашем списке
    local isTargetWheel = false
    for _, wheelID in ipairs(wheelList) do
        if item:getFullType() == wheelID then
            isTargetWheel = true
            break
        end
    end

    -- Если нашли совпадение, добавляем строку состояния в меню
    if isTargetWheel then
        local condition = item:getCondition()
        local maxCondition = item:getConditionMax()
        
        -- Если у модового предмета ConditionMax по нулям, принудительно считаем от 100
        if maxCondition <= 0 then maxCondition = 100 end

        -- Добавляем серую неактивную строку в начало или конец меню
        local option = context:addOption("Condition: " .. condition .. " / " .. maxCondition)
        option.notAvailable = true -- Делает пункт серым (кликнуть нельзя)
    end
end

-- Событие создания меню инвентаря (ПКМ по предмету)
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)
