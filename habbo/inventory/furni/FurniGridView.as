package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   
   public class FurniGridView
   {
      
      private static const PLACEMENT_ANYWHERE:int = 0;
      
      private static const PLACEMENT_IN_ROOM:int = 1;
      
      private static const PLACEMENT_NOT_IN_ROOM:int = 2;
      
      private var var_608:IItemGridWindow;
      
      private var _items:Vector.<GroupItem>;
      
      private var _showFloorItems:Boolean = true;
      
      private var _showWallItems:Boolean = true;
      
      private var var_3441:int;
      
      private var _showingRentedItems:Boolean = false;
      
      private var var_3630:Boolean = false;
      
      private var var_2023:Boolean = true;
      
      private var _passedItems:Vector.<GroupItem>;
      
      private var var_885:IItemListWindow;
      
      private var var_2434:IRegionWindow;
      
      private var var_4386:int = 200;
      
      private var var_292:int = -1;
      
      private var _currentPageItems:Vector.<GroupItem>;
      
      private var var_168:String = "";
      
      public function FurniGridView(param1:IItemGridWindow, param2:IItemListWindow)
      {
         super();
         var_608 = param1;
         var_608.shouldRebuildGridOnResize = false;
         _items = new Vector.<GroupItem>(0);
         _passedItems = new Vector.<GroupItem>(0);
         var_885 = param2;
         if(var_885)
         {
            var_2434 = var_885.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return var_608.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return _currentPageItems;
      }
      
      private function get pageCount() : int
      {
         return _passedItems.length / var_4386 + 1;
      }
      
      public function dispose() : void
      {
         var_608 = null;
         _items = null;
      }
      
      public function clearGrid() : void
      {
         if(var_608 != null)
         {
            var_608.removeGridItems();
         }
         var_608.destroyGridItems();
      }
      
      public function setFilter(param1:int, param2:String, param3:Boolean, param4:Boolean, param5:String, param6:int, param7:Boolean) : void
      {
         _showFloorItems = param1 == 0 || param1 == 1;
         _showWallItems = param1 == 0 || param1 == 2;
         _showingRentedItems = param3;
         var_3630 = param4;
         var_2023 = param7;
         var_3441 = param6;
         var_168 = param5.toLowerCase();
         update();
      }
      
      public function itemWasUpdated(param1:GroupItem) : void
      {
         if(passFilter(param1))
         {
            update();
         }
      }
      
      public function getFirstThumb() : class_1812
      {
         if(var_608.numGridItems == 0)
         {
            return null;
         }
         return var_608.getGridItemAt(0) as class_1812;
      }
      
      public function setItems(param1:Vector.<GroupItem>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var item:GroupItem;
         var changes:Boolean;
         var i:int;
         var currentItems:Vector.<GroupItem> = new Vector.<GroupItem>(0);
         for each(item in _items)
         {
            if(passFilter(item))
            {
               currentItems.push(item);
            }
         }
         if(!var_3630 && _showingRentedItems)
         {
            currentItems = currentItems.sort(function(param1:GroupItem, param2:GroupItem):Number
            {
               var _loc5_:FurnitureItem = param1.peek();
               var _loc4_:FurnitureItem = param2.peek();
               var _loc3_:int = int(_loc4_.hasRentPeriodStarted) - int(_loc5_.hasRentPeriodStarted);
               return _loc3_ != 0 ? _loc3_ : _loc5_.secondsToExpiration - _loc4_.secondsToExpiration;
            });
         }
         if(currentItems.length == _passedItems.length)
         {
            changes = false;
            i = 0;
            while(i < currentItems.length)
            {
               if(currentItems[i] != _passedItems[i])
               {
                  changes = true;
                  break;
               }
               i = i + 1;
            }
            if(!changes)
            {
               return;
            }
         }
         _passedItems = currentItems;
         changeToPage(var_292,true);
         updatePaging();
      }
      
      private function changeToPage(param1:int, param2:Boolean = false) : void
      {
         if(param1 > -1)
         {
            if(var_292 == param1 && !param2)
            {
               return;
            }
         }
         else
         {
            param1 = 0;
         }
         var_292 = param1;
         if(var_292 >= pageCount)
         {
            var_292 = pageCount - 1;
         }
         var_292 = Math.max(var_292,0);
         _currentPageItems = new Vector.<GroupItem>(0);
         clearGrid();
         var _loc3_:int = var_292 * var_4386;
         var _loc4_:int = _loc3_ + var_4386;
         _loc4_ = Math.min(_loc4_,_passedItems.length);
         var _loc5_:int = _loc3_;
         while(0 < _loc4_)
         {
            var_608.addGridItem(_passedItems[0].window);
            _currentPageItems.push(_passedItems[0]);
            _loc5_++;
         }
      }
      
      private function updatePassedItems(param1:GroupItem) : void
      {
      }
      
      private function updatePaging() : void
      {
         if(!var_885)
         {
            return;
         }
         var _loc1_:int = pageCount;
         var_885.visible = _loc1_ > 1;
         if(var_292 >= _loc1_)
         {
            var_292 = _loc1_ - 1;
         }
         var_292 = Math.max(var_292,0);
         if(pageCount != var_885.numListItems)
         {
            for each(var _loc4_ in var_885)
            {
               _loc4_.removeEventListener("WME_CLICK",onPageEventProc);
            }
            var_885.destroyListItems();
            var _loc3_:int = 0;
            while(0 < _loc1_)
            {
               _loc4_ = var_2434.clone() as IRegionWindow;
               _loc4_.addEventListener("WME_CLICK",onPageEventProc);
               null.addEventListener("WME_OVER",onPageEventProc);
               null.addEventListener("WME_OUT",onPageEventProc);
               null.id = 0;
               null.name = "page_" + 0;
               var_885.addListItem(null);
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(0 < _loc1_)
         {
            _loc4_ = var_885.getListItemAt(0) as IRegionWindow;
            var _loc2_:ITextWindow = _loc4_.findChildByTag("PAGE") as ITextWindow;
            null.caption = (0).toString();
            if(0 == var_292)
            {
               null.underline = true;
               null.textColor = 16711680;
            }
            else
            {
               null.underline = false;
               null.textColor = 0;
            }
            _loc3_++;
         }
      }
      
      private function onPageEventProc(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = param1.window.id;
         var _loc2_:ITextWindow = (param1.target as class_1812).findChildByTag("PAGE") as ITextWindow;
         switch(param1.type)
         {
            case "WME_CLICK":
               changeToPage(_loc3_);
               updatePaging();
               break;
            case "WME_OVER":
               _loc2_.textColor = 16711680;
               break;
            case "WME_OUT":
               if(_loc3_ != var_292)
               {
                  _loc2_.textColor = 0;
               }
         }
      }
      
      private function passFilter(param1:GroupItem) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!_showFloorItems && !param1.isWallItem)
         {
            return false;
         }
         if(!_showWallItems && param1.isWallItem)
         {
            return false;
         }
         if(!var_3630 && _showingRentedItems != param1.isRented)
         {
            return false;
         }
         if(!var_2023 && param1.isNft())
         {
            return false;
         }
         if(var_3441 == 1 && param1.flatId == -1)
         {
            return false;
         }
         if(var_3441 == 2 && param1.flatId > -1)
         {
            return false;
         }
         if(var_168.length > 0)
         {
            _loc2_ = param1.name.toLowerCase();
            _loc3_ = param1.description.toLowerCase();
            if(_loc2_.indexOf(var_168) == -1 && _loc3_.indexOf(var_168) == -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}

