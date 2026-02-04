package com.sulake.habbo.inventory.recycler
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.class_38;
   
   public class RecyclerModel implements IInventoryModel
   {
      
      public static const STATE_READY:uint = 0;
      
      public static const STATE_ACTIVE:uint = 1;
      
      private var _inventory:HabboInventory;
      
      private var var_909:class_40;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:class_57;
      
      private var _localization:class_27;
      
      private var _disposed:Boolean = false;
      
      private var var_983:Boolean = false;
      
      private var var_61:uint = 0;
      
      private var _itemList:class_55;
      
      public function RecyclerModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:class_27)
      {
         super();
         _inventory = param1;
         _communication = param3;
         var_909 = param4;
         _roomEngine = param5;
         _localization = param6;
      }
      
      public function get running() : Boolean
      {
         return var_61 == 1;
      }
      
      public function get state() : uint
      {
         return var_61;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set state(param1:uint) : void
      {
         var_61 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _inventory = null;
            _communication = null;
            var_909 = null;
            _roomEngine = null;
            _localization = null;
            _disposed = true;
         }
         stopRecycler();
      }
      
      public function startRecycler() : void
      {
         if(_inventory == null || _inventory.furniModel == null)
         {
            return;
         }
         var_61 = 1;
         _itemList = new class_55();
         _inventory.furniModel.showRecyclable(true);
      }
      
      public function stopRecycler() : void
      {
         if(_itemList == null || _inventory == null || _inventory.furniModel == null)
         {
            return;
         }
         var_61 = 0;
         _inventory.furniModel.showRecyclable(false);
         var _loc2_:int = 0;
         while(0 < _itemList.length)
         {
            var _loc1_:int = _itemList.getKey(0);
            _inventory.furniModel.removeLockFrom(0);
            _loc2_++;
         }
         _itemList = null;
      }
      
      public function lockSelectedFurni() : int
      {
         if(_itemList == null || _inventory == null || _inventory.furniModel == null)
         {
            return 0;
         }
         var _loc1_:class_1875 = _inventory.furniModel.requestSelectedFurniToRecycler();
         if(_loc1_ == null)
         {
            return 0;
         }
         if(_itemList.getValue(_loc1_.id) == null)
         {
            _itemList.add(_loc1_.id,_loc1_);
         }
         return _loc1_.id;
      }
      
      public function releaseFurni(param1:int) : Boolean
      {
         if(_itemList == null)
         {
            return true;
         }
         var _loc2_:class_1875 = _itemList.getValue(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return false;
         }
         _loc3_.removeLockFrom(param1);
         _itemList.remove(param1);
         return true;
      }
      
      public function getOwnItemsInRecycler() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(_itemList == null)
         {
            return [];
         }
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_.push(_itemList.getKey(_loc2_));
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function getWindowContainer() : class_1812
      {
         return null;
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         class_21.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
      }
   }
}

