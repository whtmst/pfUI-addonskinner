pfUI.addonskinner:RegisterSkin("SOTA", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCloseButton, SkinCheckbox, SkinSlider, SkinScrollbar =
    penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCloseButton,
    penv.SkinCheckbox, penv.SkinSlider, penv.SkinScrollbar
  -- ==========================================================
  -- 1. DASHBOARD
  -- ==========================================================
  if DashboardUIFrame then
    StripTextures(DashboardUIFrame)
    
    if DashboardUIFrameItem then
      StripTextures(DashboardUIFrameItem)
      CreateBackdrop(DashboardUIFrameItem, nil, nil, 0.8)
      
      local kids = { DashboardUIFrameItem:GetChildren() }
      for _, child in ipairs(kids) do
        if child:IsObjectType("Button") then
          if not child.backdrop then
            CreateBackdrop(child, nil, nil, 0)
          end
          
          local normal = child:GetNormalTexture()
          if normal then
            normal:SetTexCoord(.08, .92, .08, .92)
            normal:ClearAllPoints()
            normal:SetPoint("TOPLEFT", child, "TOPLEFT", 2, -2)
            normal:SetPoint("BOTTOMRIGHT", child, "BOTTOMRIGHT", -2, 2)
            normal:SetDrawLayer("ARTWORK")
          end
          
          local pushed = child:GetPushedTexture()
          if pushed then
            pushed:SetTexCoord(.08, .92, .08, .92)
            pushed:ClearAllPoints()
            pushed:SetPoint("TOPLEFT", child, "TOPLEFT", 2, -2)
            pushed:SetPoint("BOTTOMRIGHT", child, "BOTTOMRIGHT", -2, 2)
          end
          
          local highlight = child:GetHighlightTexture()
          if highlight then
            highlight:SetTexture(1,1,1,0.3)
            highlight:SetAllPoints(normal)
          end
        end
      end
    end
  end
  -- ==========================================================
  -- 2. OPTIONS (Настройки)
  -- ==========================================================
  local configFrames = {
    "FrameConfigBidding",
    "FrameConfigBossDkp",
    "FrameConfigMiscDkp",
    "FrameConfigMessage",
    "FrameConfigBidRules",
    "FrameConfigSyncCfg"
  }
  for _, frameName in pairs(configFrames) do
    local frame = _G[frameName]
    if frame then
      StripTextures(frame)
      CreateBackdrop(frame, nil, nil, 0.85)
      
      if _G[frameName.."TopCloseButton"] then
        SkinCloseButton(_G[frameName.."TopCloseButton"], frame, -5, -5)
      end
      local tabs = {}
      local closeBtn = nil
      local kids = { frame:GetChildren() }
      
      for _, child in ipairs(kids) do
        local objType = child:GetObjectType()
        
        if objType == "Button" then
          local text = child:GetText()
          if text == "Close" then
            closeBtn = child
          elseif text == "Bidding" then
            tabs[1] = child
          elseif text == "Boss DKP" then
            tabs[2] = child
          elseif text == "Misc DKP" then
            tabs[3] = child
          elseif text == "Messages" then
            tabs[4] = child
          elseif text == "Bid Rules" then
            tabs[5] = child
          elseif text == "Sync Cfg" then
            tabs[6] = child
          end
        elseif objType == "CheckButton" then
          SkinCheckbox(child)
        elseif objType == "Slider" then
          SkinSlider(child)
        elseif objType == "EditBox" then
          if not child.backdrop then
            CreateBackdrop(child, nil, nil, 0.5)
            child:SetTextInsets(5,5,0,0)
          end
        elseif objType == "ScrollFrame" then
          StripTextures(child)
          child:SetBackdrop(nil)
          local scrollChild = child:GetScrollChild()
          if scrollChild then
            StripTextures(scrollChild)
            scrollChild:SetBackdrop(nil)
          end
        end
      end
      if closeBtn then
        SkinButton(closeBtn)
        closeBtn:ClearAllPoints()
        closeBtn:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
      end
      -- Центрирование вкладок
      frame:SetWidth(400)
      local totalWidth = 6 * 80 + 5 * 2
      local startX = (570 - totalWidth) / 2
      local prevTab = nil
      
      for i=1, 6 do
        local tab = tabs[i]
        if tab then
          SkinButton(tab)
          tab:ClearAllPoints()
          tab:SetHeight(24)
          tab:SetWidth(80)
          if prevTab then
            tab:SetPoint("LEFT", prevTab, "RIGHT", 2, 0)
          else
            tab:SetPoint("TOPLEFT", frame, "TOPLEFT", startX, -35)
          end
          prevTab = tab
        end
      end
      -- Обработка скроллфреймов (Messages)
      local scrollFrame = _G[frameName.."TableList"]
      if scrollFrame then
        -- Apply pfUI skinning/cleanup to the scroll frame container
        StripTextures(scrollFrame)
        scrollFrame:SetBackdrop(nil)
        
        local regions = { scrollFrame:GetRegions() }
        for _, region in ipairs(regions) do
          if region:IsObjectType("Texture") then
            region:SetTexture(nil)
          end
        end
        
        local scrollChild = scrollFrame:GetScrollChild()
        if scrollChild then
          StripTextures(scrollChild)
          scrollChild:SetBackdrop(nil)
        end
        
        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOP", frame, "TOP", 0, -80)
        scrollFrame:SetWidth(320)
        scrollFrame:SetHeight(250)
        
        CreateBackdrop(scrollFrame, nil, nil, 0.3)
        
        local scrollBar = _G[frameName.."TableListScrollBar"]
        if scrollBar then
          SkinScrollbar(scrollBar)
        end
        
        -- >>>>> ЦИКЛ ТОЛЬКО ДЛЯ ИСПРАВЛЕНИЯ ШИРИНЫ <<<<<
        for i = 1, 20 do
          local entry = _G["FrameConfigMessageTableListEntry"..i]
          if entry then
            -- Fix width (Remove the right padding)
            entry:SetWidth(scrollFrame:GetWidth() - 8)
          end
        end
      end
    end
  end
  -- ==========================================================
  -- ОСТАЛЬНАЯ ЧАСТЬ КОДА БЕЗ ИЗМЕНЕНИЙ
  -- ==========================================================
  local bossSliders = {
    "FrameConfigBossDkp_20Mans",
    "FrameConfigBossDkp_MoltenCore",
    "FrameConfigBossDkp_Onyxia",
    "FrameConfigBossDkp_BlackwingLair",
    "FrameConfigBossDkp_AQ40",
    "FrameConfigBossDkp_Naxxramas",
    "FrameConfigBossDkp_WorldBosses"
  }
  for i, sName in pairs(bossSliders) do
    local slider = _G[sName]
    if slider then
      SkinSlider(slider)
      slider:ClearAllPoints()
      slider:SetPoint("TOP", FrameConfigBossDkp, "TOP", 0, -100 - (i-1)*35)
      slider:SetWidth(300)
    end
  end
  if FrameConfigBiddingAuctionTime then
    SkinSlider(FrameConfigBiddingAuctionTime)
    FrameConfigBiddingAuctionTime:ClearAllPoints()
    FrameConfigBiddingAuctionTime:SetPoint("TOP", FrameConfigBidding, "TOP", 0, -100)
    FrameConfigBiddingAuctionTime:SetWidth(300)
  end
  if FrameConfigBiddingAuctionExtension then
    SkinSlider(FrameConfigBiddingAuctionExtension)
    FrameConfigBiddingAuctionExtension:ClearAllPoints()
    FrameConfigBiddingAuctionExtension:SetPoint("TOP", FrameConfigBidding, "TOP", 0, -140)
    FrameConfigBiddingAuctionExtension:SetWidth(300)
  end
  local bidChecks = {
    "FrameConfigBiddingMSoverOSPriority",
    "FrameConfigBiddingEnableZonecheck",
    "FrameConfigBiddingEnableOnlinecheck",
    "FrameConfigBiddingAllowPlayerPass",
    "FrameConfigBiddingDisableDashboard"
  }
  for i, name in ipairs(bidChecks) do
    local chk = _G[name]
    if chk then
      SkinCheckbox(chk)
      chk:ClearAllPoints()
      chk:SetPoint("TOPLEFT", FrameConfigBidding, "TOPLEFT", 30, -200 - (i-1)*30)
    end
  end
  local miscChecks = {
    "FrameConfigMiscDkpPublicNotes",
    "FrameConfigMiscDkpMinBidStrategy0",
    "FrameConfigMiscDkpMinBidStrategy1",
    "FrameConfigMiscDkpMinBidStrategy2",
    "FrameConfigMiscDkpMinBidStrategy3",
    "FrameConfigMiscDkpMinBidStrategy4"
  }
  for i, name in ipairs(miscChecks) do
    local chk = _G[name]
    if chk then
      SkinCheckbox(chk)
      chk:ClearAllPoints()
      chk:SetPoint("TOPLEFT", FrameConfigMiscDkp, "TOPLEFT", 30, -100 - (i-1)*30)
    end
  end
  if FrameConfigMiscDkpDKPStringLength then
    SkinSlider(FrameConfigMiscDkpDKPStringLength)
    FrameConfigMiscDkpDKPStringLength:ClearAllPoints()
    FrameConfigMiscDkpDKPStringLength:SetPoint("TOP", FrameConfigMiscDkp, "TOP", 0, -320)
    FrameConfigMiscDkpDKPStringLength:SetWidth(300)
  end
  if FrameConfigMiscDkpMinimumDKPPenalty then
    SkinSlider(FrameConfigMiscDkpMinimumDKPPenalty)
    FrameConfigMiscDkpMinimumDKPPenalty:ClearAllPoints()
    FrameConfigMiscDkpMinimumDKPPenalty:SetPoint("TOP", FrameConfigMiscDkp, "TOP", 0, -370)
    FrameConfigMiscDkpMinimumDKPPenalty:SetWidth(300)
  end
  if FrameEventEditor then
    StripTextures(FrameEventEditor)
    CreateBackdrop(FrameEventEditor, nil, nil, 0.9)
    FrameEventEditor:SetHeight(280)
    
    if FrameEventEditorMessage then
      CreateBackdrop(FrameEventEditorMessage, nil, nil, 0.6)
      FrameEventEditorMessage:SetTextInsets(5,5,0,0)
      FrameEventEditorMessage:SetHeight(20)
    end
    
    if OkButton then
      SkinButton(OkButton)
      OkButton:ClearAllPoints()
      OkButton:SetPoint("BOTTOM", FrameEventEditor, "BOTTOM", -55, 15)
    end
    
    if CancelButton then
      SkinButton(CancelButton)
      CancelButton:ClearAllPoints()
      CancelButton:SetPoint("BOTTOM", FrameEventEditor, "BOTTOM", 55, 15)
    end
    local checks = {"RW", "Raid", "Guild", "Yell", "Say"}
    for i, suffix in pairs(checks) do
      local chk = _G["FrameEventEditorCheckbutton"..suffix]
      if chk then
        SkinCheckbox(chk)
        chk:ClearAllPoints()
        chk:SetPoint("TOPLEFT", FrameEventEditor, "TOPLEFT", 30, -70 - (i-1)*30)
      end
    end
  end
  if AuctionUIFrame then
    StripTextures(AuctionUIFrame)
    CreateBackdrop(AuctionUIFrame, nil, nil, 0.8)
    
    local auctionButtons = {
      "CancelBidButton",
      "PauseAuctionButton",
      "FinishAuctionButton",
      "RestartAuctionButton",
      "AcceptBidButton",
      "CancelAuctionButton"
    }
    
    for _, btnName in pairs(auctionButtons) do
      if _G[btnName] then
        SkinButton(_G[btnName])
      end
    end
    
    if AuctionUIFrameItem then
      StripTextures(AuctionUIFrameItem)
      CreateBackdrop(AuctionUIFrameItem, nil, nil, 0.5)
    end
    
    if AuctionUIFrameTableList then
      StripTextures(AuctionUIFrameTableList)
      CreateBackdrop(AuctionUIFrameTableList, nil, nil, 0.5)
    end
    
    if AuctionUIFrameSelected then
      StripTextures(AuctionUIFrameSelected)
      CreateBackdrop(AuctionUIFrameSelected, nil, nil, 0.5)
    end
  end
  if TransactionUIFrame then
    StripTextures(TransactionUIFrame)
    CreateBackdrop(TransactionUIFrame, nil, nil, 0.8)
    
    if TransactionUIFrameTopCloseButton then
      SkinCloseButton(TransactionUIFrameTopCloseButton, TransactionUIFrame, -5, -5)
    end
    
    local logButtons = {
      "PurgeDKPHistoryButton",
      "TransactionLogButton",
      "DKPHistoryButton",
      "PrevTransactionPageButton",
      "NextTransactionPageButton",
      "BackToTransactionLogButton",
      "UndoTransactionButton"
    }
    
    for _, btn in pairs(logButtons) do
      if _G[btn] then
        SkinButton(_G[btn])
      end
    end
  end
  if RaidQueueFrame then
    StripTextures(RaidQueueFrame)
    CreateBackdrop(RaidQueueFrame, nil, nil, 0.8)
    
    if RaidQueueFrameTopCloseButton then
      SkinCloseButton(RaidQueueFrameTopCloseButton, RaidQueueFrame, -5, -5)
    end
    
    local lists = {"TankList", "MeleeList", "RangedList", "HealerList"}
    for _, l in pairs(lists) do
      local listFrame = _G["RaidQueueFrame"..l]
      if listFrame then
        StripTextures(listFrame)
        CreateBackdrop(listFrame, nil, nil, 0.4)
      end
    end
  end
  if CancelBidButton then
    SkinCloseButton(CancelBidButton)
  end
  pfUI.addonskinner:UnregisterSkin("SOTA")
end)