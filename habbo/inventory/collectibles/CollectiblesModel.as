package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.class_38;
   import flash.events.Event;
   import package_111.class_3106;
   import package_156.class_2747;
   
   public class CollectiblesModel implements IInventoryModel
   {
      
      private var var_55:HabboInventory;
      
      private var var_18:CollectiblesView;
      
      private var _assets:class_40;
      
      private var _communication:class_57;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _disposed:Boolean = false;
      
      private var _isLoaded:Boolean;
      
      private var _items:class_55;
      
      private var var_3106:Boolean = false;
      
      private var _selected:CollectibleGroupedItem = null;
      
      public function CollectiblesModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:IHabboCatalog, param7:class_48)
      {
         super();
         var_55 = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _catalog = param6;
         _items = new class_55();
         var_18 = new CollectiblesView(this,param2,param4);
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
         return _isLoaded;
      }
      
      public function setListInitialized() : void
      {
         _isLoaded = true;
         var_18.updateState();
      }
      
      public function onTradeComplete() : void
      {
         _isLoaded = false;
         controller.setInventoryCategoryInit("collectibles",false);
         var_18.updateState();
      }
      
      public function get items() : class_55
      {
         return _items;
      }
      
      public function initCollectibles(param1:class_55) : void
      {
         var _loc6_:int = 0;
         var _loc2_:class_3106 = null;
         var _loc3_:Array = param1.getKeys();
         var _loc7_:Array = _items.getKeys();
         var _loc4_:Vector.<class_3106> = new Vector.<class_3106>();
         var _loc5_:Vector.<class_3106> = new Vector.<class_3106>();
         for each(_loc6_ in _loc7_)
         {
            if(_loc3_.indexOf(_loc6_) == -1)
            {
               _loc2_ = _items.remove(_loc6_);
               if(_loc2_ != null)
               {
                  _loc4_.push(_loc2_);
               }
            }
         }
         for each(_loc6_ in _loc3_)
         {
            if(_loc7_.indexOf(_loc6_) == -1)
            {
               _loc2_ = param1.getValue(_loc6_);
               _items.add(_loc6_,_loc2_);
               _loc5_.push(_loc2_);
            }
         }
         var_18.initCollectibles(_loc5_,_loc4_);
         if(!controller.checkCategoryInitilization("collectibles"))
         {
            controller.setInventoryCategoryInit("collectibles");
            setListInitialized();
         }
      }
      
      public function requestAddTrading(param1:CollectibleGroupedItem, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 < 1 || param2 > param1.unlockedAssetCount)
         {
            return;
         }
         var _loc3_:Vector.<Number> = param1.pop(param2);
         if(_loc3_.length < 1)
         {
            return;
         }
         controller.tradingModel.requestAddNftsToTrading(_loc3_);
      }
      
      public function updateItemLocks() : void
      {
         var _loc5_:CollectibleGroupedItem = null;
         var_18.unlockAll();
         var _loc3_:TradingModel = controller.tradingModel;
         if(_loc3_ == null || !_loc3_.running)
         {
            return;
         }
         var _loc4_:class_55 = _loc3_.ownUserNftItems;
         for each(var _loc1_ in _loc4_.getValues())
         {
            _loc5_ = var_18.findGroupedItem(_loc1_.item,false);
            if(_loc5_ != null)
            {
               for each(var _loc2_ in _loc1_.assetIds)
               {
                  _loc5_.lockAsset(_loc2_);
               }
            }
         }
         var_18.updatePreview();
      }
      
      public function setSelected(param1:CollectibleGroupedItem) : void
      {
         if(param1 == _selected)
         {
            return;
         }
         if(_selected != null)
         {
            _selected.isSelected = false;
            _selected = null;
         }
         if(param1 != null)
         {
            param1.isSelected = true;
            _selected = param1;
         }
         var_18.updatePreview();
      }
      
      public function get selected() : CollectibleGroupedItem
      {
         return _selected;
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "collectibles" && var_55.isVisible)
         {
            var_55.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_COLLECTIBLES"));
            requestNftAssets();
            var_18.updateContainerVisibility();
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
         switch(param1)
         {
            case "trading":
               var_3106 = false;
               if(var_18.isVisible)
               {
                  requestNftAssets();
               }
               break;
            case "empty":
               var_18.unlockAll();
         }
      }
      
      public function requestNftAssets() : void
      {
         if(!var_3106)
         {
            var_3106 = true;
            _communication.connection.send(new class_2747());
         }
      }
      
      public function updateView() : void
      {
         if(var_18 == null)
         {
            return;
         }
      }
      
      private function getItemById(param1:Number) : class_3106
      {
         return _items[param1];
      }
      
      public function getGroupedItemById(param1:Number) : CollectibleGroupedItem
      {
         var _loc2_:class_3106 = getItemById(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return var_18.findGroupedItem(_loc2_);
      }
      
      public function resetUnseenItems() : void
      {
         var_55.unseenItemTracker.resetCategory(7);
         var_55.updateUnseenItemCounts();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return var_55.unseenItemTracker.isUnseen(5,param1);
      }
      
      public function selectItemById(param1:String) : void
      {
      }
   }
}

