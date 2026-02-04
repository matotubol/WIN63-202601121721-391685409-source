package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class ScrollableItemGridWindow extends WindowController implements IScrollableGridWindow
   {
      
      private var var_2133:IItemGridWindow;
      
      private var var_809:IScrollbarWindow;
      
      private var var_2400:Boolean = true;
      
      public function ScrollableItemGridWindow(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _scrollBar.scrollable = _itemGrid;
         if(_scrollBar.testStateFlag(32))
         {
            hideScrollBar();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",spacing));
         _loc1_.push(createProperty("auto_arrange_items",autoArrangeItems));
         _loc1_.push(createProperty("scale_to_fit_items",scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",resizeOnItemUpdate));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  spacing = _loc2_.value as int;
                  break;
               case "scale_to_fit_items":
                  scaleToFitItems = _loc2_.value as Boolean;
                  break;
               case "resize_on_item_update":
                  resizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "auto_arrange_items":
                  autoArrangeItems = _loc2_.value as Boolean;
            }
         }
         super.properties = param1;
      }
      
      public function get autoHideScrollBar() : Boolean
      {
         return var_2400;
      }
      
      public function set autoHideScrollBar(param1:Boolean) : void
      {
         var_2400 = param1;
         updateScrollBarVisibility();
      }
      
      public function get iterator() : IIterator
      {
         return isConstructionReady() ? _itemGrid.iterator : null;
      }
      
      public function get scrollH() : Number
      {
         return _itemGrid.scrollH;
      }
      
      public function set scrollH(param1:Number) : void
      {
         _itemGrid.scrollH = param1;
      }
      
      public function get scrollV() : Number
      {
         return _itemGrid.scrollV;
      }
      
      public function set scrollV(param1:Number) : void
      {
         _itemGrid.scrollV = param1;
      }
      
      public function get maxScrollH() : int
      {
         return _itemGrid.maxScrollH;
      }
      
      public function get maxScrollV() : int
      {
         return _itemGrid.maxScrollV;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return _itemGrid.visibleRegion;
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _itemGrid.scrollableRegion;
      }
      
      public function get scrollStepH() : Number
      {
         return _itemGrid.scrollStepH;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
         _itemGrid.scrollStepH = param1;
      }
      
      public function get scrollStepV() : Number
      {
         return _itemGrid.scrollStepV;
      }
      
      public function set scrollStepV(param1:Number) : void
      {
         _itemGrid.scrollStepV = param1;
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _itemGrid.autoArrangeItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _itemGrid.autoArrangeItems = param1;
      }
      
      public function get numColumns() : uint
      {
         return _itemGrid.numColumns;
      }
      
      public function get numRows() : uint
      {
         return _itemGrid.numRows;
      }
      
      public function get numGridItems() : uint
      {
         return _itemGrid.numGridItems;
      }
      
      public function get shouldRebuildGridOnResize() : Boolean
      {
         return _itemGrid.shouldRebuildGridOnResize;
      }
      
      public function set shouldRebuildGridOnResize(param1:Boolean) : void
      {
         _itemGrid.shouldRebuildGridOnResize = param1;
      }
      
      public function get spacing() : int
      {
         return _itemGrid.spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         _itemGrid.spacing = param1;
      }
      
      public function set verticalSpacing(param1:int) : void
      {
         _itemGrid.verticalSpacing = param1;
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _itemGrid.scaleToFitItems;
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         _itemGrid.scaleToFitItems = param1;
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _itemGrid.resizeOnItemUpdate;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _itemGrid.resizeOnItemUpdate = param1;
      }
      
      public function set containerResizeToColumns(param1:Boolean) : void
      {
      }
      
      public function get containerResizeToColumns() : Boolean
      {
         return false;
      }
      
      protected function get _itemGrid() : IItemGridWindow
      {
         if(!var_2133)
         {
            var_2133 = findChildByTag("_ITEMGRID") as IItemGridWindow;
         }
         return var_2133;
      }
      
      protected function get _scrollBar() : IScrollbarWindow
      {
         if(!var_809)
         {
            var_809 = findChildByTag("_SCROLLBAR") as IScrollbarWindow;
            if(var_809)
            {
               var_809.addEventListener("WE_ENABLED",scrollBarEventProc);
               var_809.addEventListener("WE_DISABLED",scrollBarEventProc);
            }
         }
         return var_809;
      }
      
      override public function dispose() : void
      {
         if(var_809)
         {
            var_809.removeEventListener("WE_ENABLED",scrollBarEventProc);
            var_809.removeEventListener("WE_DISABLED",scrollBarEventProc);
            var_809 = null;
         }
         if(var_2133)
         {
            var_2133 = null;
         }
         super.dispose();
      }
      
      public function addGridItem(param1:class_1741) : class_1741
      {
         return _itemGrid.addGridItem(param1);
      }
      
      public function addGridItemAt(param1:class_1741, param2:uint) : class_1741
      {
         return _itemGrid.addGridItemAt(param1,param2);
      }
      
      public function getGridItemAt(param1:uint) : class_1741
      {
         return _itemGrid.getGridItemAt(param1);
      }
      
      public function getGridItemByID(param1:uint) : class_1741
      {
         return _itemGrid.getGridItemByID(param1);
      }
      
      public function getGridItemByName(param1:String) : class_1741
      {
         return _itemGrid.getGridItemByName(param1);
      }
      
      public function getGridItemByTag(param1:String) : class_1741
      {
         return _itemGrid.getGridItemByTag(param1);
      }
      
      public function getGridItemIndex(param1:class_1741) : int
      {
         return _itemGrid.getGridItemIndex(param1);
      }
      
      public function removeGridItem(param1:class_1741) : class_1741
      {
         return _itemGrid.removeGridItem(param1);
      }
      
      public function removeGridItemAt(param1:int) : class_1741
      {
         return _itemGrid.removeGridItemAt(param1);
      }
      
      public function setGridItemIndex(param1:class_1741, param2:int) : void
      {
         _itemGrid.setGridItemIndex(param1,param2);
      }
      
      public function swapGridItems(param1:class_1741, param2:class_1741) : void
      {
         _itemGrid.swapGridItems(param1,param2);
      }
      
      public function swapGridItemsAt(param1:int, param2:int) : void
      {
         _itemGrid.swapGridItemsAt(param1,param2);
      }
      
      public function removeGridItems() : void
      {
         _itemGrid.removeGridItems();
      }
      
      public function destroyGridItems() : void
      {
         _itemGrid.destroyGridItems();
      }
      
      public function rebuildGridStructure() : void
      {
         _itemGrid.rebuildGridStructure();
      }
      
      protected function isConstructionReady() : Boolean
      {
         return _itemGrid && _scrollBar;
      }
      
      private function scrollBarEventProc(param1:class_1758) : void
      {
         if(param1.type == "WE_ENABLED")
         {
            showScrollBar();
         }
         else if(param1.type == "WE_DISABLED")
         {
            hideScrollBar();
         }
      }
      
      private function hideScrollBar() : void
      {
         if(_scrollBar.visible)
         {
            _scrollBar.visible = false;
         }
      }
      
      private function showScrollBar() : void
      {
         if(!_scrollBar.visible)
         {
            _scrollBar.visible = true;
         }
      }
      
      private function updateScrollBarVisibility() : void
      {
         if(var_2400)
         {
            if(_scrollBar.testStateFlag(32))
            {
               if(_scrollBar.visible)
               {
                  hideScrollBar();
               }
            }
         }
         else if(_scrollBar.visible)
         {
            showScrollBar();
         }
      }
   }
}

