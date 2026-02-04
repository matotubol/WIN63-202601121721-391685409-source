package com.sulake.habbo.catalog.recycler
{
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.window.class_38;
   import flash.utils.getTimer;
   
   public class RecyclerLogic implements IRecycler
   {
      
      private static const STATUS_OFF:int = 0;
      
      private static const STATUS_READY:int = 1;
      
      private static const STATUS_WAITING_FOR_SERVER:int = 2;
      
      private var _localStatus:int = 0;
      
      private var _systemStatus:int;
      
      private var var_3792:int;
      
      private var var_162:Array = [];
      
      private var _catalog:HabboCatalog;
      
      private var _windowManager:class_38;
      
      private var var_18:IRecyclerVisualization;
      
      private var var_1475:Array;
      
      private var var_1738:Function;
      
      private var var_1678:int;
      
      public function RecyclerLogic(param1:HabboCatalog, param2:class_38)
      {
         super();
         _catalog = param1;
         _windowManager = param2;
         var_1678 = param1.getInteger("recycler.number_of_slots",5);
      }
      
      private function get statusActive() : Boolean
      {
         return _localStatus != 0;
      }
      
      private function get systemActive() : Boolean
      {
         return _systemStatus != 2;
      }
      
      private function get ready() : Boolean
      {
         return active && _localStatus == 1;
      }
      
      public function get active() : Boolean
      {
         return statusActive && systemActive;
      }
      
      public function get numberOfSlots() : int
      {
         return var_1678;
      }
      
      public function dispose() : void
      {
         var_162 = null;
         _catalog = null;
         _windowManager = null;
         var_1738 = null;
      }
      
      public function init(param1:IRecyclerVisualization = null) : void
      {
         _localStatus = 2;
         var_162 = new Array(var_1678);
         if(param1 == null)
         {
            return;
         }
         var_18 = param1;
         _catalog.getRecyclerStatus();
      }
      
      public function activate() : void
      {
         if(systemActive)
         {
            _localStatus = 1;
         }
      }
      
      public function cancel() : void
      {
         _catalog.setupInventoryForRecycler(false);
         releaseAllSlots();
         _localStatus = 0;
      }
      
      public function releaseAllSlots() : void
      {
         var _loc1_:int = 0;
         if(!ready)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < var_1678)
         {
            if(var_162[_loc1_] != null)
            {
               _catalog.returnInventoryFurniFromRecycler(var_162[_loc1_].id);
               var_162[_loc1_] = null;
            }
            _loc1_ += 1;
         }
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function empty() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_1678)
         {
            releaseSlot(_loc1_);
            _loc1_++;
         }
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function secondsToWait() : int
      {
         if(_systemStatus == 3)
         {
            return Math.max(0,int(Math.ceil((var_3792 - getTimer()) / 1000)));
         }
         return 0;
      }
      
      public function setNextRecycleAllowedTimestamp(param1:int) : void
      {
         var_3792 = param1;
         if(var_3792 > getTimer())
         {
            _systemStatus = 3;
         }
      }
      
      public function setSystemStatus(param1:int, param2:int) : void
      {
         _systemStatus = param1;
         setNextRecycleAllowedTimestamp(getTimer() + param2 * 1000);
         if(!systemActive)
         {
            if(var_18 == null || var_18.disposed)
            {
               return;
            }
            var_18.updateUI();
            return;
         }
         _localStatus = 1;
         if(var_18 == null || var_18.disposed)
         {
            return;
         }
         var_18.updateUI();
         _catalog.setupInventoryForRecycler(_systemStatus != 2);
         verifyRoomSessionStatus();
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function setFinished(param1:int, param2:int) : void
      {
         var status:int = param1;
         var prizeId:int = param2;
         if(!statusActive)
         {
            return;
         }
         _localStatus = 1;
         if(!systemActive)
         {
            return;
         }
         switch(status - 1)
         {
            case 0:
               if(var_18 != null)
               {
                  var_18.updateUI();
               }
               break;
            case 1:
               class_21.log("* Recycler finished with FAILURE");
               _windowManager.alert("${generic.alert.title}","${recycler.info.closed}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               if(var_18 != null)
               {
                  var_18.updateUI();
               }
         }
         releaseAllSlots();
      }
      
      public function getSlotContent(param1:int) : FurniSlotItem
      {
         if(var_162 == null)
         {
            return null;
         }
         if(param1 >= var_162.length)
         {
            return null;
         }
         return var_162[param1];
      }
      
      public function placeObjectAtSlot(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean = false) : void
      {
         var oldObjectData:FurniSlotItem;
         var newSlotId:int;
         var itemId:int;
         var slotId:int = param1;
         var id:int = param2;
         var category:int = param3;
         var typeId:int = param4;
         var xxxExtra:String = param5;
         var findNewSlotId:Boolean = param6;
         if(!ready)
         {
            return;
         }
         if(!findNewSlotId)
         {
            oldObjectData = var_162[slotId];
            if(oldObjectData != null)
            {
               releaseSlot(slotId);
            }
         }
         else if(var_162.length > 0)
         {
            oldObjectData = var_162[0];
            newSlotId = 0;
            while(oldObjectData != null && newSlotId < var_1678)
            {
               oldObjectData = var_162[newSlotId];
               if(oldObjectData != null)
               {
                  newSlotId = newSlotId + 1;
               }
            }
            if(oldObjectData != null)
            {
               return;
            }
            slotId = newSlotId;
         }
         itemId = _catalog.requestInventoryFurniToRecycler();
         if(itemId == 0)
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.non.recyclable}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
            return;
         }
         var_162[slotId] = new FurniSlotItem(itemId,category,typeId,xxxExtra);
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function releaseSlot(param1:int) : void
      {
         if(!ready)
         {
            return;
         }
         if(var_162[param1] == null)
         {
            return;
         }
         if(!_catalog.returnInventoryFurniFromRecycler(var_162[param1].id))
         {
            return;
         }
         var_162[param1] = null;
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function executeRecycler() : void
      {
         if(!isReadyToRecycle())
         {
            return;
         }
         _localStatus = 2;
         updateRecyclerButton();
         var _loc3_:Array = [];
         var _loc1_:int = 0;
         if(0 >= var_162.length)
         {
            _catalog.sendRecycleItems(_loc3_);
            var_18.updateUI();
            return;
         }
         var _loc2_:FurniSlotItem = var_162[0];
      }
      
      public function isReadyToRecycle() : Boolean
      {
         if(!ready || !_catalog.privateRoomSessionActive)
         {
            return false;
         }
         if(isTradingActive())
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.trading}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
            return false;
         }
         return isPoolFull();
      }
      
      public function get ducketCost() : int
      {
         return _catalog.getInteger("recycler.ducket_cost",0);
      }
      
      public function hasEnoughDuckets() : Boolean
      {
         return _catalog.getPurse().getActivityPointsForType(0) >= ducketCost;
      }
      
      public function get timeout() : int
      {
         return _catalog.getInteger("recycler.timeout_seconds",10);
      }
      
      public function setRoomSessionActive(param1:Boolean) : void
      {
         if(param1 == false)
         {
            empty();
            verifyRoomSessionStatus();
         }
         updateRecyclerButton();
      }
      
      private function verifyRoomSessionStatus() : void
      {
         if(!_catalog.privateRoomSessionActive && ready)
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.privateroom}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
         }
      }
      
      private function updateRecyclerSlots() : void
      {
         if(var_18 == null || !statusActive)
         {
            return;
         }
         var_18.updateSlots();
      }
      
      private function updateRecyclerButton() : void
      {
         if(var_18 == null || !statusActive)
         {
            return;
         }
         var_18.updateRecycleButton();
      }
      
      private function isPoolFull() : Boolean
      {
         var _loc1_:int = 0;
         if(var_162 == null)
         {
            return false;
         }
         if(var_162.length < var_1678)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < var_162.length)
         {
            if(var_162[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function isTradingActive() : Boolean
      {
         return _catalog.tradingActive;
      }
      
      public function storePrizeTable(param1:Array) : void
      {
         var_1475 = [];
         var _loc3_:int = 0;
         while(0 < param1.length)
         {
            var _loc2_:PrizeLevelContainer = new PrizeLevelContainer(param1[0],_catalog);
            var_1475.push(null);
            _loc3_++;
         }
         if(var_1738 != null)
         {
            var_1738(var_1475);
            var_1738 = null;
         }
      }
      
      public function getPrizeTable(param1:Function) : Array
      {
         if(var_1475 == null)
         {
            var_1738 = param1;
            _catalog.getRecyclerPrizes();
            return null;
         }
         return var_1475;
      }
      
      public function get recyclerDisabled() : Boolean
      {
         return !systemActive;
      }
   }
}

