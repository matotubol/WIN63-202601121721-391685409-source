package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   import com.sulake.room.utils.Vector3d;
   
   public class FurniView implements IInventoryView, class_31
   {
      
      private static const STATE_NULL:int = 0;
      
      private static const STATE_INITIALIZING:int = 1;
      
      private static const STATE_EMPTY:int = 2;
      
      private static const STATE_CONTENT:int = 3;
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
      
      private var var_5013:String = "";
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_18:class_1812;
      
      private var var_608:FurniGridView;
      
      private var var_36:FurniModel;
      
      private var _marketplace:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _disposed:Boolean = false;
      
      private var var_1857:int = 0;
      
      private var var_1254:ILimitedItemPreviewOverlayWidget;
      
      private var var_1492:IRarityItemPreviewOverlayWidget;
      
      private var var_133:IItemListWindow;
      
      private var var_2071:class_1775;
      
      private var var_3701:class_1775;
      
      private var var_3583:class_1775;
      
      private var _offerInTradingButton:class_1775;
      
      private var _offerInTradingCountButton:ITextFieldWindow;
      
      private var var_3540:class_1775;
      
      private var var_3596:class_1775;
      
      private var var_3635:class_1775;
      
      private var var_265:Boolean = false;
      
      private var var_281:RoomPreviewer;
      
      private var var_2681:int = 0;
      
      public function FurniView(param1:FurniModel, param2:MarketplaceModel, param3:class_38, param4:class_40, param5:IRoomEngine)
      {
         super();
         var_36 = param1;
         _marketplace = param2;
         var_909 = param4;
         _windowManager = param3;
         _roomEngine = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_18 && var_18.parent != null && var_18.visible;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_265;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return var_608 ? var_608.currentPageItems : null;
      }
      
      public function get grid() : FurniGridView
      {
         return var_608;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_36 && var_36.controller)
            {
               var_36.controller.removeUpdateReceiver(this);
            }
            var_36 = null;
            _marketplace = null;
            var_909 = null;
            _windowManager = null;
            _roomEngine = null;
            if(var_1254)
            {
               var_1254.dispose();
               var_1254 = null;
            }
            if(var_1492)
            {
               var_1492.dispose();
               var_1492 = null;
            }
            if(var_18)
            {
               var_18.dispose();
               var_18 = null;
            }
            _disposed = true;
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         if(var_18 == null)
         {
            return null;
         }
         if(var_18.disposed)
         {
            return null;
         }
         updateActionButtons(false);
         return var_18;
      }
      
      public function setViewToState() : void
      {
         var _loc1_:int = 0;
         if(!var_36.isListInited())
         {
            _loc1_ = 1;
         }
         else if(!var_36.furniData || var_36.furniData.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(var_1857 == _loc1_)
         {
            return;
         }
         var_1857 = _loc1_;
         updateContainerVisibility();
      }
      
      public function clearViews() : void
      {
         updateActionView();
      }
      
      public function getFirstThumb() : class_1812
      {
         return var_608 != null ? var_608.getFirstThumb() : null;
      }
      
      public function updateActionView() : void
      {
         var _loc4_:FurnitureItem = null;
         var _loc5_:String = null;
         if(var_18 == null)
         {
            return;
         }
         if(var_18.disposed)
         {
            return;
         }
         updateContainerVisibility();
         var _loc6_:Boolean = false;
         var _loc7_:GroupItem = var_36.getSelectedItem();
         if(_loc7_ != null && _loc7_.peek() != null)
         {
            if(_loc7_.selectedItemIndex >= 0)
            {
               _loc4_ = _loc7_.getAt(_loc7_.selectedItemIndex);
               if(!_loc4_)
               {
                  _loc4_ = _loc7_.peek();
               }
            }
            else
            {
               _loc4_ = _loc7_.peek();
            }
            _loc6_ = true;
            _loc5_ = _roomEngine.getWallItemType(_loc4_.type);
            var_18.findChildByName("nextItemButton").visible = var_18.findChildByName("viewItemButton").visible = _loc5_ && _loc5_.indexOf("external_image_wallitem") != -1;
            var_18.findChildByName("furni_preview_widget").visible = true;
            var _loc10_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
            var _loc19_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
            var _loc8_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
            _loc10_ = "101";
            _loc19_ = "101";
            _loc8_ = "1.1";
            var_281.reset(false);
            var_281.updateObjectRoom(null,null,null);
            if(_loc4_.category == 2 || _loc4_.category == 3 || _loc4_.category == 4)
            {
               var_281.updateRoomWallsAndFloorVisibility(true,true);
               var _loc17_:String = _loc4_.category == 3 ? _loc7_.stuffData.getLegacyString() : null;
               var _loc3_:String = _loc4_.category == 2 ? _loc7_.stuffData.getLegacyString() : null;
               var _loc20_:String = _loc4_.category == 4 ? _loc7_.stuffData.getLegacyString() : null;
               var_281.updateObjectRoom(null,null,null);
               if(_loc4_.category == 4)
               {
                  var _loc12_:class_1800 = var_36.controller.getFurnitureDataByName("ads_twi_windw","i");
                  var_281.addWallItemIntoRoom(null.id,new Vector3d(90,0,0),null.customParams);
               }
            }
            else if(_loc7_.isWallItem)
            {
               var_281.updateRoomWallsAndFloorVisibility(true,true);
               var_281.addWallItemIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc4_.stuffData.getLegacyString());
            }
            else
            {
               var_281.updateRoomWallsAndFloorVisibility(false,true);
               var_281.addFurnitureIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc7_.stuffData,_loc7_.extra.toString());
            }
            var _loc14_:IStaticBitmapWrapperWindow = var_18.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            var _loc18_:ITextWindow = var_18.findChildByName("tradeable_number") as ITextWindow;
            var _loc16_:IRegionWindow = var_18.findChildByName("tradeable_info_region") as IRegionWindow;
            _loc14_ = var_18.findChildByName("recyclable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = var_18.findChildByName("recyclable_number") as ITextWindow;
            _loc16_ = var_18.findChildByName("recyclable_info_region") as IRegionWindow;
            var _loc1_:class_2010 = class_2010(var_18.findChildByName("unique_limited_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.uniqueSerialNumber > 0)
            {
               if(var_1254 == null)
               {
                  var_1254 = ILimitedItemPreviewOverlayWidget(null.widget);
               }
               var_1254.serialNumber = _loc4_.stuffData.uniqueSerialNumber;
               var_1254.seriesSize = _loc4_.stuffData.uniqueSeriesSize;
               null.visible = true;
            }
            else
            {
               null.visible = false;
            }
            var _loc11_:class_2010 = class_2010(var_18.findChildByName("rarity_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.rarityLevel >= 0)
            {
               if(var_1492 == null)
               {
                  var_1492 = IRarityItemPreviewOverlayWidget(null.widget);
               }
               var_1492.rarityLevel = _loc4_.stuffData.rarityLevel;
               null.visible = true;
            }
            else
            {
               null.visible = false;
            }
         }
         else
         {
            var_18.findChildByName("furni_preview_widget").visible = var_18.findChildByName("nextItemButton").visible = var_18.findChildByName("viewItemButton").visible = false;
            _loc14_ = var_18.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = var_18.findChildByName("tradeable_number") as ITextWindow;
            _loc16_ = var_18.findChildByName("tradeable_info_region") as IRegionWindow;
            _loc14_ = var_18.findChildByName("recyclable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = var_18.findChildByName("recyclable_number") as ITextWindow;
            _loc16_ = var_18.findChildByName("recyclable_info_region") as IRegionWindow;
         }
         var _loc2_:Boolean = var_36.isTradingOpen;
         updateActionButtons(_loc6_);
         if(_loc7_ && _loc4_)
         {
            var_18.findChildByName("furni_name").caption = _loc7_.name;
            if(_loc4_ && _roomEngine.getWallItemType(_loc4_.type) == "external_image_wallitem")
            {
               var_18.findChildByName("furni_description").caption = _loc4_.stuffData.getJSONValue("m");
            }
            else
            {
               var_18.findChildByName("furni_description").caption = _loc7_.description;
            }
         }
         else
         {
            var_18.findChildByName("furni_name").caption = "";
            var_18.findChildByName("furni_description").caption = "";
         }
         var _loc15_:ITextWindow = var_18.findChildByName("furni_extra") as ITextWindow;
         if(_loc15_ != null)
         {
            if(_loc4_ != null && _loc4_.stuffData != null && _loc4_.stuffData.rarityLevel >= 0)
            {
               var _loc13_:String = (_loc4_.stuffData as MapStuffData).getValue("rarity");
               if(_loc13_ != null)
               {
                  _windowManager.registerLocalizationParameter("inventory.rarity","rarity",String(_loc4_.stuffData.rarityLevel));
                  _loc15_.text = var_36.localization.getLocalization("inventory.rarity");
                  _loc15_.visible = true;
               }
            }
            else
            {
               _loc15_.text = "";
            }
         }
         updateRentedItem();
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         if(var_18 == null)
         {
            return;
         }
         if(var_18.disposed)
         {
            return;
         }
         var _loc2_:FurnitureItem = param1.peek();
         if(_loc2_.isWallItem)
         {
            var_281.addWallItemIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData.getLegacyString());
         }
         else
         {
            var_281.addFurnitureIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData);
         }
         var_2071.disable();
         _offerInTradingButton.disable();
         _offerInTradingCountButton.disable();
      }
      
      public function addItems(param1:Vector.<GroupItem>) : void
      {
         if(var_608)
         {
            var_608.setItems(param1);
         }
      }
      
      public function updateGridFilters() : void
      {
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var _loc4_:class_2261 = var_18.findChildByName("filter.options") as class_2261;
         var _loc2_:class_2261 = var_18.findChildByName("placement.options") as class_2261;
         var _loc3_:String = var_18.findChildByName("filter").caption;
         var _loc1_:String = _loc4_.enumerateSelection()[_loc4_.selection];
         var_608.setFilter(_loc4_.selection,_loc1_,var_36.showingRentedFurni,var_36.controller.mergeRentFurni,_loc3_,_loc2_.selection,var_36.showingNfts);
      }
      
      public function resetFilters(param1:String) : void
      {
         var _loc3_:class_2261 = var_18.findChildByName("filter.options") as class_2261;
         var _loc2_:class_2261 = var_18.findChildByName("placement.options") as class_2261;
         _loc3_.selection = 0;
         switch(param1)
         {
            case "furni":
               _loc2_.selection = _loc2_.numMenuItems > 2 ? 2 : 0;
               _loc2_.disable();
               break;
            case "rentables":
               _loc2_.selection = var_2681;
               _loc2_.enable();
         }
         if(var_5013 != param1)
         {
            var_18.findChildByName("filter").caption = "";
            var_18.findChildByName("clear_filter_button").visible = false;
         }
         var_5013 = param1;
         updateGridFilters();
      }
      
      private function init() : void
      {
         var_18 = var_36.controller.view.getView("furni");
         var_18.enableLookupCache();
         var_18.visible = false;
         var_18.procedure = windowEventProc;
         var _loc1_:IItemGridWindow = var_18.findChildByName("item_grid") as IItemGridWindow;
         var _loc3_:IItemListWindow = var_18.findChildByName("item_grid_pages") as IItemListWindow;
         _loc3_.enableScrollByDragging = true;
         var_608 = new FurniGridView(_loc1_,_loc3_);
         populateFilterOptions();
         var_133 = var_18.findChildByName("preview_element_list") as IItemListWindow;
         var_2071 = var_133.removeListItem(var_133.getListItemByName("placeinroom_btn")) as class_1775;
         var_3596 = var_133.removeListItem(var_133.getListItemByName("extendrent_btn")) as class_1775;
         var_3635 = var_133.removeListItem(var_133.getListItemByName("buyrenteditem_btn")) as class_1775;
         var_3701 = var_133.removeListItem(var_133.getListItemByName("goto_room_btn")) as class_1775;
         var_3540 = var_133.removeListItem(var_133.getListItemByName("use_btn")) as class_1775;
         _offerInTradingCountButton = var_133.removeListItem(var_133.getListItemByName("offertotrade_cnt")) as ITextFieldWindow;
         _offerInTradingButton = var_133.removeListItem(var_133.getListItemByName("offertotrade_btn")) as class_1775;
         var_3583 = var_133.removeListItem(var_133.getListItemByName("sell_btn")) as class_1775;
         var _loc2_:IRoomPreviewerWidget = (var_18.findChildByName("furni_preview_widget") as class_2010).widget as IRoomPreviewerWidget;
         var_281 = _loc2_.roomPreviewer;
         var_36.controller.registerUpdateReceiver(this,1);
         setViewToState();
         var_265 = true;
      }
      
      private function fixPreviewHeightInTrading() : void
      {
         var _loc1_:class_2010 = var_18.findChildByName("furni_preview_widget") as class_2010;
         var _loc2_:IRoomPreviewerWidget = (var_18.findChildByName("furni_preview_widget") as class_2010).widget as IRoomPreviewerWidget;
         _loc2_.roomPreviewer.modifyRoomCanvas(_loc1_.width,_loc1_.height);
      }
      
      private function updateActionButtons(param1:Boolean) : void
      {
         if(var_36.isTradingOpen)
         {
            fixPreviewHeightInTrading();
         }
         removeButtons();
         var _loc2_:Boolean = var_36.isTradingOpen;
         var _loc6_:GroupItem = var_36.getSelectedItem();
         var _loc3_:FurnitureItem = null;
         if(_loc6_)
         {
            _loc3_ = _loc6_.peek();
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc10_:class_1800 = var_36.controller.getFurnitureData(_loc3_.type,_loc3_.isWallItem ? "i" : "s");
         var _loc9_:Boolean = param1 && _marketplace && _marketplace.isEnabled && _loc3_.sellable && !var_36.controller.sessionData.isAccountSafetyLocked() && !_loc2_;
         var _loc5_:Boolean = var_36.isPrivateRoom && param1 && (_loc3_.category == 16 || _loc3_.category == 14 || _loc3_.category == 15 || _loc3_.category == 13 || _loc3_.category == 20);
         var _loc4_:Boolean = true;
         if(_loc3_.isRented)
         {
            if(_loc3_.flatId > -1)
            {
               _loc4_ = false;
            }
         }
         var _loc11_:* = _loc3_.flatId > -1;
         var _loc7_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.rentCouldBeUsedForBuyout;
         var _loc8_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.purchaseCouldBeUsedForBuyout;
         if(_loc10_ && _loc10_.isExternalImageType)
         {
            _loc9_ = false;
         }
         updateButtonAvailability(var_2071,!_loc2_ && _loc4_);
         updateButtonAvailability(var_3596,!_loc2_ && _loc7_);
         updateButtonAvailability(var_3635,!_loc2_ && _loc8_);
         updateButtonAvailability(var_3701,!_loc2_ && _loc11_);
         updateButtonAvailability(_offerInTradingCountButton,_loc2_ && var_36.controller.getBoolean("multi.item.trading.enabled"));
         updateButtonAvailability(_offerInTradingButton,_loc2_);
         updateButtonAvailability(var_3583,_loc9_);
         updateButtonAvailability(var_3540,_loc5_);
         if(param1 && var_36.isPrivateRoom)
         {
            var_2071.enable();
         }
         else
         {
            var_2071.disable();
         }
         if(param1 && _loc6_ != null && _loc3_ != null && var_36.canUserOfferToTrade())
         {
            if(_loc6_.getUnlockedCount() && _loc3_.tradeable)
            {
               _offerInTradingButton.enable();
               _offerInTradingCountButton.enable();
            }
            else
            {
               _offerInTradingButton.disable();
               _offerInTradingCountButton.disable();
            }
         }
         else
         {
            _offerInTradingButton.disable();
            _offerInTradingCountButton.disable();
         }
      }
      
      private function updateButtonAvailability(param1:IInteractiveWindow, param2:Boolean) : void
      {
         if(var_133.getListItemByName(param1.name) == null)
         {
            if(param2)
            {
               var_133.addListItem(param1);
            }
         }
         else if(!param2)
         {
            var_133.removeListItem(param1);
         }
      }
      
      private function removeButtons() : void
      {
         var_133.removeListItem(var_2071);
         var_133.removeListItem(var_3596);
         var_133.removeListItem(var_3635);
         var_133.removeListItem(var_3701);
         var_133.removeListItem(var_3540);
         var_133.removeListItem(_offerInTradingCountButton);
         var_133.removeListItem(_offerInTradingButton);
         var_133.removeListItem(var_3583);
      }
      
      private function updateContainerVisibility() : void
      {
         if(!var_265)
         {
            return;
         }
         if(var_36.controller.currentCategoryId != "furni" && var_36.controller.currentCategoryId != "rentables")
         {
            return;
         }
         var _loc1_:class_1812 = var_36.controller.view.loadingContainer;
         var _loc4_:class_1812 = var_36.controller.view.emptyContainer;
         var _loc5_:class_1812 = var_18.findChildByName("grid_container") as class_1812;
         var _loc2_:class_1812 = var_18.findChildByName("preview_container") as class_1812;
         var _loc3_:class_1812 = var_18.findChildByName("options_container") as class_1812;
         switch(var_1857 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = false;
               _loc2_.visible = false;
               _loc3_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = true;
               }
               _loc5_.visible = false;
               _loc2_.visible = false;
               _loc3_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = true;
               _loc2_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function showNextPreviewItem() : void
      {
         var_36.getSelectedItem().selectedItemIndex++;
         updateActionView();
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc9_:GroupItem = null;
         var _loc3_:class_1875 = null;
         var _loc6_:WindowKeyboardEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "placeinroom_btn":
               case "furni_preview_region":
                  if(!var_36.isTradingOpen)
                  {
                     var_36.requestSelectedFurniPlacement(false);
                  }
                  break;
               case "nextItemButton":
                  showNextPreviewItem();
                  break;
               case "viewItemButton":
                  var _loc4_:GroupItem = var_36.getSelectedItem();
                  var _loc5_:FurnitureItem = _loc4_.getAt(_loc4_.selectedItemIndex);
                  if(!_loc5_)
                  {
                     _loc5_ = null.peek();
                  }
                  _roomEngine.showUseProductSelection(null.ref,null.type,null.id);
                  break;
               case "goto_room_btn":
                  var_36.gotoRoom();
                  break;
               case "offertotrade_btn":
                  var _loc8_:int = Math.max(1,int(_offerInTradingCountButton.caption));
                  if(_loc8_ != int(_offerInTradingCountButton.caption))
                  {
                     _offerInTradingCountButton.caption = String(0);
                  }
                  var_36.requestSelectedFurniToTrading(0,_offerInTradingCountButton);
                  break;
               case "sell_btn":
                  var_36.requestSelectedFurniSelling();
                  break;
               case "use_btn":
                  var_36.showUseProductSelection();
                  break;
               case "extendrent_btn":
                  var_36.extendRentPeriod();
                  break;
               case "buyrenteditem_btn":
                  var_36.buyRentedItem();
                  break;
               case "clear_filter_button":
                  var_18.findChildByName("filter").caption = "";
                  param2.visible = false;
                  updateGridFilters();
                  break;
               default:
                  var_36.cancelFurniInMover();
            }
         }
         else if(param1.type == "WME_DOWN")
         {
            var _loc10_:* = param2.name;
            if("furni_preview_region" === _loc10_)
            {
               _loc9_ = var_36.getSelectedItem();
               if(_loc9_ == null)
               {
                  return;
               }
               _loc3_ = _loc9_.peek();
               if(_loc3_.category == 2 || _loc3_.category == 3 || _loc3_.category == 4)
               {
                  return;
               }
               if(!var_36.isTradingOpen)
               {
                  var_36.requestSelectedFurniPlacement(false);
               }
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc10_ = param2.name;
            if("filter" === _loc10_)
            {
               var_18.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc6_.keyCode == 13)
               {
                  updateGridFilters();
               }
            }
         }
         if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "filter.options":
                  updateGridFilters();
                  break;
               case "placement.options":
                  var _loc7_:class_2261 = var_18.findChildByName("placement.options") as class_2261;
                  if(var_36.controller.currentCategoryId == "rentables")
                  {
                     var_2681 = null.selection;
                  }
                  updateGridFilters();
            }
         }
      }
      
      private function populateFilterOptions() : void
      {
         var _loc3_:class_2261 = var_18.findChildByName("filter.options") as class_2261;
         var _loc1_:Array = [];
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.filter.option.everything","Everything"));
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.furni.tab.floor","Floor"));
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.furni.tab.wall","Wall"));
         _loc3_.populate(_loc1_);
         _loc3_.selection = 0;
         var _loc2_:class_2261 = var_18.findChildByName("placement.options") as class_2261;
         _loc1_ = [];
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.placement.option.anywhere","Anywhere"));
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.placement.option.inroom","In room"));
         _loc1_.push(var_36.controller.localization.getLocalization("inventory.placement.option.notinroom","Not in room"));
         _loc2_.populate(_loc1_);
         _loc2_.selection = 2;
         var_2681 = 2;
         var_18.findChildByName("filter").caption = "";
         var_18.findChildByName("items.shown").visible = false;
         var_18.invalidate();
      }
      
      public function updateRentedItem() : void
      {
         if(var_36 == null)
         {
            return;
         }
         var _loc2_:GroupItem = var_36.getSelectedItem();
         var _loc1_:FurnitureItem = null;
         if(_loc2_)
         {
            _loc1_ = _loc2_.peek();
         }
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.isRented)
         {
            return;
         }
         var _loc3_:class_1741 = var_18.findChildByName("furni_extra") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = true;
         if(_loc1_.hasRentPeriodStarted)
         {
            var_36.controller.localization.registerParameter("inventory.rent.expiration","time",FriendlyTime.getFriendlyTime(var_36.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = var_36.controller.localization.getLocalization("inventory.rent.expiration");
         }
         else
         {
            var_36.controller.localization.registerParameter("inventory.rent.inactive","time",FriendlyTime.getFriendlyTime(var_36.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = var_36.controller.localization.getLocalization("inventory.rent.inactive");
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_281 != null)
         {
            var_281.updatePreviewRoomView();
         }
      }
   }
}

