pfUI.addonskinner:RegisterSkin("ArchiTotem", function()
  -- Убедимся, что API pfUI доступен
  if not pfUI or not pfUI.api then
    pfUI.addonskinner:UnregisterSkin("ArchiTotem")
    return
  end

  local api = pfUI.api
  local noop = function() end

  -- Списки элементов и максимальное кол-во кнопок для каждого
  local totemElements = {"Earth", "Fire", "Water", "Air", "Totemic"}
  local totemMaxCounts = {
    Ear = 5,
    Fir = 5,
    Wat = 5,
    Air = 7,
    Tot = 1
  }

  -- Перебираем все элементы и их кнопки
  for _, element in ipairs(totemElements) do
    local elementKey = string.sub(element, 1, 3)
    local maxButtons = totemMaxCounts[elementKey]

    if maxButtons then
      for i = 1, maxButtons do
        local buttonName = "ArchiTotemButton_" .. element .. i
        local button = _G[buttonName]

        if button then
          -- 1. НЕ ИСПОЛЬЗУЕМ api.StripTextures(button).
          --    Вместо этого вручную скроем стандартную текстуру рамки
          --    от ActionBarButtonTemplate.
          local normalTexture = _G[buttonName .. "NormalTexture"]
          if normalTexture then
            normalTexture:SetTexture(nil)
            normalTexture:Hide()
          end

          -- 2. Создаем фон/рамку pfUI. Она будет ПОД иконкой.
          api.CreateBackdrop(button, nil, nil, 0.9)
          
          -- 3. Добавляем стандартное подсвечивание pfUI
          --    (Это заменит $parentHighlightTexture из XML)
          api.SetHighlight(button)
          
          -- 4. Отключаем текстуру нажатия
          button:SetPushedTexture(nil)
          button.SetPushedTexture = noop

          -- 5. Скрываем кастомный фон перезарядки аддона,
          --    т.к. pfUI использует свой спиральный таймер
          local cooldownBg = _G[buttonName .. "CooldownBg"]
          if cooldownBg then
            cooldownBg:SetTexture(nil)
            cooldownBg:Hide()
          end
          
          -- 6. Текстура иконки ($parentTexture) остается видимой,
          --    т.к. мы ее не трогали.
        end
      end
    end
  end

  -- Завершаем регистрацию скина
  pfUI.addonskinner:UnregisterSkin("ArchiTotem")
end)