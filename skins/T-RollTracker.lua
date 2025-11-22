pfUI.addonskinner:RegisterSkin("T-RollTracker", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCloseButton, SkinScrollbar = 
    penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCloseButton, penv.SkinScrollbar

  -- Главное окно трекера
  if TRollTrackerFrame then
    -- Удаляем стандартные текстуры фона и бордюра
    StripTextures(TRollTrackerFrame)
    
    -- Применяем бэкдроп pfUI с прозрачностью 0.8
    CreateBackdrop(TRollTrackerFrame, nil, nil, 0.8)
    
    -- Убираем стандартный бэкдроп из XML
    if TRollTrackerFrameBackdrop then
      TRollTrackerFrameBackdrop:Hide()
    end
    
    -- Увеличиваем размер окна для лучшего расположения элементов
    TRollTrackerFrame:SetHeight(250) -- Увеличиваем высоту окна
    TRollTrackerFrame:SetMinResize(200, 250) -- Обновляем минимальную высоту
  end

  -- Кнопка закрытия
  if TRollTrackerFrameCloseButton then
    if SkinCloseButton then
      SkinCloseButton(TRollTrackerFrameCloseButton, TRollTrackerFrame, -6, -6)
    else
      SkinButton(TRollTrackerFrameCloseButton)
      TRollTrackerFrameCloseButton:SetText("x")
    end
  end

  -- Кнопка "Стоп" - перемещаем вправо и опускаем
  if TRollTrackerFrameStopButton then
    StripTextures(TRollTrackerFrameStopButton)
    SkinButton(TRollTrackerFrameStopButton)
    TRollTrackerFrameStopButton:SetText("Стоп")
    
    -- Перепозиционируем кнопку "Стоп" - центрируем по горизонтали и опускаем
    TRollTrackerFrameStopButton:ClearAllPoints()
    TRollTrackerFrameStopButton:SetPoint("TOP", TRollTrackerFrame, "TOP", 43, -40) -- Сдвигаем вправо и опускаем
    TRollTrackerFrameStopButton:SetWidth(75) -- Устанавливаем ширину
    TRollTrackerFrameStopButton:SetHeight(24) -- Устанавливаем высоту
  end

  -- Кнопка "Старт" - перемещаем влево и опускаем
  if TRollTrackerFrameStartButton then
    StripTextures(TRollTrackerFrameStartButton)
    SkinButton(TRollTrackerFrameStartButton)
    TRollTrackerFrameStartButton:SetText("Старт")
    
    -- Перепозиционируем кнопку "Старт" - центрируем по горизонтали и опускаем
    TRollTrackerFrameStartButton:ClearAllPoints()
    TRollTrackerFrameStartButton:SetPoint("TOP", TRollTrackerFrame, "TOP", -43, -40) -- Сдвигаем влево и опускаем
    TRollTrackerFrameStartButton:SetWidth(75) -- Устанавливаем ширину
    TRollTrackerFrameStartButton:SetHeight(24) -- Устанавливаем высоту
  end

  -- Кнопка "Объявить победителя" - поднимаем выше
  if TRollTrackerFrameAnnounceButton then
    StripTextures(TRollTrackerFrameAnnounceButton)
    SkinButton(TRollTrackerFrameAnnounceButton)
    TRollTrackerFrameAnnounceButton:SetText("Объявить победителя")
    
    -- Перепозиционируем кнопку выше, чтобы не наезжала на скроллбар
    TRollTrackerFrameAnnounceButton:ClearAllPoints()
    TRollTrackerFrameAnnounceButton:SetPoint("BOTTOM", TRollTrackerFrame, "BOTTOM", 0, 30) -- Поднимаем выше
    TRollTrackerFrameAnnounceButton:SetWidth(160) -- Устанавливаем ширину
    TRollTrackerFrameAnnounceButton:SetHeight(24) -- Устанавливаем высоту
  end

  -- Скролл-фрейм для списка бросков - расширяем и поднимаем
  if TRollTrackerFrameRollScrollFrame then
    -- Перепозиционируем скролл-фрейм, чтобы был больше места
    TRollTrackerFrameRollScrollFrame:ClearAllPoints()
    TRollTrackerFrameRollScrollFrame:SetPoint("TOPLEFT", TRollTrackerFrame, "TOPLEFT", 10, -70) -- Опускаем ниже кнопок
    TRollTrackerFrameRollScrollFrame:SetPoint("BOTTOMRIGHT", TRollTrackerFrame, "BOTTOMRIGHT", -30, 60) -- Поднимаем выше от кнопки объявления
    
    -- Удаляем текстуры Blizzard (рамку ScrollFrameTemplate)
    StripTextures(TRollTrackerFrameRollScrollFrame)
    
    -- ДОБАВЛЯЕМ ОБВОДКУ для области списка с прозрачностью 0.25
    CreateBackdrop(TRollTrackerFrameRollScrollFrame, nil, nil, 0.25)
    
    -- Скинируем скроллбар с помощью правильной функции SkinScrollbar
    local scrollBar = getglobal(TRollTrackerFrameRollScrollFrame:GetName() .. "ScrollBar")
    if scrollBar and SkinScrollbar then
      SkinScrollbar(scrollBar)
    end
    
    -- Корректируем отступы текста SimpleHTML внутри скролл-фрейма
    local rollText = TRollTrackerRollText
    if rollText then
      rollText:ClearAllPoints()
      -- Левый/Верхний отступ 4px, Правый/Нижний отступ 4px
      rollText:SetPoint("TOPLEFT", TRollTrackerFrameRollScrollFrameScrollChild, "TOPLEFT", 4, -4)
      rollText:SetPoint("BOTTOMRIGHT", TRollTrackerFrameRollScrollFrame, "BOTTOMRIGHT", -4, 4)
    end
    
    -- УБИРАЕМ создание бэкдропа для внутреннего контента скролл-фрейма
    -- Это уберет квадрат в области текста
    if TRollTrackerFrameRollScrollFrameScrollChild then
      StripTextures(TRollTrackerFrameRollScrollFrameScrollChild)
      -- НЕ создаем бэкдроп для scrollChild - это вызывает появление квадрата
    end
  end

  -- Заголовок окна
  if TRollTrackerFrameTitle then
    -- Центрируем заголовок и опускаем немного
    TRollTrackerFrameTitle:ClearAllPoints()
    TRollTrackerFrameTitle:SetPoint("TOP", TRollTrackerFrame, "TOP", 0, -8) -- Опускаем заголовок
  end

  -- Текст статуса (счетчик бросков) - опускаем ниже
  if TRollTrackerFrameStatusText then
    -- Опускаем статус еще ниже, чтобы не перекрывался с кнопкой
    TRollTrackerFrameStatusText:ClearAllPoints()
    TRollTrackerFrameStatusText:SetPoint("BOTTOM", TRollTrackerFrame, "BOTTOM", 0, 12) -- Опускаем ниже
  end

  pfUI.addonskinner:UnregisterSkin("T-RollTracker")
end)