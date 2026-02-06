package com.sulake.habbo.inventory.trading
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.SilverFeeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemsToTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import package_156.RemoveNftFromTradeComposer;
   import package_156.AddNftToTradeComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverSetMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   
   public class TradingModel implements IInventoryModel, class_1829
   {
      
      public static const MAX_ITEMS_TO_TRADE:uint = 9;
      
      public static const TRADING_STATE_READY:uint = 0;
      
      public static const TRADING_STATE_RUNNING:uint = 1;
      
      public static const TRADING_STATE_COUNTDOWN:uint = 2;
      
      public static const TRADING_STATE_CONFIRMING:uint = 3;
      
      public static const TRADING_STATE_CONFIRMED:uint = 4;
      
      public static const TRADING_STATE_COMPLETED:uint = 5;
      
      public static const TRADING_STATE_CANCELLED:uint = 6;
      
      private var _inventory:HabboInventory;
      
      private var var_909:class_40;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:class_57;
      
      private var _localization:class_27;
      
      private var _soundManager:class_544;
      
      private var var_73:TradingView;
      
      private var _notifications:class_536;
      
      private var _disposed:Boolean = false;
      
      private var var_983:Boolean = false;
      
      private var var_61:uint = 0;
      
      private var var_1406:int = -1;
      
      private var _ownUserName:String = "";
      
      private var _ownUserItems:class_55;
      
      private var _ownUserNumItems:int = 0;
      
      private var var_1753:int = 0;
      
      private var _ownUserNftItems:class_55;
      
      private var _ownUserNumNftItems:int = 0;
      
      private var var_863:Boolean = false;
      
      private var var_4895:Boolean = false;
      
      private var var_2329:int = -1;
      
      private var _otherUserName:String = "";
      
      private var _otherUserItems:class_55;
      
      private var _otherUserNumItems:int = 0;
      
      private var var_1524:int = 0;
      
      private var _otherUserNftItems:class_55;
      
      private var _otherUserNumNftItems:int = 0;
      
      private var var_1088:Boolean = false;
      
      private var var_3185:Boolean = false;
      
      private var var_2262:int = 0;
      
      private var var_2660:int = 0;
      
      private var var_2337:int = 0;
      
      public function TradingModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:class_27, param7:class_544, param8:class_536)
      {
         super();
         _inventory = param1;
         _communication = param3;
         var_909 = param4;
         _roomEngine = param5;
         _localization = param6;
         _soundManager = param7;
         var_73 = new TradingView(this,param2,param4,param5,param6,param7);
         _notifications = param8;
      }
      
      public static function getGuildFurniType(param1:int, param2:IStuffData) : String
      {
         var _loc5_:int = 0;
         var _loc4_:String = param1.toString();
         var _loc3_:StringArrayStuffData = param2 as StringArrayStuffData;
         if(!_loc3_)
         {
            return _loc4_;
         }
         _loc5_ = 1;
         while(_loc5_ < 5)
         {
            _loc4_ += "," + _loc3_.getValue(_loc5_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function get running() : Boolean
      {
         return var_61 != 0;
      }
      
      public function get state() : uint
      {
         return var_61;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get ownUserId() : int
      {
         return var_1406;
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserItems() : class_55
      {
         return _ownUserItems;
      }
      
      public function get ownUserAccepts() : Boolean
      {
         return var_863;
      }
      
      public function get ownUserCanTrade() : Boolean
      {
         return var_4895;
      }
      
      public function get otherUserId() : int
      {
         return var_2329;
      }
      
      public function get otherUserName() : String
      {
         return _otherUserName;
      }
      
      public function get otherUserItems() : class_55
      {
         return _otherUserItems;
      }
      
      public function get otherUserAccepts() : Boolean
      {
         return var_1088;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return var_3185;
      }
      
      public function get ownUserNftItems() : class_55
      {
         return _ownUserNftItems;
      }
      
      public function get ownUserNumNftItems() : int
      {
         return _ownUserNumNftItems;
      }
      
      public function get otherUserNftItems() : class_55
      {
         return _otherUserNftItems;
      }
      
      public function get otherUserNumNftItems() : int
      {
         return _otherUserNumNftItems;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_73 && !var_73.disposed)
            {
               var_73.dispose();
               var_73 = null;
            }
            _inventory = null;
            _communication = null;
            var_909 = null;
            _roomEngine = null;
            _localization = null;
            _disposed = true;
         }
      }
      
      public function startTrading(param1:int, param2:String, param3:Boolean, param4:int, param5:String, param6:Boolean) : void
      {
         var_1406 = param1;
         _ownUserName = param2;
         _ownUserItems = new class_55();
         _ownUserNftItems = new class_55();
         var_863 = false;
         var_4895 = param3;
         var_2329 = param4;
         _otherUserName = param5;
         _otherUserItems = new class_55();
         _otherUserNftItems = new class_55();
         var_1088 = false;
         var_3185 = param6;
         var_2262 = 0;
         var_2660 = 0;
         var_2337 = 0;
         _ownUserNumNftItems = 0;
         _ownUserNumItems = 0;
         var_1753 = 0;
         _otherUserNumNftItems = 0;
         _otherUserNumItems = 0;
         var_1524 = 0;
         var_983 = true;
         state = 1;
         var_73.setup(param1,param3,param4,param6);
         var_73.updateItemList(var_1406);
         var_73.updateItemList(var_2329);
         var_73.updateUserInterface();
         var_73.clearItemLists();
         _inventory.toggleInventoryPage("furni");
         _inventory.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_TRADING"));
      }
      
      public function close() : void
      {
         if(var_983)
         {
            if(var_61 != 0 && var_61 != 5)
            {
               requestCancelTrading();
               state = 6;
            }
            state = 0;
            _inventory.toggleInventorySubPage("empty");
            var_983 = false;
         }
         var_73.setMinimized(false);
      }
      
      public function isConfirmingWeb3Trade() : Boolean
      {
         return isWeb3Trade() && var_61 == 4;
      }
      
      public function isWeb3Trade() : Boolean
      {
         return requiredSilverFee > 0 || (otherUserNftItems.length > 0 || ownUserNftItems.length > 0);
      }
      
      public function categorySwitch(param1:String) : void
      {
         var_73.setMinimized(param1 != "furni" && param1 != "collectibles");
         _inventory.updateSubView();
      }
      
      public function set state(param1:uint) : void
      {
         class_21.log("OLD STATE: " + var_61 + " NEW STATE: " + param1 + " OWN: " + var_863 + " OTHER: " + var_1088);
         if(var_61 == param1)
         {
            return;
         }
         switch(int(var_61))
         {
            case 0:
               if(param1 == 1 || param1 == 5)
               {
                  var_61 = param1;
                  _inventory.onTradeActiveChanged();
                  var _loc2_:Boolean = true;
               }
               break;
            case 1:
               if(param1 == 2)
               {
                  var_61 = param1;
                  _loc2_ = true;
                  startConfirmCountdown();
                  break;
               }
               if(param1 == 6)
               {
                  var_61 = param1;
                  var_73.setMinimized(false);
                  _loc2_ = true;
               }
               break;
            case 2:
               if(param1 == 3)
               {
                  var_61 = param1;
                  _loc2_ = true;
                  break;
               }
               if(param1 == 6)
               {
                  var_61 = param1;
                  var_73.setMinimized(false);
                  _loc2_ = true;
                  break;
               }
               if(param1 == 1)
               {
                  var_61 = param1;
                  _loc2_ = true;
                  cancelConfirmCountdown();
               }
               break;
            case 3:
               if(param1 == 4)
               {
                  var_61 = param1;
                  _loc2_ = true;
                  break;
               }
               if(param1 == 5)
               {
                  var_61 = param1;
                  _loc2_ = true;
                  close();
                  break;
               }
               if(param1 == 6)
               {
                  var_61 = param1;
                  var_73.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 4:
               if(param1 == 5)
               {
                  var_61 = param1;
                  var_73.setMinimized(false);
                  _loc2_ = true;
                  close();
                  break;
               }
               if(param1 == 6)
               {
                  var_61 = param1;
                  var_73.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 5:
               if(param1 == 0)
               {
                  var_61 = param1;
                  _inventory.onTradeActiveChanged(true);
                  _loc2_ = true;
               }
               break;
            case 6:
               if(param1 == 0)
               {
                  var_61 = param1;
                  _inventory.onTradeActiveChanged();
                  _loc2_ = true;
                  break;
               }
               if(param1 == 1)
               {
                  var_61 = param1;
                  _loc2_ = true;
               }
               break;
            default:
               throw new Error("Unknown trading progress state: \"" + var_61 + "\"");
         }
         throw new Error("Error assigning trading process status! States does not match: (from) " + var_61 + " (to) " + param1);
      }
      
      public function getFurniInventoryModel() : FurniModel
      {
         return _inventory.furniModel;
      }
      
      public function getInventory() : HabboInventory
      {
         return _inventory;
      }
      
      public function updateItemGroupMaps(param1:TradingItemListEvent, param2:class_55, param3:class_55) : void
      {
         if(_inventory == null)
         {
            return;
         }
         if(_ownUserItems != null)
         {
            _ownUserItems.dispose();
         }
         if(_otherUserItems != null)
         {
            _otherUserItems.dispose();
         }
         if(param1.firstUserID == var_1406)
         {
            _ownUserItems = param2;
            _ownUserNumItems = param1.firstUserNumItems;
            var_1753 = param1.firstUserNumCredits;
            _otherUserItems = param3;
            _otherUserNumItems = param1.secondUserNumItems;
            var_1524 = param1.secondUserNumCredits;
         }
         else
         {
            _ownUserItems = param3;
            _ownUserNumItems = param1.secondUserNumItems;
            var_1753 = param1.secondUserNumCredits;
            _otherUserItems = param2;
            _otherUserNumItems = param1.firstUserNumItems;
            var_1524 = param1.firstUserNumCredits;
         }
         var_863 = false;
         var_1088 = false;
         var_73.updateItemList(var_1406);
         var_73.updateItemList(var_2329);
         var_73.updateUserInterface();
         var _loc4_:FurniModel = _inventory.furniModel;
         if(_loc4_ != null)
         {
            _loc4_.updateItemLocks();
         }
      }
      
      public function updateNftItems(param1:class_55, param2:class_55, param3:Number, param4:Number) : *
      {
         if(_inventory == null)
         {
            return;
         }
         if(_ownUserNftItems != null)
         {
            _ownUserNftItems.dispose();
         }
         if(_otherUserNftItems != null)
         {
            _otherUserNftItems.dispose();
         }
         var_863 = false;
         var_1088 = false;
         _ownUserNftItems = param1;
         _otherUserNftItems = param2;
         _ownUserNumNftItems = param3;
         _otherUserNumNftItems = param4;
         var_73.updateItemList(var_1406);
         var_73.updateItemList(var_2329);
         var_73.updateUserInterface();
         var _loc5_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc5_ != null)
         {
            _loc5_.updateItemLocks();
         }
      }
      
      public function getOwnItemIdsInTrade() : Array
      {
         var _loc5_:GroupItem = null;
         var _loc2_:class_1875 = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         if(_ownUserItems == null || _ownUserItems.disposed)
         {
            return _loc1_;
         }
         _loc3_ = 0;
         while(_loc3_ < _ownUserItems.length)
         {
            _loc5_ = _ownUserItems.getWithIndex(_loc3_) as GroupItem;
            if(_loc5_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc5_.getTotalCount())
               {
                  _loc2_ = _loc5_.getAt(_loc4_);
                  if(_loc2_ != null)
                  {
                     _loc1_.push(_loc2_.ref);
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get ownUserNumItems() : int
      {
         return _ownUserNumItems;
      }
      
      public function get ownHasAnyOffer() : Boolean
      {
         return _ownUserItems.length > 0 || _ownUserNftItems.length > 0;
      }
      
      public function get ownUserNumItemsTotal() : int
      {
         return _ownUserNumItems + _ownUserNumNftItems;
      }
      
      public function get ownUserNumCredits() : int
      {
         return var_1753;
      }
      
      public function get otherUserNumItems() : int
      {
         return _otherUserNumItems;
      }
      
      public function get otherHasAnyOffer() : Boolean
      {
         return _otherUserItems.length > 0 || _otherUserNftItems.length > 0;
      }
      
      public function get otherUserNumItemsTotal() : int
      {
         return _otherUserNumItems + _otherUserNumNftItems;
      }
      
      public function get otherUserNumCredits() : int
      {
         return var_1524;
      }
      
      public function getWindowContainer() : class_1812
      {
         return var_73.getWindowContainer();
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         if(var_983)
         {
            if(var_61 != 0)
            {
               requestCancelTrading();
            }
         }
      }
      
      public function closingInventoryView() : void
      {
         if(var_983)
         {
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.minimize_web3"),"info","icon_curator_stamp_large_png");
            }
            else
            {
               close();
            }
         }
      }
      
      public function startConfirmCountdown() : void
      {
         var_73.startConfirmCountdown();
      }
      
      public function cancelConfirmCountdown() : void
      {
         var_73.cancelConfirmCountdown();
      }
      
      public function confirmCountdownReady() : void
      {
         if(var_61 == 2)
         {
            state = 3;
         }
      }
      
      public function getItemImage(param1:FurnitureItem) : BitmapData
      {
         var _loc2_:class_2198 = null;
         if(!param1.isWallItem)
         {
            _loc2_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(180,0,0),64,this,0,String(param1.extra),-1,-1,param1.stuffData);
         }
         else
         {
            _loc2_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(180,0,0),64,this,0,param1.stuffData.getLegacyString());
         }
         return _loc2_.data as BitmapData;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var_73.updateItemImage(param1,param2);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function handleMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:TradingCloseEvent = null;
         var _loc4_:TradeSilverSetMessageEvent = null;
         var _loc3_:TradeSilverSetMessageEventParser = null;
         var _loc5_:TradeSilverFeeMessageEvent = null;
         if(param1 is TradeOpenFailedEvent)
         {
            class_21.log("TRADING::TradingOpenFailedEvent");
            if(TradeOpenFailedEvent(param1).getParser().reason == 7 || TradeOpenFailedEvent(param1).getParser().reason == 8)
            {
               var_73.alertPopup(2);
            }
            else
            {
               var_73.alertTradeOpenFailed(TradeOpenFailedEvent(param1));
            }
         }
         else if(param1 is TradingAcceptEvent)
         {
            class_21.log("TRADING::TradingAcceptEvent");
            if(TradingAcceptEvent(param1).userID == var_1406)
            {
               var_863 = TradingAcceptEvent(param1).userAccepts != 0;
            }
            else
            {
               var_1088 = TradingAcceptEvent(param1).userAccepts != 0;
            }
            var_73.updateUserInterface();
         }
         else if(param1 is TradingConfirmationEvent)
         {
            class_21.log("TRADING::TradingConfirmationEvent");
            state = 2;
         }
         else if(param1 is TradingCompletedEvent)
         {
            class_21.log("TRADING::TradingCompletedEvent");
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.done_messsage"),"info","icon_curator_stamp_large_png");
            }
            state = 5;
         }
         else if(param1 is TradingCloseEvent)
         {
            class_21.log("TRADING::TradingCloseEvent");
            if(!var_983)
            {
               class_21.log("Received TradingCloseEvent, but trading already stopped!!!");
               return;
            }
            _loc2_ = param1 as TradingCloseEvent;
            if(_loc2_.getParser().reason == 1)
            {
               if(_inventory.getBoolean("trading.commiterror.enabled"))
               {
                  var_73.windowManager.simpleAlert("${inventory.trading.notification.title}","${inventory.trading.notification.commiterror.caption}","${inventory.trading.notification.commiterror.info}");
               }
            }
            else if(_loc2_.getParser().userID != var_1406)
            {
               var_73.alertPopup(1);
            }
            close();
         }
         else if(param1 is TradingNotOpenEvent)
         {
            class_21.log("TRADING::TradingNotOpenEvent");
         }
         else if(param1 is TradingOtherNotAllowedEvent)
         {
            var_73.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
         }
         else if(param1 is TradingYouAreNotAllowedEvent)
         {
            var_73.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
         }
         else if(param1 is TradeSilverSetMessageEvent)
         {
            _loc4_ = param1 as TradeSilverSetMessageEvent;
            _loc3_ = _loc4_.getParser();
            var_2660 = _loc3_.playerSilver;
            var_2337 = _loc3_.otherPlayerSilver;
            var_73.updateUserInterface();
         }
         else if(param1 is TradeSilverFeeMessageEvent)
         {
            _loc5_ = param1 as TradeSilverFeeMessageEvent;
            var_2262 = _loc5_.getParser().silverFee;
            var_73.updateUserInterface();
         }
         else
         {
            class_21.log("TRADING/Unknown message event: " + param1);
         }
      }
      
      public function tradeFeeReached() : Boolean
      {
         return var_2660 + var_2337 >= var_2262;
      }
      
      public function requestFurniViewOpen() : void
      {
         _inventory.toggleInventoryPage("furni");
      }
      
      public function requestOpenTrading(param1:int) : void
      {
         _communication.connection.send(new OpenTradingComposer(param1));
      }
      
      public function requestAddItemsToTrading(param1:Vector.<int>, param2:Boolean, param3:int, param4:int, param5:Boolean, param6:IStuffData) : void
      {
         var _loc8_:* = undefined;
         if(!param5 && param1.length > 0)
         {
            _communication.connection.send(new AddItemToTradeComposer(param1.pop()));
         }
         else
         {
            _loc8_ = new Vector.<int>();
            for each(var _loc7_ in param1)
            {
               if(canAddItemToTrade(param2,param3,param4,param5,param6))
               {
                  _loc8_.push(_loc7_);
               }
            }
            if(_loc8_.length > 0)
            {
               if(_loc8_.length == 1)
               {
                  _communication.connection.send(new AddItemToTradeComposer(_loc8_.pop()));
               }
               else
               {
                  _communication.connection.send(new AddItemsToTradeComposer(_loc8_));
               }
            }
         }
      }
      
      public function requestAddNftsToTrading(param1:Vector.<Number>) : void
      {
         var _loc3_:Vector.<int> = new Vector.<int>();
         for each(var _loc2_ in param1)
         {
            _loc3_.push(int(_loc2_));
         }
         _communication.connection.send(new AddNftToTradeComposer(_loc3_));
      }
      
      public function canAddItemToTrade(param1:Boolean, param2:int, param3:int, param4:Boolean, param5:IStuffData) : Boolean
      {
         var _loc6_:String = null;
         if(var_863)
         {
            return false;
         }
         if(_ownUserItems == null)
         {
            return false;
         }
         if(_ownUserItems.length < 9)
         {
            return true;
         }
         if(!param4)
         {
            return false;
         }
         _loc6_ = String(param2);
         if(param3 == 6)
         {
            _loc6_ = String(param2) + "poster" + param5.getLegacyString();
         }
         else if(param3 == 17)
         {
            _loc6_ = getGuildFurniType(param2,param5);
         }
         else
         {
            _loc6_ = (param1 ? "I" : "S") + _loc6_;
         }
         return _ownUserItems.getValue(_loc6_) != null;
      }
      
      public function requestRemoveItemFromTrading(param1:int) : void
      {
         var _loc3_:class_1875 = null;
         if(var_863)
         {
            return;
         }
         var _loc2_:int = int(ownUserItems.length);
         if(param1 >= _loc2_)
         {
            var _loc5_:CollectibleGroupedItem = ownUserNftItems.getWithIndex(param1 - _loc2_);
            if(_loc5_ != null)
            {
               var _loc4_:Vector.<Number> = null.pop(1);
               if(_loc4_ != null && undefined.length == 1)
               {
                  _communication.connection.send(new RemoveNftFromTradeComposer(undefined[0]));
               }
            }
            return;
         }
         var _loc6_:GroupItem = ownUserItems.getWithIndex(param1);
         if(_loc6_)
         {
            _loc3_ = _loc6_.peek();
            if(_loc3_)
            {
               _communication.connection.send(new RemoveItemFromTradeComposer(_loc3_.id));
            }
         }
      }
      
      public function requestAcceptTrading() : void
      {
         _communication.connection.send(new AcceptTradingComposer());
      }
      
      public function requestUnacceptTrading() : void
      {
         _communication.connection.send(new UnacceptTradingComposer());
      }
      
      public function requestConfirmAcceptTrading() : void
      {
         state = 4;
         _communication.connection.send(new ConfirmAcceptTradingComposer());
      }
      
      public function requestConfirmDeclineTrading() : void
      {
         _communication.connection.send(new ConfirmDeclineTradingComposer());
      }
      
      public function requestCancelTrading() : void
      {
         if(!isConfirmingWeb3Trade())
         {
            _communication.connection.send(new CloseTradingComposer());
         }
      }
      
      public function addSilverFee(param1:Boolean) : void
      {
         _communication.connection.send(new SilverFeeMessageComposer(param1));
      }
      
      public function isCreditFurniPresent() : Boolean
      {
         return var_1753 > 0 || var_1524 > 0;
      }
      
      private function get citizenshipTalentTrackEnabled() : Boolean
      {
         return _inventory.getBoolean("talent.track.citizenship.enabled");
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         class_21.log("NOT SUPPORTED: TRADING VIEW SELECT BY ID");
      }
      
      public function get requiredSilverFee() : int
      {
         return var_2262;
      }
      
      public function get playerSilver() : int
      {
         return var_2660;
      }
      
      public function get otherPlayerSilver() : int
      {
         return var_2337;
      }
   }
}

