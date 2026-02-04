package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.class_2262;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class InfoStandFurniView
   {
      
      private static const const_389:int = -12345678;
      
      protected var _window:IItemListWindow;
      
      protected var var_459:class_1812;
      
      protected var var_4576:class_1741;
      
      protected var var_31:class_1993;
      
      protected var var_34:IItemListWindow;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _habboTracking:class_53;
      
      protected var var_350:class_1741;
      
      protected var var_2510:class_1741;
      
      protected var var_356:class_1741;
      
      protected var var_348:class_1741;
      
      protected var var_344:class_1741;
      
      private var var_570:int;
      
      private var var_1820:int = 0;
      
      protected var var_16:InfoStandWidget;
      
      protected var var_108:IItemListWindow;
      
      private const const_105:int = 0;
      
      private const const_289:int = 1;
      
      private const const_809:int = 2;
      
      public function InfoStandFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         var_570 = const_105;
         super();
         var_16 = param1;
         _catalog = param3;
         _habboTracking = HabboTracking.getInstance();
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         _catalog = null;
         var_16 = null;
         _window.dispose();
         _window = null;
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc4_:XmlAsset = var_16.assets.getAssetByName("furni_view") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_31 = _window.getListItemByName("info_border") as class_1993;
         var_34 = _window.getListItemByName("button_list") as IItemListWindow;
         var_459 = _window.getListItemByName("custom_variables") as class_1812;
         if(!var_16.handler.container.sessionDataManager.hasSecurity(5))
         {
            var_459.dispose();
            var_459 = null;
         }
         if(var_459 != null)
         {
            var_459.procedure = customVarsWindowProcedure;
            var_4576 = IItemListWindow(var_459.findChildByName("variable_list")).removeListItemAt(0);
         }
         if(var_31 != null)
         {
            var_108 = var_31.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_16.mainContainer.addChild(_window);
         var _loc3_:class_1741 = var_31.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(var_34 != null)
         {
            var _loc5_:int = 0;
            while(0 < var_34.numListItems)
            {
               var _loc2_:class_1741 = var_34.getListItemAt(0);
               null.addEventListener("WME_CLICK",onButtonClicked);
               _loc5_++;
            }
         }
         var_350 = var_31.findChildByTag("catalog");
         if(var_350 != null)
         {
            var_350.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         var_2510 = var_31.findChildByName("bc_place_button");
         if(var_2510 != null)
         {
            var_2510.addEventListener("WME_CLICK",onBcPlaceMoreButtonClicked);
         }
         var_356 = var_31.findChildByName("rent_button");
         if(var_356 != null)
         {
            var_356.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         var_348 = var_31.findChildByName("extend_button");
         if(var_348 != null)
         {
            var_348.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         var_344 = var_31.findChildByName("buyout_button");
         if(var_344 != null)
         {
            var_344.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:IRegionWindow = var_108.getListItemByName("owner_region") as IRegionWindow;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc6_.addEventListener("WME_OVER",onOwnerRegion);
            _loc6_.addEventListener("WME_OUT",onOwnerRegion);
         }
         var _loc7_:class_1741 = var_31.findChildByName("group_details_container");
         if(_loc7_)
         {
            _loc7_.addEventListener("WME_CLICK",onGroupInfoClicked);
         }
      }
      
      private function customVarsWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc5_:class_55 = null;
         var _loc3_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc6_:class_1812 = null;
         if(param1.type != "WME_CLICK" || var_459 == null)
         {
            return;
         }
         var _loc7_:* = param2.name;
         if("set_values" === _loc7_)
         {
            _loc5_ = new class_55();
            _loc3_ = var_459.findChildByName("variable_list") as IItemListWindow;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numListItems)
            {
               _loc6_ = _loc3_.getListItemAt(_loc4_) as class_1812;
               _loc5_[_loc6_.name] = _loc6_.findChildByName("value").caption;
               _loc4_++;
            }
            var_16.handler.setObjectData(_loc5_);
         }
      }
      
      protected function onBuyoutButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1800 = null;
         if(_catalog != null && var_16 && var_16.furniData)
         {
            _loc2_ = getFurnitureData(var_16.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,true,var_16.furniData.id);
            }
         }
      }
      
      protected function onExtendButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1800 = null;
         if(_catalog != null && var_16 && var_16.furniData)
         {
            _loc2_ = getFurnitureData(var_16.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,false,var_16.furniData.id);
            }
         }
      }
      
      private function getRoomObject(param1:int) : IRoomObject
      {
         var _loc3_:int = var_16.handler.container.roomSession.roomId;
         var _loc2_:IRoomObject = var_16.handler.container.roomEngine.getRoomObject(_loc3_,param1,10);
         if(_loc2_ == null)
         {
            _loc2_ = var_16.handler.container.roomEngine.getRoomObject(_loc3_,param1,20);
         }
         return _loc2_;
      }
      
      private function getFurnitureData(param1:InfoStandFurniData) : class_1800
      {
         var _loc4_:class_1800 = null;
         var _loc2_:IRoomObject = getRoomObject(param1.id);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:* = var_16.furniData.category == 20;
         var _loc5_:int = _loc2_.getModel().getNumber("furniture_type_id");
         if(_loc3_)
         {
            _loc4_ = var_16.handler.container.sessionDataManager.getWallItemData(_loc5_);
         }
         else
         {
            _loc4_ = var_16.handler.container.sessionDataManager.getFloorItemData(_loc5_);
         }
         return _loc4_;
      }
      
      protected function onRentButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(var_16.furniData.rentOfferId,"NORMAL");
         }
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         var_16.close();
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:ITextWindow = var_108.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function set isNft(param1:Boolean) : void
      {
         var _loc2_:class_2251 = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         var _loc5_:class_1812 = var_108.getListItemByName("nft_indicator") as class_1812;
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.height = param1 ? 22 : 0;
         _loc5_.visible = param1;
         if(param1)
         {
            _loc2_ = var_31.findChildByName("nft_icon") as class_2251;
            if(_loc2_ != null)
            {
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc4_ = var_16.assets.getAssetByName("icon_nft") as BitmapDataAsset;
               _loc3_ = _loc4_.content as BitmapData;
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            }
         }
         updateWindow();
      }
      
      public function set furniImage(param1:BitmapData) : void
      {
         setImage(param1,"image");
      }
      
      private function setImage(param1:BitmapData, param2:String) : void
      {
         var _loc3_:class_2251 = var_31.findChildByName(param2) as class_2251;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,40,true);
         }
         _loc3_.height = Math.min(param1.height,200);
         _loc3_.bitmap = param1.clone();
         _loc3_.visible = true;
         updateWindow();
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:ITextWindow = var_108.getListItemByName("description_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function setOwnerInfo(param1:int, param2:String) : void
      {
         var_1820 = param1;
         if(var_1820 == 0)
         {
            showWindow("owner_region",false);
            showWindow("owner_spacer",false);
         }
         else
         {
            var _loc4_:IRegionWindow = var_108.getListItemByName("owner_region") as IRegionWindow;
            var _loc5_:ITextWindow = _loc4_.findChildByName("owner_name") as ITextWindow;
            var _loc3_:class_1741 = null.findChildByName("owner_link");
            var _loc6_:class_1741 = null.findChildByName("bcw_icon");
            if(var_1820 != -12345678)
            {
               null.text = param2;
               null.toolTipCaption = var_16.localizations.getLocalization("infostand.profile.link.tooltip","");
               null.toolTipDelay = 100;
               null.visible = true;
            }
            else
            {
               null.text = "${builder.catalog.title}";
               null.toolTipCaption = "";
               null.visible = false;
            }
            showWindow("owner_region",true);
            showWindow("owner_spacer",true);
         }
         updateWindow();
      }
      
      private function set expiration(param1:int) : void
      {
         var _loc2_:class_1741 = var_108.getListItemByName("expiration_text");
         if(_loc2_ == null)
         {
            return;
         }
         var_16.localizations.registerParameter("infostand.rent.expiration","time",FriendlyTime.getFriendlyTime(var_16.handler.container.localization,param1));
         _loc2_.visible = param1 >= 0 && var_1820 == var_16.handler.container.sessionDataManager.userId;
         updateWindow();
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:class_1741 = param1.target as class_1741;
         switch(_loc2_.name)
         {
            case "rotate":
               _loc5_ = "RWFUAM_ROTATE";
               break;
            case "move":
               _loc5_ = "RWFAM_MOVE";
               break;
            case "pickup":
               if(var_570 == 2)
               {
                  _loc5_ = "RWFAM_PICKUP";
               }
               else
               {
                  _loc5_ = "RWFAM_EJECT";
               }
               var_16.close();
               break;
            case "save_branding_configuration":
               if(var_16.handler.container.sessionDataManager.hasSecurity(4))
               {
                  _loc5_ = "RWFAM_SAVE_STUFF_DATA";
                  var _loc3_:String = getVisibleAdFurnitureExtraParams();
                  break;
               }
            case "use":
               _loc5_ = "RWFAM_USE";
               break;
            case "wired_inspect":
               _loc5_ = "RWFAM_WIRED_INSPECT";
         }
         if(_loc5_ != null)
         {
            var _loc4_:RoomWidgetMessage = new RoomWidgetFurniActionMessage(_loc5_,var_16.furniData.id,var_16.furniData.category,var_16.furniData.purchaseOfferId,null);
            var_16.messageListener.processWidgetMessage(null);
         }
      }
      
      private function onGroupInfoClicked(param1:WindowMouseEvent) : void
      {
         var_16.messageListener.processWidgetMessage(new RoomWidgetGetBadgeDetailsMessage(false,var_16.furniData.groupId));
      }
      
      protected function onCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(var_16.furniData.purchaseOfferId,"NORMAL");
            if(_habboTracking && !_habboTracking.disposed)
            {
               _habboTracking.trackGoogle("infostandCatalogButton","offer",var_16.furniData.purchaseOfferId);
            }
         }
      }
      
      protected function onBcPlaceMoreButtonClicked(param1:WindowMouseEvent) : void
      {
         var_16.requestItemToMover();
      }
      
      protected function onOwnerRegion(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(var_1820 == -12345678)
            {
               if(var_16.furniData.availableForBuildersClub && var_16.furniData.purchaseOfferId >= 0)
               {
                  _catalog.openCatalogPageByOfferId(var_16.furniData.purchaseOfferId,"BUILDERS_CLUB");
               }
               else
               {
                  var_16.handler.container.catalog.toggleBuilderCatalog();
               }
            }
            else
            {
               var_16.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_1820,"infoStand_furniView"));
            }
         }
         if(param1.type == "WME_OUT")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 21;
         }
         if(param1.type == "WME_OVER")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 22;
         }
      }
      
      protected function updateWindow() : void
      {
         if(var_108 == null || var_31 == null || var_34 == null)
         {
            return;
         }
         var_108.arrangeListItems();
         var_34.width = var_34.scrollableRegion.width;
         var_108.height = var_108.scrollableRegion.height;
         var_31.height = var_108.height + 20;
         _window.width = Math.max(var_31.width,var_34.width);
         _window.height = _window.scrollableRegion.height;
         if(var_31.width < var_34.width)
         {
            var_31.x = _window.width - var_31.width;
            var_34.x = 0;
         }
         else
         {
            var_34.x = _window.width - var_34.width;
            var_31.x = 0;
         }
         if(var_459 != null)
         {
            var_459.x = var_31.x;
         }
         var_16.refreshContainer();
      }
      
      public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         if(var_31 != null)
         {
            var_31.color = class_2262.isBuilderClubId(param1.id) ? 14121216 : 16777215;
         }
         var _loc8_:IRoomSession = var_16.handler.container.roomSession;
         var _loc4_:Boolean = _loc8_ != null && _loc8_.playTestMode;
         name = param1.name;
         description = param1.description;
         furniImage = param1.image;
         expiration = param1.expiration;
         isNft = param1.isNft;
         setOwnerInfo(class_2262.isBuilderClubId(param1.id) ? -12345678 : param1.ownerId,param1.ownerName);
         var _loc3_:Boolean = false;
         var _loc6_:* = false;
         var _loc7_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!_loc4_ && (param1.roomControllerLevel >= 1 || param1.isOwner || param1.isRoomOwner || param1.isAnyRoomController))
         {
            _loc3_ = true;
            _loc6_ = !param1.isWallItem;
         }
         if(param1.isAnyRoomController)
         {
            _loc7_ = true;
         }
         var _loc9_:* = param1.roomControllerLevel >= 1;
         var _loc5_:Boolean = var_16.config.getBoolean("infostand.use.button.enabled");
         if(_loc5_)
         {
            if(param1.usagePolicy == 2)
            {
               _loc2_ = true;
            }
            if(!_loc4_ && (param1.usagePolicy == 1 && _loc9_ || param1.extraParam == "RWEIEP_JUKEBOX" && _loc9_ || param1.extraParam == "RWEIEP_USABLE_PRODUCT" && _loc9_))
            {
               _loc2_ = true;
            }
         }
         updatePickupMode(param1,_loc4_);
         showButton("move",_loc3_);
         showButton("rotate",_loc6_);
         showButton("use",_loc2_);
         showButton("wired_inspect",!_loc4_ && var_16.handler.container.userDefinedRoomEvents.showInspectButton());
         showAdFurnitureDetails(_loc7_);
         showGroupInfo(param1.groupId > 0);
         updatePurchaseButtonVisibility(param1.isOwner,param1.expiration >= 0,param1.purchaseOfferId >= 0,param1.rentOfferId >= 0,param1.purchaseCouldBeUsedForBuyout,param1.rentCouldBeUsedForBuyout,param1.bcOfferId >= 0 && param1.availableForBuildersClub && _catalog.canPlaceWithBC());
         showLimitedItem(param1.stuffData.uniqueSerialNumber > 0,param1.stuffData);
         showRarityItem(param1.stuffData.rarityLevel >= 0,param1.stuffData);
         var_34.visible = _loc3_ || _loc6_ || var_570 != 0 || _loc2_;
         updateCustomVarsWindow();
         updateWindow();
      }
      
      private function updateCustomVarsWindow() : void
      {
         var _loc1_:class_1812 = null;
         if(var_459 == null || var_16.furniData == null)
         {
            return;
         }
         var _loc6_:IRoomObject = getRoomObject(var_16.furniData.id);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:Array = _loc6_.getModel().getStringArray("furniture_custom_variables");
         var_459.visible = _loc3_ != null && _loc3_.length > 0;
         if(!var_459.visible)
         {
            return;
         }
         var _loc5_:IItemListWindow = var_459.findChildByName("variable_list") as IItemListWindow;
         _loc5_.destroyListItems();
         var _loc4_:class_55 = _loc6_.getModel().getStringToStringMap("furniture_data");
         for each(var _loc2_ in _loc3_)
         {
            _loc1_ = var_4576.clone() as class_1812;
            _loc1_.name = _loc2_;
            _loc1_.findChildByName("name").caption = _loc2_;
            _loc1_.findChildByName("value").caption = _loc4_[_loc2_];
            _loc5_.addListItem(_loc1_);
         }
      }
      
      private function updatePickupMode(param1:RoomWidgetFurniInfoUpdateEvent, param2:Boolean) : void
      {
         var_570 = 0;
         if(!param2)
         {
            if(param1.isOwner || param1.isAnyRoomController)
            {
               var_570 = 2;
            }
            else if(param1.isRoomOwner || param1.roomControllerLevel >= 3)
            {
               var_570 = 1;
            }
            if(param1.isStickie)
            {
               var_570 = 0;
            }
         }
         showButton("pickup",var_570 != 0);
         localizePickupButton(var_570);
      }
      
      private function localizePickupButton(param1:int) : void
      {
         if(var_34 == null)
         {
            return;
         }
         var _loc2_:class_1741 = var_34.getListItemByName("pickup");
         if(_loc2_ != null)
         {
            if(param1 == 1)
            {
               _loc2_.caption = "${infostand.button.eject}";
            }
            else
            {
               _loc2_.caption = "${infostand.button.pickup}";
            }
         }
      }
      
      private function createAdElement(param1:String, param2:String) : void
      {
         var _loc4_:XmlAsset = null;
         if(var_108 != null)
         {
            _loc4_ = var_16.assets.getAssetByName("furni_view_branding_element") as XmlAsset;
            if(_loc4_ != null)
            {
               var _loc5_:class_1812 = var_16.windowManager.buildFromXML(_loc4_.content as XML) as class_1812;
               if(_loc5_ != null)
               {
                  var _loc6_:class_1741 = null.findChildByName("element_name");
                  if(_loc6_ != null)
                  {
                     null.caption = param1;
                  }
                  var _loc3_:class_1741 = null.findChildByName("element_value");
               }
            }
         }
      }
      
      private function getAdFurnitureExtraParams() : class_55
      {
         var _loc5_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc1_:class_55 = new class_55();
         if(var_16 != null)
         {
            _loc5_ = var_16.furniData.extraParam.substr("RWEIEP_BRANDING_OPTIONS".length);
            _loc3_ = _loc5_.split("\t");
            if(_loc3_ != null)
            {
               for each(var _loc2_ in _loc3_)
               {
                  _loc4_ = _loc2_.split("=",2);
                  if(_loc4_ != null && _loc4_.length == 2)
                  {
                     _loc7_ = _loc4_[0];
                     _loc6_ = _loc4_[1];
                     _loc1_.add(_loc7_,_loc6_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getVisibleAdFurnitureExtraParams() : String
      {
         var _loc2_:Array = null;
         var _loc7_:class_1741 = null;
         var _loc3_:class_1741 = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc1_:String = "";
         if(var_31 != null)
         {
            _loc2_ = [];
            var_31.groupChildrenWithTag("branding_element",_loc2_,-1);
            if(_loc2_.length > 0)
            {
               for each(var _loc6_ in _loc2_)
               {
                  _loc7_ = _loc6_.findChildByName("element_name");
                  _loc3_ = _loc6_.findChildByName("element_value");
                  if(_loc7_ != null && _loc3_ != null)
                  {
                     _loc5_ = trimAdFurnitureExtramParam(_loc7_.caption);
                     _loc4_ = trimAdFurnitureExtramParam(_loc3_.caption);
                     _loc1_ += _loc5_ + "=" + _loc4_ + "\t";
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function trimAdFurnitureExtramParam(param1:String) : String
      {
         if(param1 != null)
         {
            if(param1.indexOf("\t") != -1)
            {
               return param1.replace("\t","");
            }
         }
         return param1;
      }
      
      private function showAdFurnitureDetails(param1:Boolean) : void
      {
         var _loc5_:String = null;
         var _loc8_:class_55 = null;
         var _loc9_:String = null;
         if(var_16 == null || var_31 == null)
         {
            return;
         }
         var _loc4_:class_1741 = var_31.findChildByName("furni_details_spacer");
         if(_loc4_ != null)
         {
            _loc4_.visible = param1;
         }
         var _loc2_:Array = [];
         var_31.groupChildrenWithTag("branding_element",_loc2_,-1);
         if(_loc2_.length > 0)
         {
            for each(var _loc6_ in _loc2_)
            {
               var_31.removeChild(_loc6_);
               _loc6_.dispose();
            }
         }
         var _loc3_:Boolean = false;
         var _loc7_:class_1741 = var_31.findChildByName("furni_details_text") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.visible = param1;
            _loc5_ = "id: " + var_16.furniData.id;
            _loc8_ = getAdFurnitureExtraParams();
            if(_loc8_.length > 0)
            {
               _loc3_ = true;
               for each(var _loc10_ in _loc8_.getKeys())
               {
                  _loc9_ = _loc8_.getValue(_loc10_);
                  createAdElement(_loc10_,_loc9_);
               }
            }
            _loc7_.caption = _loc5_;
         }
         showButton("save_branding_configuration",_loc3_);
      }
      
      private function showGroupInfo(param1:Boolean) : void
      {
         showWindow("group_details_spacer",param1);
         showWindow("group_details_container",param1);
         showWindow("group_badge_image",false);
         showWindow("group_name",false);
      }
      
      private function showWindow(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_1741 = var_31.findChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function adElementKeyEventProc(param1:class_1758 = null, param2:class_1741 = null) : void
      {
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(var_34 == null)
         {
            return;
         }
         var _loc3_:class_1741 = var_34.getListItemByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            var_34.arrangeListItems();
         }
      }
      
      private function updatePurchaseButtonVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc12_:Boolean = false;
         var _loc10_:Boolean = param1 && param2;
         var _loc9_:Boolean = _loc10_ && param6;
         var _loc11_:Boolean = _loc10_ && param5;
         var _loc13_:Boolean = !_loc10_ && param3;
         var _loc15_:Boolean = param7 && var_16.config.getBoolean("infostand.place_more.enabled");
         var _loc14_:Boolean = !_loc10_ && param4;
         if(var_2510 != null)
         {
            var_2510.visible = _loc15_;
            if(!_loc12_)
            {
               _loc12_ = _loc15_;
            }
         }
         if(var_350 != null)
         {
            var_350.visible = _loc13_;
            if(!_loc12_)
            {
               _loc12_ = _loc13_;
            }
         }
         if(var_356 != null)
         {
            var_356.visible = _loc14_;
            if(!_loc12_)
            {
               _loc12_ = _loc14_;
            }
         }
         if(var_348 != null)
         {
            var_348.visible = _loc9_;
            if(!_loc12_)
            {
               _loc12_ = _loc9_;
            }
         }
         if(var_344 != null)
         {
            var_344.visible = _loc11_;
            if(!_loc12_)
            {
               _loc12_ = _loc11_;
            }
         }
         var _loc8_:IItemListWindow = var_108.getListItemByName("purchase_buttons") as IItemListWindow;
         if(_loc8_ != null)
         {
            _loc8_.arrangeListItems();
            _loc8_.visible = _loc12_;
         }
         var_108.arrangeListItems();
      }
      
      public function set groupName(param1:String) : void
      {
         var _loc2_:class_1741 = var_31.findChildByName("group_name");
         if(_loc2_)
         {
            _loc2_.caption = param1;
            _loc2_.visible = true;
         }
      }
      
      private function showLimitedItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:class_2010 = null;
         var _loc4_:ILimitedItemPreviewOverlayWidget = null;
         var _loc6_:class_1812 = var_31.findChildByName("unique_item_background_container") as class_1812;
         var _loc5_:class_1812 = var_31.findChildByName("unique_item_overlay_container") as class_1812;
         if(!_loc6_ || !_loc5_)
         {
            return;
         }
         if(!param1)
         {
            _loc6_.visible = false;
            _loc5_.visible = false;
         }
         else
         {
            _loc6_.visible = true;
            _loc5_.visible = true;
            _loc3_ = class_2010(_loc5_.findChildByName("unique_item_plaque_widget"));
            _loc4_ = ILimitedItemPreviewOverlayWidget(_loc3_.widget);
            _loc4_.serialNumber = param2.uniqueSerialNumber;
            _loc4_.seriesSize = param2.uniqueSeriesSize;
         }
      }
      
      private function showRarityItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:class_2010 = null;
         var _loc4_:IRarityItemPreviewOverlayWidget = null;
         var _loc5_:class_1812 = var_31.findChildByName("rarity_item_overlay_container") as class_1812;
         if(!_loc5_)
         {
            return;
         }
         if(!param1)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.visible = true;
            _loc3_ = class_2010(_loc5_.findChildByName("rarity_item_overlay_widget"));
            _loc4_ = IRarityItemPreviewOverlayWidget(_loc3_.widget);
            _loc4_.rarityLevel = param2.rarityLevel;
         }
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var _loc3_:class_2010 = var_31.findChildByName("group_badge_image") as class_2010;
         var _loc2_:class_3087 = _loc3_.widget as class_3087;
         _loc2_.badgeId = param1;
         _loc2_.groupId = var_16.furniData.groupId;
         _loc3_.visible = true;
      }
   }
}

