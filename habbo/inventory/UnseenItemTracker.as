package com.sulake.habbo.inventory
{
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.enum.class_1797;
   import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import package_114.class_2416;
   import package_114.class_2905;
   import package_26.class_2903;
   import package_46.class_3565;
   
   public class UnseenItemTracker implements class_1954
   {
      
      private var _communication:class_57;
      
      private var _inventory:HabboInventory;
      
      private var _unseenItems:Dictionary;
      
      private var name_1:IEventDispatcher;
      
      public function UnseenItemTracker(param1:class_57, param2:IEventDispatcher, param3:HabboInventory)
      {
         super();
         _communication = param1;
         _inventory = param3;
         name_1 = param2;
         _unseenItems = new Dictionary();
         _communication.addHabboConnectionMessageEvent(new class_2903(onUnseenItems));
      }
      
      public function dispose() : void
      {
         _communication = null;
         _unseenItems = null;
      }
      
      public function resetCategory(param1:int) : Boolean
      {
         if(getCount(param1) == 0)
         {
            return false;
         }
         delete _unseenItems[param1];
         sendResetCategoryMessage(param1);
         sendUpdateEvent();
         return true;
      }
      
      public function resetItems(param1:int, param2:Array) : Boolean
      {
         if(getCount(param1) == 0)
         {
            return false;
         }
         var _loc4_:Array = _unseenItems[param1];
         for each(var _loc3_ in param2)
         {
            _loc4_.splice(_loc4_.indexOf(_loc3_),1);
         }
         sendResetItemsMessage(param1,param2);
         sendUpdateEvent();
         return true;
      }
      
      public function resetCategoryIfEmpty(param1:int) : Boolean
      {
         if(getCount(param1) == 0)
         {
            delete _unseenItems[param1];
            sendResetCategoryMessage(param1);
            sendUpdateEvent();
            return true;
         }
         return false;
      }
      
      public function isUnseen(param1:int, param2:int) : Boolean
      {
         if(_unseenItems[param1] != null)
         {
            var _loc3_:Array = _unseenItems[param1];
            return null.indexOf(param2) >= 0;
         }
         return false;
      }
      
      public function removeUnseen(param1:int, param2:int) : Boolean
      {
         if(_unseenItems[param1] != null)
         {
            var _loc3_:Array = _unseenItems[param1];
            var _loc4_:int = int(null.indexOf(param2));
            if(_loc4_ >= 0)
            {
               null.splice(0,1);
               sendUpdateEvent();
               return true;
            }
         }
         return false;
      }
      
      public function getIds(param1:int) : Array
      {
         if(_unseenItems[param1] != null)
         {
            return _unseenItems[param1];
         }
         return [];
      }
      
      public function getCount(param1:int) : int
      {
         if(_unseenItems[param1] != null)
         {
            return (_unseenItems[param1] as Array).length;
         }
         return 0;
      }
      
      private function onUnseenItems(param1:class_2903) : void
      {
         var _loc2_:Boolean = false;
         var _loc5_:Array = null;
         var _loc3_:class_3565 = param1.getParser();
         for each(var _loc4_ in _loc3_.getCategories())
         {
            _loc5_ = _loc3_.getItemsByCategory(_loc4_);
            addItems(_loc4_,_loc5_);
            if(class_1797.INVENTORY_CATEGORIES.indexOf(_loc4_) >= 0)
            {
               _loc2_ = true;
            }
         }
         onUnseenItemsUpdate();
      }
      
      public function setUnseenItem(param1:int, param2:int) : void
      {
         addItems(param1,[param2]);
         onUnseenItemsUpdate();
      }
      
      private function onUnseenItemsUpdate() : void
      {
         if(_inventory.isInitialized)
         {
            _inventory.updateUnseenItemCounts();
            _inventory.furniModel.updateUnseenItemsThumbs();
            _inventory.petsModel.updateView();
            _inventory.botsModel.updateView();
         }
         sendUpdateEvent();
      }
      
      private function sendUpdateEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:HabboUnseenItemsUpdatedEvent = new HabboUnseenItemsUpdatedEvent();
         var _loc3_:Array = class_1797.INVENTORY_CATEGORIES;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = getCount(_loc4_);
            _loc1_.setCategoryCount(_loc4_,_loc2_);
            if(class_1797.INVENTORY_CATEGORIES.indexOf(_loc4_) >= 0)
            {
               _loc1_.inventoryCount += _loc2_;
            }
         }
         name_1.dispatchEvent(_loc1_);
      }
      
      private function addItems(param1:int, param2:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(param2 == null)
         {
            return;
         }
         if(_unseenItems[param1] == null)
         {
            _loc3_ = [];
            _unseenItems[param1] = _loc3_;
         }
         _loc3_ = _unseenItems[param1];
         for each(var _loc5_ in param2)
         {
            _loc4_ = int(_loc3_.indexOf(_loc5_));
            if(_loc4_ == -1)
            {
               _loc3_.push(_loc5_);
            }
         }
      }
      
      private function sendResetCategoryMessage(param1:int) : void
      {
         _communication.connection.send(new class_2905(param1));
      }
      
      private function sendResetItemsMessage(param1:int, param2:Array) : void
      {
         _communication.connection.send(new class_2416(param1,param2));
      }
   }
}

