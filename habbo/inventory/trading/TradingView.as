package com.sulake.habbo.inventory.trading
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.ItemPopupCtrl;
   import com.sulake.habbo.inventory.Util;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.items.CreditTradingItem;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import package_88.class_3098;
   
   public class TradingView implements IInventoryView, class_1829
   {
      
      private static const COLOR_LOCKED:uint = 4284532064;
      
      private static const COLOR_UNLOCKED:uint = 2577770;
      
      public static const ALERT_SCAM:int = 0;
      
      public static const ALERT_OTHER_CANCELLED:int = 1;
      
      public static const ALERT_ALREADY_OPEN:int = 2;
      
      private static const TRADE_UI_SPACING:int = 7;
      
      private var var_23:TradingModel;
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_909:class_40;
      
      private var var_578:ItemPopupCtrl;
      
      private var _soundManager:class_544;
      
      private var _disposed:Boolean = false;
      
      private var var_588:Boolean;
      
      private var var_82:class_1812;
      
      private var _windowMin:class_1812;
      
      private var var_323:Timer;
      
      private var _selection:GroupItem;
      
      private var var_530:Boolean;
      
      private var _waitingSongInfo:Array = [];
      
      public function TradingView(param1:TradingModel, param2:class_38, param3:class_40, param4:IRoomEngine, param5:class_27, param6:class_544)
      {
         super();
         var_23 = param1;
         _windowManager = param2;
         _localization = param5;
         var_909 = param3;
         _roomEngine = param4;
         _soundManager = param6;
         var_588 = false;
         var _loc8_:IAsset = var_909.getAssetByName("item_popup_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc8_);
         var _loc9_:class_1812 = _windowManager.buildFromXML(_loc7_.content as XML) as class_1812;
         _loc9_.visible = false;
         var_578 = new ItemPopupCtrl(_loc9_,var_909,_windowManager,var_23);
         _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_82 && !var_82.disposed)
            {
               var_82.dispose();
               var_82 = null;
            }
            if(var_323)
            {
               var_323.removeEventListener("timer",timerEventHandler);
               var_323.stop();
               var_323 = null;
            }
            if(var_578 != null)
            {
               var_578.dispose();
               var_578 = null;
            }
            if(_soundManager)
            {
               if(_soundManager.events != null)
               {
                  _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
               }
               _soundManager = null;
            }
            _waitingSongInfo = null;
            var_23 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            var_909 = null;
            _selection = null;
            var_588 = false;
            _disposed = true;
         }
      }
      
      public function setup(param1:int, param2:Boolean, param3:int, param4:Boolean) : void
      {
         setMinimized(false);
         hideOwnUserNotification();
         hideOtherUserNotification();
         if(!param2 && !param4)
         {
            showInfoMessage("${inventory.trading.warning.both_accounts_disabled}");
            showOwnUserNotification("");
            showOtherUserNotification("");
         }
         else
         {
            if(!param2)
            {
               showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
            }
            if(!param4)
            {
               showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
            }
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         if(var_82 == null)
         {
            var_82 = createNormalWindow();
            showHighlightInfo(null);
         }
         if(_windowMin == null)
         {
            _windowMin = createMinimizedWindow();
         }
         if(!var_530)
         {
            resizeWindow(true);
            return var_82;
         }
         return _windowMin;
      }
      
      public function setMinimized(param1:Boolean = false) : void
      {
         var_530 = param1;
      }
      
      public function updateItemList(param1:int) : void
      {
         var _loc3_:GroupItem = null;
         var _loc10_:CollectibleGroupedItem = null;
         var _loc9_:class_1812 = null;
         if(!var_82)
         {
            return;
         }
         var _loc8_:uint = 0;
         var _loc14_:* = param1 == var_23.otherUserId;
         var _loc13_:class_55 = _loc14_ ? var_23.otherUserItems : var_23.ownUserItems;
         var _loc11_:class_55 = _loc14_ ? var_23.otherUserNftItems : var_23.ownUserNftItems;
         var _loc12_:IItemGridWindow = _loc14_ ? getOtherUsersItemGrid() : getOwnUsersItemGrid();
         while(_loc8_ < _loc13_.length)
         {
            _loc3_ = _loc13_.getWithIndex(_loc8_) as GroupItem;
            _loc9_ = _loc12_.getGridItemAt(_loc8_) as class_1812;
            if(_loc9_)
            {
               _loc9_.id = _loc8_;
               while(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc9_.addChild(fixItemWindow(_loc3_.window));
               _loc3_.window.id = _loc8_;
               _loc3_.removeIntervalProcedure();
            }
            _loc8_++;
         }
         var _loc5_:int = int(_loc8_);
         while(_loc8_ < _loc5_ + _loc11_.length)
         {
            _loc10_ = _loc11_.getWithIndex(_loc8_ - _loc5_) as CollectibleGroupedItem;
            _loc9_ = _loc12_.getGridItemAt(_loc8_) as class_1812;
            if(_loc9_)
            {
               _loc9_.id = _loc8_;
               while(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc9_.addChild(fixItemWindow(_loc10_.window));
               _loc10_.window.id = _loc8_;
               _loc10_.removeIntervalProcedure();
            }
            _loc8_++;
         }
         while(_loc8_ < _loc12_.numGridItems)
         {
            _loc9_ = _loc12_.getGridItemAt(_loc8_) as class_1812;
            if(_loc9_)
            {
               _loc9_.id = _loc8_;
               _loc9_.removeChildAt(0);
               _loc9_.invalidate();
            }
            _loc8_++;
         }
         updateActionState();
      }
      
      private function fixItemWindow(param1:class_1812) : class_1812
      {
         var _loc2_:int = 0;
         var _loc3_:class_1741 = null;
         param1.height = 40;
         param1.width = 40;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            _loc3_.rectangle = new Rectangle(0,0,40,40);
            _loc2_++;
         }
         return param1;
      }
      
      public function clearItemLists() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:* = 0;
         var _loc1_:IItemGridWindow = null;
         _loc1_ = getOwnUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as class_1812;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
         _loc1_ = getOtherUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as class_1812;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
      }
      
      public function updateUserInterface() : void
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(var_82)
         {
            updateActionState();
            _loc2_ = var_82.findChildByTag("OTHER_USER_NAME") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = var_23.otherUserName;
            }
            _loc1_ = var_82.findChildByTag("OWN_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = var_23.ownUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
            _loc1_ = var_82.findChildByTag("OTHER_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = var_23.otherUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
         }
      }
      
      public function updateActionState() : void
      {
         var _loc1_:class_1741 = null;
         var _loc2_:class_1741 = null;
         if(var_82)
         {
            _loc1_ = var_82.findChildByName("button_accept");
            _loc2_ = var_82.findChildByName("button_cancel");
            if(var_23.getInventory().getBoolean("trading.warning.enabled"))
            {
               while(true)
               {
                  if(var_23.isCreditFurniPresent())
                  {
                     showHighlightInfo(_localization.getLocalization("inventory.trading.warning.credits","inventory.trading.warning.credits"));
                  }
                  else
                  {
                     showHighlightInfo(null);
                  }
               }
               §§goto(addr0201);
            }
            showSilverFeeInfo(var_23.requiredSilverFee,var_23.playerSilver,var_23.otherPlayerSilver);
            showOwnOfferInfo(var_23.ownUserNumItemsTotal,var_23.ownUserNumCredits);
            showOtherOfferInfo(var_23.otherUserNumItemsTotal,var_23.otherUserNumCredits);
            switch(int(var_23.state))
            {
               case 0:
                  if((var_23.otherHasAnyOffer || var_23.ownHasAnyOffer) && var_23.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = "${inventory.trading.accept}";
                  break;
               case 1:
                  if((var_23.otherHasAnyOffer || var_23.ownHasAnyOffer) && var_23.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = var_23.ownUserAccepts ? "${inventory.trading.modify}" : "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.add}");
                  break;
               case 2:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.countdown}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 3:
                  _loc1_.enable();
                  _loc1_.caption = "${inventory.trading.confirm}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 4:
                  _loc1_.disable();
                  showInfoMessage("${inventory.trading.info.waiting}");
                  break;
               case 5:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 6:
                  break;
               default:
                  throw new Error("Unknown trading progress state: \"" + var_23.state + "\"");
            }
            Util.disableButton(_loc2_,var_23.isConfirmingWeb3Trade());
         }
         addr0201:
      }
      
      public function showInfoMessage(param1:String) : void
      {
         var _loc2_:ITextWindow = var_82.findChildByName("help_text") as ITextWindow;
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      private function showHighlightInfo(param1:String) : void
      {
         if(!var_82)
         {
            return;
         }
         var _loc3_:class_1741 = var_82.findChildByName("info_border_highlighted");
         if(_loc3_)
         {
            _loc3_.visible = param1 != null;
         }
         var _loc2_:ITextWindow = var_82.findChildByName("info_text_highlighted") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.visible = param1 != null;
            if(param1)
            {
               _loc2_.text = param1;
            }
         }
         resizeWindow();
      }
      
      private function showSilverFeeInfo(param1:int, param2:int, param3:int) : void
      {
         silverFeeContainer.visible = var_23.isWeb3Trade();
         yourSilver.text = String(param2);
         otherSilver.text = String(param3);
         var _loc6_:int = param2 + param3;
         var _loc7_:String = param1 <= _loc6_ ? "000000" : "AC232A";
         silverProgress.text = "<font color=\"#" + _loc7_ + "\">" + _loc6_ + "</font>/" + param1;
         var _loc5_:Boolean = var_23.state == 0 || var_23.state == 1;
         Util.disableButton(feeMinusButton,param2 <= 0 || !_loc5_);
         Util.disableButton(feePlusButton,param2 + param3 >= param1 || param2 >= var_23.getInventory().catalog.getPurse().silverBalance || !_loc5_);
         if(var_23.isWeb3Trade())
         {
            var _loc4_:String = param1 <= 0 ? "inventory.trading.note_silver_fee_free_temporarily" : "inventory.trading.note_silver_fee";
            silverFeeInfoText.text = _localization.getLocalization(null);
         }
         resizeWindow();
      }
      
      private function resizeWindow(param1:Boolean = true) : void
      {
         Util.moveAllChildrenToColumn(var_82,7,!param1);
         var_82.height = Util.getLowestPoint(var_82);
         var_23.getInventory().view.resizeToFitContents();
      }
      
      private function showOwnOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_1_a",param1,"content_text_1_b",param2,true);
      }
      
      private function showOtherOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_2_a",param1,"content_text_2_b",param2,false);
      }
      
      private function showOfferInfo(param1:String, param2:int, param3:String, param4:int, param5:Boolean) : void
      {
         var _loc6_:ITextWindow = null;
         if(!var_23.getInventory().getBoolean("trading.warning.enabled"))
         {
            return;
         }
         _loc6_ = var_82.findChildByName(param1) as ITextWindow;
         if(_loc6_)
         {
            _localization.registerParameter("inventory.trading.info.itemcount","value",param2.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.itemcount");
         }
         _loc6_ = var_82.findChildByName(param3) as ITextWindow;
         if(_loc6_)
         {
            _localization.registerParameter("inventory.trading.info.creditvalue","value",param4.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.creditvalue");
         }
      }
      
      public function showOwnUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = var_82.findChildByName("info_text_0") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = var_82.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOwnUserNotification() : void
      {
         var _loc2_:ITextWindow = var_82.findChildByName("info_text_0") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = var_82.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function showOtherUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = var_82.findChildByName("info_text_1") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = var_82.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOtherUserNotification() : void
      {
         var _loc2_:ITextWindow = var_82.findChildByName("info_text_1") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = var_82.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function alertTradeOpenFailed(param1:class_3098) : void
      {
         var _loc2_:String = "inventory.trading.openfail." + param1.getParser().reason;
         _windowManager.registerLocalizationParameter(_loc2_,"otherusername",param1.getParser().otherUserName);
         _windowManager.simpleAlert("${inventory.trading.openfail.title}","${inventory.trading.openfail.caption}","${" + _loc2_ + "}");
      }
      
      public function alertPopup(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.warning.other_not_offering}",0,onTradingAlert);
               break;
            case 1:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.closed}",0,onTradingAlert);
               break;
            case 2:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.already_open}",0,onTradingAlert);
         }
      }
      
      public function showAlertNotification(param1:String, param2:String, param3:Function) : void
      {
         var title:String = param1;
         var description:String = param2;
         var callback:Function = param3;
         _windowManager.alert(title,description,0,callback ?? function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
      
      public function startConfirmCountdown() : void
      {
         if(var_323 == null)
         {
            var_323 = new Timer(1000,3);
            var_323.addEventListener("timer",timerEventHandler);
         }
         var_323.reset();
         var_323.repeatCount = 3;
         var_323.start();
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter","3");
         updateUserInterface();
      }
      
      public function cancelConfirmCountdown() : void
      {
         if(var_323 != null)
         {
            var_323.reset();
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc4_:GroupItem = null;
         var _loc6_:class_55 = null;
         var _loc3_:Boolean = false;
         var _loc5_:* = 0;
         _loc6_ = var_23.ownUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_.getWithIndex(_loc5_) as GroupItem;
            if(_loc4_.iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(var_23.ownUserId);
         }
         _loc6_ = var_23.otherUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc5_] as GroupItem;
            if(_loc4_.iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(var_23.otherUserId);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function setSelection(param1:GroupItem) : void
      {
         removeSelection();
         if(param1)
         {
            _selection = param1;
            _selection.isSelected = true;
         }
      }
      
      public function removeSelection() : void
      {
         if(_selection)
         {
            _selection.isSelected = false;
            _selection = null;
         }
      }
      
      public function updateItemImage(param1:int, param2:BitmapData) : void
      {
      }
      
      public function onTradingAlert(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            param1.dispose();
         }
      }
      
      protected function getOwnUsersItemGrid() : IItemGridWindow
      {
         return var_82.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
      }
      
      protected function getOtherUsersItemGrid() : IItemGridWindow
      {
         return var_82.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
      }
      
      protected function resolveItemThumbnail(param1:GroupItem) : BitmapData
      {
         var _loc2_:BitmapData = param1.iconImage;
         if(_loc2_ == null)
         {
            if(param1.isWallItem)
            {
               var _loc3_:class_2198 = _roomEngine.getWallItemIcon(param1.type,this,param1.stuffData.getLegacyString());
            }
            else
            {
               _loc3_ = _roomEngine.getFurnitureIcon(param1.type,this,null,param1.stuffData);
            }
            if(null.id > 0)
            {
               param1.iconCallbackId = null.id;
            }
            _loc2_ = null.data;
            param1.iconImage = _loc2_;
         }
         return _loc2_;
      }
      
      protected function createThumbnailContainer() : class_1812
      {
         var _loc1_:XML = XmlAsset(var_909.getAssetByName("inventory_thumb_xml")).content as XML;
         return _windowManager.buildFromXML(_loc1_) as class_1812;
      }
      
      protected function selectOwnTradeItem(param1:uint) : void
      {
         if(var_23 == null || var_23.ownUserItems == null)
         {
            return;
         }
         if(param1 < var_23.ownUserItems.length)
         {
            var _loc2_:GroupItem = var_23.ownUserItems.getWithIndex(param1) as GroupItem;
            setSelection(null);
         }
      }
      
      protected function selectOthersTradeItem(param1:uint) : void
      {
         if(var_23 == null || var_23.otherUserItems == null)
         {
            return;
         }
         if(param1 < var_23.otherUserItems.length)
         {
            var _loc2_:GroupItem = var_23.otherUserItems.getWithIndex(param1) as GroupItem;
            setSelection(null);
         }
      }
      
      private function createNormalWindow() : class_1812
      {
         var _loc2_:class_1741 = null;
         var _loc5_:* = 0;
         var _loc4_:IItemGridWindow = null;
         var _loc1_:XML = XmlAsset(var_909.getAssetByName("inventory_trading_xml")).content as XML;
         var _loc6_:class_1812 = _windowManager.buildFromXML(_loc1_) as class_1812;
         _loc4_ = _loc6_.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = ownThumbEventProc;
            _loc2_.addEventListener("WME_OVER",ownThumbEventProc);
            _loc2_.addEventListener("WME_OUT",ownThumbEventProc);
            _loc5_++;
         }
         _loc4_ = _loc6_.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = othersThumbEventProc;
            _loc2_.addEventListener("WME_OVER",othersThumbEventProc);
            _loc2_.addEventListener("WME_OUT",othersThumbEventProc);
            _loc5_++;
         }
         _loc6_.procedure = windowEventProc;
         return _loc6_;
      }
      
      private function createMinimizedWindow() : class_1812
      {
         var _loc1_:XML = XmlAsset(var_909.getAssetByName("inventory_trading_minimized_xml")).content as XML;
         var _loc2_:class_1812 = _windowManager.buildFromXML(_loc1_) as class_1812;
         _loc2_.procedure = windowMininizedEventProc;
         return _loc2_;
      }
      
      private function windowMininizedEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_continue":
                  var_23.requestFurniViewOpen();
                  break;
               case "button_cancel":
                  var_23.requestCancelTrading();
            }
         }
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_accept":
                  switch(int(var_23.state) - 1)
                  {
                     case 0:
                        if(var_23.otherUserItems.length == 0 && var_23.otherUserNftItems.length == 0 && !var_23.ownUserAccepts)
                        {
                           alertPopup(0);
                        }
                        if(var_23.ownUserAccepts)
                        {
                           var_23.requestUnacceptTrading();
                           break;
                        }
                        var_23.requestAcceptTrading();
                        break;
                     case 2:
                        param2.disable();
                        var_23.requestConfirmAcceptTrading();
                  }
                  break;
               case "button_cancel":
                  switch(int(var_23.state) - 1)
                  {
                     case 0:
                        var_23.requestCancelTrading();
                        break;
                     case 2:
                        var_23.requestConfirmDeclineTrading();
                  }
                  break;
               case "silver_minus_button":
                  var_23.addSilverFee(false);
                  break;
               case "silver_plus_button":
                  var_23.addSilverFee(true);
            }
         }
      }
      
      private function ownThumbEventProc(param1:class_1758, param2:class_1741) : void
      {
         thumbEventProc(param1,param2,true);
      }
      
      private function othersThumbEventProc(param1:class_1758, param2:class_1741) : void
      {
         thumbEventProc(param1,param2,false);
      }
      
      private function thumbEventProc(param1:class_1758, param2:class_1741, param3:Boolean) : void
      {
         var _loc6_:GroupItem = null;
         var _loc11_:CollectibleGroupedItem = null;
         var _loc4_:FurnitureItem = null;
         var _loc9_:int = 0;
         var _loc14_:IProductDisplayInfo = null;
         var _loc13_:String = null;
         var _loc10_:CreditTradingItem = null;
         var _loc5_:BitmapData = null;
         var _loc12_:String = null;
         var _loc8_:FurnitureItem = null;
         var _loc7_:Date = null;
         if(param3 && param1.type == "WME_CLICK")
         {
            var_23.requestRemoveItemFromTrading(param2.id);
         }
         if(param1.type == "WME_OVER")
         {
            if(param3)
            {
               _loc9_ = int(var_23.ownUserItems.length);
               if(param2.id >= _loc9_)
               {
                  _loc11_ = var_23.ownUserNftItems.getWithIndex(param2.id - _loc9_);
               }
               else
               {
                  _loc6_ = var_23.ownUserItems.getWithIndex(param2.id);
               }
            }
            else
            {
               _loc9_ = int(var_23.otherUserItems.length);
               if(param2.id >= _loc9_)
               {
                  _loc11_ = var_23.otherUserNftItems.getWithIndex(param2.id - _loc9_);
               }
               else
               {
                  _loc6_ = var_23.otherUserItems.getWithIndex(param2.id);
               }
            }
            if(_loc11_ != null)
            {
               _loc14_ = _loc11_.renderableItem;
               _loc13_ = var_23.getInventory().catalog.collectorHub.getProductName(_loc14_);
               var_578.updateContent(param2 as class_1812,_loc13_,null,_loc14_);
               var_578.show();
               return;
            }
            if(_loc6_ == null)
            {
               return;
            }
            _loc10_ = _loc6_ as CreditTradingItem;
            if(_loc10_ != null && !param3)
            {
               var_578.updateContent(param2 as class_1812,_loc10_.getItemTooltipText(),_loc10_.getItemIcon(),null,null,2,false);
               var_578.show();
               return;
            }
            _loc4_ = _loc6_.peek();
            if(_loc4_ == null)
            {
               return;
            }
            _loc5_ = var_23.getItemImage(_loc4_);
            if(!_loc4_.isWallItem)
            {
               _loc12_ = "${roomItem.name." + _loc4_.type + "}";
            }
            else
            {
               _loc12_ = "${wallItem.name." + _loc4_.type + "}";
            }
            if(_loc4_.category == 6)
            {
               _loc12_ = "${poster_" + _loc4_.stuffData.getLegacyString() + "_name}";
            }
            if(_loc4_.category == 10)
            {
               _loc8_ = _loc4_ as FurnitureItem;
               _loc7_ = new Date(_loc8_.creationYear,_loc8_.creationMonth - 1,_loc8_.creationDay);
               _loc12_ = _localization.getLocalization("roomItem.name." + _loc4_.type) + " " + _loc7_.toLocaleDateString();
            }
            if(_loc4_.category == 8)
            {
               _loc12_ = getTraxSongFurniName(_loc6_,_loc12_,true,param2.id,param3);
            }
            var_578.updateContent(param2 as class_1812,_loc12_,_loc5_,null,_loc6_.peek().stuffData,2,isExternalImagetype(_loc4_));
            var_578.show();
         }
         else if(param1.type == "WME_OUT")
         {
            var_578.hideDelayed();
         }
      }
      
      private function isExternalImagetype(param1:FurnitureItem) : Boolean
      {
         if(!var_23.getInventory())
         {
            return false;
         }
         var _loc2_:class_1800 = var_23.getInventory().getFurnitureData(param1.type,"i");
         return _loc2_ && _loc2_.isExternalImageType;
      }
      
      private function getTraxSongFurniName(param1:GroupItem, param2:String, param3:Boolean, param4:int = -1, param5:Boolean = false) : String
      {
         var _loc6_:class_1875 = param1.peek();
         var _loc7_:ISongInfo = _soundManager.musicController.getSongInfo(_loc6_.extra);
         if(_loc7_ != null)
         {
            _localization.registerParameter("songdisc.info","name",_loc7_.name);
            _localization.registerParameter("songdisc.info","author",_loc7_.creator);
            param2 = _localization.getLocalization("songdisc.info");
         }
         else if(param3)
         {
            if(_waitingSongInfo.length > 0)
            {
               _waitingSongInfo.pop();
               _waitingSongInfo.pop();
               _waitingSongInfo.pop();
            }
            _waitingSongInfo.push(param4);
            _waitingSongInfo.push(param1);
            _waitingSongInfo.push(param5);
            _soundManager.musicController.requestSongInfoWithoutSamples(_loc6_.extra);
         }
         return param2;
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter",String(3 - var_323.currentCount));
         if(var_323.currentCount == 3)
         {
            var_23.confirmCountdownReady();
            var_323.reset();
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc8_:Boolean = false;
         var _loc6_:GroupItem = null;
         var _loc7_:* = 0;
         var _loc3_:FurnitureItem = null;
         var _loc4_:String = null;
         var _loc5_:BitmapData = null;
         var _loc2_:class_1741 = null;
         if(_waitingSongInfo.length > 0)
         {
            _loc8_ = Boolean(_waitingSongInfo.pop());
            _loc6_ = _waitingSongInfo.pop();
            _loc7_ = uint(_waitingSongInfo.pop());
            _loc3_ = _loc6_.peek();
            if(_loc3_.extra == param1.id)
            {
               if(_loc8_ && var_23.ownUserItems.getWithIndex(_loc7_) == _loc6_ || !_loc8_ && var_23.otherUserItems.getWithIndex(_loc7_) == _loc6_)
               {
                  _loc4_ = getTraxSongFurniName(_loc6_,"",false);
                  _loc5_ = var_23.getItemImage(_loc3_);
                  _loc2_ = _loc8_ ? getOwnUsersItemGrid().getGridItemAt(_loc7_) : getOtherUsersItemGrid().getGridItemAt(_loc7_);
                  var_578.updateContent(_loc2_ as class_1812,_loc4_,_loc5_);
               }
            }
            else
            {
               _waitingSongInfo.push(_loc7_);
               _waitingSongInfo.push(_loc6_);
               _waitingSongInfo.push(_loc8_);
            }
         }
      }
      
      private function get silverFeeContainer() : class_1812
      {
         return var_82.findChildByName("silver_container") as class_1812;
      }
      
      private function get yourSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("your_silver") as ITextWindow;
      }
      
      private function get otherSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("other_silver") as ITextWindow;
      }
      
      private function get silverProgress() : class_1899
      {
         return silverFeeContainer.findChildByName("silver_progress_html") as class_1899;
      }
      
      private function get feeMinusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_minus_button") as IIconButtonWindow;
      }
      
      private function get feePlusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_plus_button") as IIconButtonWindow;
      }
      
      private function get silverFeeInfoText() : ITextWindow
      {
         return silverFeeContainer.findChildByName("silver_fee_info_text") as ITextWindow;
      }
   }
}

