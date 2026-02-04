package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.badges.*;
   
   public class CollectiblesGridView
   {
      
      private var var_18:CollectiblesView;
      
      private var var_608:IItemGridWindow;
      
      private var _items:Vector.<CollectibleGroupedItem>;
      
      private var _passedItems:Vector.<CollectibleGroupedItem>;
      
      private var var_885:IItemListWindow;
      
      private var var_2434:IRegionWindow;
      
      private var var_4386:int = 200;
      
      private var var_292:int = -1;
      
      private var _currentPageItems:Vector.<CollectibleGroupedItem>;
      
      private var var_3627:String = "";
      
      private var var_3679:int = -1;
      
      public function CollectiblesGridView(param1:CollectiblesView, param2:IItemGridWindow, param3:IItemListWindow)
      {
         super();
         var_18 = param1;
         var_608 = param2;
         var_608.shouldRebuildGridOnResize = false;
         _items = new Vector.<CollectibleGroupedItem>(0);
         _passedItems = new Vector.<CollectibleGroupedItem>(0);
         var_885 = param3;
         if(var_885)
         {
            var_2434 = var_885.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return var_608.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<CollectibleGroupedItem>
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
      
      public function setFilter(param1:int, param2:String) : void
      {
         var_3627 = param2 == null ? "" : param2.toLowerCase();
         var_3679 = param1;
         update();
      }
      
      public function itemWasUpdated(param1:CollectibleGroupedItem) : void
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
      
      public function setItems(param1:Vector.<CollectibleGroupedItem>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:Vector.<CollectibleGroupedItem> = new Vector.<CollectibleGroupedItem>(0);
         for each(_loc2_ in _items)
         {
            if(passFilter(_loc2_))
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length == _passedItems.length)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               if(_loc1_[_loc4_] != _passedItems[_loc4_])
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               return;
            }
         }
         _passedItems = _loc1_;
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
         _currentPageItems = new Vector.<CollectibleGroupedItem>(0);
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
      
      private function passFilter(param1:CollectibleGroupedItem) : Boolean
      {
         var _loc2_:String = null;
         if(param1 == null || param1.name == null)
         {
            return false;
         }
         if(var_3627.length > 0)
         {
            _loc2_ = param1.name.toLowerCase();
            if(_loc2_.indexOf(var_3627) == -1)
            {
               return false;
            }
         }
         if(var_3679 != -1 && param1.renderableItem.productTypeId != var_3679)
         {
            return false;
         }
         return true;
      }
   }
}

