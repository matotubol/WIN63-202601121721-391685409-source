package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.class_38;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_3317;
   import com.sulake.habbo.communication.messages.outgoing.inventory.bots.GetBotInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceBotMessageComposer;
   
   public class BotsModel implements IInventoryModel
   {
      
      private var var_55:HabboInventory;
      
      private var var_18:BotsView;
      
      private var _assets:class_40;
      
      private var _communication:class_57;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _items:class_55;
      
      private var var_2603:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_4672:Boolean;
      
      public function BotsModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:IHabboCatalog, param7:class_48)
      {
         super();
         var_55 = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         _items = new class_55();
         var_18 = new BotsView(this,param2,param4,param5,param7);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_18)
            {
               var_18.dispose();
               var_18 = null;
            }
            if(_roomEngine)
            {
               if(_roomEngine.events)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
            }
            if(_items)
            {
               _items.dispose();
               _items = null;
            }
            var_55 = null;
            _catalog = null;
            _assets = null;
            _communication = null;
            _disposed = true;
         }
      }
      
      public function get controller() : HabboInventory
      {
         return var_55;
      }
      
      public function isListInitialized() : Boolean
      {
         return var_4672;
      }
      
      public function setListInitialized() : void
      {
         var_4672 = true;
         var_18.updateState();
      }
      
      public function requestInventory() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:IConnection = _communication.connection;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new GetBotInventoryComposer());
      }
      
      public function get items() : class_55
      {
         return _items;
      }
      
      public function addItem(param1:class_3317) : void
      {
         if(_items.add(param1.id,param1))
         {
            var_18.addItem(param1);
         }
         var_18.updateState();
      }
      
      public function updateItems(param1:class_55) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = _items.getKeys();
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               _items.remove(_loc3_);
               var_18.removeItem(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               _items.add(_loc3_,param1.getValue(_loc3_));
               var_18.addItem(param1.getValue(_loc3_));
            }
         }
      }
      
      public function removeItem(param1:int) : void
      {
         _items.remove(param1);
         var_18.removeItem(param1);
         var_18.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "bots" && var_55.isVisible)
         {
            var_55.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BOTS"));
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         return var_18.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(var_18.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:class_3317 = getItemById(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         if(!var_55.roomSession.areBotsAllowed)
         {
            return false;
         }
         if(var_55.roomSession.isRoomOwner)
         {
            _loc4_ = _loc3_.id * -1;
            var_2603 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,4,_loc3_.figure);
            var_55.closeView();
            return var_2603;
         }
         if(!param2)
         {
            _communication.connection.send(new PlaceBotMessageComposer(_loc3_.id,0,0));
         }
         return true;
      }
      
      public function updateView() : void
      {
         if(var_18 == null)
         {
            return;
         }
         var_18.update();
      }
      
      private function getItemById(param1:int) : class_3317
      {
         for each(var _loc2_ in _items)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_2603 && param1.type == "REOE_PLACED")
         {
            var_55.showView();
            var_2603 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_55.roomSession;
      }
      
      public function resetUnseenItems() : void
      {
         var_55.unseenItemTracker.resetCategory(5);
         var_55.updateUnseenItemCounts();
         var_18.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return var_55.unseenItemTracker.isUnseen(5,param1);
      }
      
      public function selectItemById(param1:String) : void
      {
         var_18.selectById(int(param1));
      }
   }
}

