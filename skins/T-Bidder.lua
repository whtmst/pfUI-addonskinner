pfUI.addonskinner:RegisterSkin("T-Bidder", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCloseButton = 
    penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCloseButton

  if not T_BidderUIFrame then return end

  -- 1. Главное окно
  StripTextures(T_BidderUIFrame)
  CreateBackdrop(T_BidderUIFrame, nil, nil, 0.8)
  
  -------------------------------------------------------------------------
  -- НАСТРОЙКА ТЕКСТА
  -------------------------------------------------------------------------
  -- Верхняя строка
  T_BidderHighestBidTextButton:ClearAllPoints()
  T_BidderHighestBidTextButton:SetPoint("TOPLEFT", 10, -25)

  -- Нижняя строка
  T_BidderPlayerDKPButton:ClearAllPoints()
  T_BidderPlayerDKPButton:SetPoint("TOPLEFT", 10, -40)
  -------------------------------------------------------------------------

  -- 2. Кнопка закрытия
  if T_BidderUIFrameTopCloseButton then
    if SkinCloseButton then
      SkinCloseButton(T_BidderUIFrameTopCloseButton, T_BidderUIFrame, -2, -2)
    else
      SkinButton(T_BidderUIFrameTopCloseButton)
      T_BidderUIFrameTopCloseButton:SetText("x")
    end
  end

  -- 3. Основные кнопки управления
  SkinButton(T_BidderBidMinButton)
  SkinButton(T_BidderBidMaxButton)
  SkinButton(T_BidderBidXButton)

  -- 4. Поле ввода (EditBox)
  local ebName = T_BidderBidEditBox:GetName()
  if _G[ebName.."Left"] then _G[ebName.."Left"]:Hide() end
  if _G[ebName.."Middle"] then _G[ebName.."Middle"]:Hide() end
  if _G[ebName.."Right"] then _G[ebName.."Right"]:Hide() end
  
  CreateBackdrop(T_BidderBidEditBox)
  
  T_BidderBidEditBox:SetHeight(22)
  T_BidderBidEditBox:SetTextInsets(5, 5, 0, 0)

  -------------------------------------------------------------------------
  -- НАСТРОЙКА ПОЛЯ ВВОДА
  -------------------------------------------------------------------------
  T_BidderBidEditBox:SetWidth(128)
  T_BidderBidEditBox:ClearAllPoints()
  T_BidderBidEditBox:SetPoint("BOTTOMLEFT", 17, 42)
  -------------------------------------------------------------------------

  -- 5. Статус-бар (Таймер) и ЕГО КОНТЕЙНЕР
  
  -- А) Настройка черного контейнера
  if T_BidderUIFrameTimerFrame then
    StripTextures(T_BidderUIFrameTimerFrame)
    CreateBackdrop(T_BidderUIFrameTimerFrame, nil, nil, 0.8)

    T_BidderUIFrameTimerFrame:ClearAllPoints()
    -- Привязываем ВЕРХ (TOP) контейнера к НИЗУ (BOTTOM) главного окна.
    -- y = -3 создает маленький зазор в 3 пикселя между окнами.
    T_BidderUIFrameTimerFrame:SetPoint("TOP", T_BidderUIFrame, "BOTTOM", 0, -3)
    
    -- Уменьшаем высоту контейнера (было 50, стало 24 - компактно)
    T_BidderUIFrameTimerFrame:SetHeight(24)
  end

  -- Б) Настройка красной полоски
  CreateBackdrop(T_BidderUIFrameAuctionStatusbar, nil, nil, 0)
  local barTexture = _G["T_BidderUIFrameAuctionStatusbarTexture"]
  if barTexture then
    barTexture:SetTexture("Interface\\AddOns\\pfUI\\img\\bar")
  end

  T_BidderUIFrameAuctionStatusbar:ClearAllPoints()
  -- Центрируем полоску внутри черного контейнера
  T_BidderUIFrameAuctionStatusbar:SetPoint("CENTER", T_BidderUIFrameTimerFrame, "CENTER", 0, 0)
  
  -- Уменьшаем высоту полоски (чтобы влезла в 24px контейнера)
  T_BidderUIFrameAuctionStatusbar:SetHeight(14)
  
  -- Увеличиваем ширину (было 272 -> ставим 280)
  local newWidth = 280
  T_BidderUIFrameAuctionStatusbar:SetWidth(newWidth)

  -- ВАЖНО: Сообщаем аддону новую ширину, иначе анимация будет не до конца
  if getglobal("T_Bidder_StatusbarStandardwidth") then
    setglobal("T_Bidder_StatusbarStandardwidth", newWidth)
  end

  -- 6. Окно подтверждения
  if T_BidderMaxBidConfirmationFrame then
    StripTextures(T_BidderMaxBidConfirmationFrame)
    CreateBackdrop(T_BidderMaxBidConfirmationFrame, nil, nil, 0.8)
    SkinButton(T_BidderMaxBidConfirmButton)
    SkinButton(T_BidderMaxBidDeclineButton)
  end
  
  pfUI.addonskinner:UnregisterSkin("T-Bidder")
end)