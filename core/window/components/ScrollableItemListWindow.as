package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class ScrollableItemListWindow extends WindowController implements IScrollableWindow, IScrollableListWindow
   {
      
      private var var_2015:IItemListWindow;
      
      private var var_809:IScrollbarWindow;
      
      private var var_2400:Boolean = true;
      
      public function ScrollableItemListWindow(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _scrollBar.scrollable = _itemList;
         if(_scrollBar.testStateFlag(32) && var_2400)
         {
            hideScrollBar();
         }
         _itemList.enableScrollByDragging = true;
      }
      
      override public function dispose() : void
      {
         if(var_809)
         {
            var_809.removeEventListener("WE_ENABLED",scrollBarEventProc);
            var_809.removeEventListener("WE_DISABLED",scrollBarEventProc);
            var_809 = null;
         }
         if(var_2015)
         {
            var_2015 = null;
         }
         super.dispose();
      }
      
      protected function get _itemList() : IItemListWindow
      {
         if(!var_2015)
         {
            var_2015 = findChildByTag("_ITEMLIST") as IItemListWindow;
         }
         return var_2015;
      }
      
      public function scrollWithWheel(param1:int) : void
      {
         _itemList.scrollWithWheel(param1);
      }
      
      public function get scrollableWindow() : class_1741
      {
         return _itemList;
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
      
      private function scrollBarEventProc(param1:class_1758) : void
      {
         if(param1.type == "WE_ENABLED")
         {
            showScrollBar();
         }
         else if(param1.type == "WE_DISABLED" && var_2400)
         {
            hideScrollBar();
         }
      }
      
      private function hideScrollBar() : void
      {
         if(_scrollBar.visible)
         {
            _scrollBar.visible = false;
            _itemList.width = var_29;
         }
      }
      
      private function showScrollBar() : void
      {
         if(!_scrollBar.visible)
         {
            _scrollBar.visible = true;
            _itemList.width = var_29 - _scrollBar.width;
         }
      }
      
      private function updateScrollBarVisibility(param1:Boolean = false) : void
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
         else if(param1 || Boolean(_scrollBar.visible))
         {
            showScrollBar();
         }
      }
      
      public function get isScrollBarVisible() : Boolean
      {
         return _scrollBar.visible;
      }
      
      protected function isConstructionReady() : Boolean
      {
         return _itemList && _scrollBar;
      }
      
      public function set autoHideScrollBar(param1:Boolean) : void
      {
         var_2400 = param1;
         updateScrollBarVisibility(true);
      }
      
      public function get autoHideScrollBar() : Boolean
      {
         return var_2400;
      }
      
      public function get iterator() : IIterator
      {
         return isConstructionReady() ? _itemList.iterator : null;
      }
      
      public function get scrollH() : Number
      {
         return _itemList.scrollH;
      }
      
      public function get scrollV() : Number
      {
         return _itemList.scrollV;
      }
      
      public function set scrollH(param1:Number) : void
      {
         _itemList.scrollH = param1;
      }
      
      public function set scrollV(param1:Number) : void
      {
         _itemList.scrollV = param1;
      }
      
      public function get maxScrollH() : int
      {
         return _itemList.maxScrollH;
      }
      
      public function get maxScrollV() : int
      {
         return _itemList.maxScrollV;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return _itemList.visibleRegion;
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _itemList.scrollableRegion;
      }
      
      public function get scrollStepH() : Number
      {
         return _itemList.scrollStepH;
      }
      
      public function get scrollStepV() : Number
      {
         return _itemList.scrollStepV;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
         _itemList.scrollStepH = param1;
      }
      
      public function set scrollStepV(param1:Number) : void
      {
         _itemList.scrollStepV = param1;
      }
      
      public function get spacing() : int
      {
         return _itemList.spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         _itemList.spacing = param1;
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _itemList.scaleToFitItems;
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         _itemList.scaleToFitItems = param1;
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _itemList.autoArrangeItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _itemList.autoArrangeItems = param1;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _itemList.resizeOnItemUpdate = param1;
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _itemList.resizeOnItemUpdate;
      }
      
      public function get numListItems() : int
      {
         return _itemList.numListItems;
      }
      
      public function addListItem(param1:class_1741) : class_1741
      {
         return _itemList.addListItem(param1);
      }
      
      public function addListItemAt(param1:class_1741, param2:uint) : class_1741
      {
         return _itemList.addListItemAt(param1,param2);
      }
      
      public function getListItemAt(param1:uint) : class_1741
      {
         return _itemList.getListItemAt(param1);
      }
      
      public function getListItemByID(param1:uint) : class_1741
      {
         return _itemList.getListItemByID(param1);
      }
      
      public function getListItemByName(param1:String) : class_1741
      {
         return _itemList.getListItemByName(param1);
      }
      
      public function getListItemByTag(param1:String) : class_1741
      {
         return _itemList.getListItemByTag(param1);
      }
      
      public function getListItemIndex(param1:class_1741) : int
      {
         return _itemList.getListItemIndex(param1);
      }
      
      public function removeListItem(param1:class_1741) : class_1741
      {
         return _itemList.removeListItem(param1);
      }
      
      public function removeListItemAt(param1:int) : class_1741
      {
         return _itemList.removeListItemAt(param1);
      }
      
      public function setListItemIndex(param1:class_1741, param2:int) : void
      {
         _itemList.setListItemIndex(param1,param2);
      }
      
      public function swapListItems(param1:class_1741, param2:class_1741) : void
      {
         _itemList.swapListItems(param1,param2);
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _itemList.swapListItemsAt(param1,param2);
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         return _itemList.groupListItemsWithID(param1,param2,param3);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _itemList.groupListItemsWithTag(param1,param2,param3);
      }
      
      public function removeListItems() : void
      {
         _itemList.removeListItems();
      }
      
      public function destroyListItems() : void
      {
         _itemList.destroyListItems();
      }
      
      public function arrangeListItems() : void
      {
         _itemList.arrangeListItems();
      }
      
      public function stopDragging() : void
      {
         _itemList.stopDragging();
      }
      
      public function set disableAutodrag(param1:Boolean) : void
      {
         _itemList.disableAutodrag = param1;
      }
      
      public function get isPartOfGridWindow() : Boolean
      {
         return _itemList.isPartOfGridWindow;
      }
      
      public function set isPartOfGridWindow(param1:Boolean) : void
      {
         _itemList.disableAutodrag = param1;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",spacing));
         _loc1_.push(createProperty("auto_arrange_items",autoArrangeItems));
         _loc1_.push(createProperty("scale_to_fit_items",scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",resizeOnItemUpdate));
         _loc1_.push(createProperty("inverse_resize_on_item_update",inverseResizeOnItemUpdate));
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
               case "inverse_resize_on_item_update":
                  inverseResizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "auto_arrange_items":
                  autoArrangeItems = _loc2_.value as Boolean;
            }
         }
         super.properties = param1;
      }
      
      public function get inverseResizeOnItemUpdate() : Boolean
      {
         return _itemList.inverseResizeOnItemUpdate;
      }
      
      public function set inverseResizeOnItemUpdate(param1:Boolean) : void
      {
         _itemList.inverseResizeOnItemUpdate = param1;
      }
      
      public function get enableScrollByDragging() : Boolean
      {
         return true;
      }
      
      public function set enableScrollByDragging(param1:Boolean) : void
      {
      }
   }
}

