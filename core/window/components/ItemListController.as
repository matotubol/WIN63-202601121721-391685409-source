package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.ItemListIterator;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.utils.IInputProcessorRoot;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot
   {
      
      private var var_5035:Boolean = false;
      
      private var var_3470:Boolean = false;
      
      private var var_3685:Boolean = false;
      
      protected var var_759:Number = 0;
      
      protected var var_836:Number = 0;
      
      protected var _scrollAreaWidth:Number = 0;
      
      protected var var_155:Number = 0;
      
      protected var _container:class_1812;
      
      protected var var_3298:Boolean = false;
      
      protected var var_413:Boolean = false;
      
      protected var var_606:int;
      
      protected var var_325:Boolean = false;
      
      protected var _arrangeListItems:Boolean;
      
      protected var _scaleToFitItems:Boolean;
      
      protected var _resizeOnItemUpdate:Boolean;
      
      protected var _inverseResizeOnItemUpdate:Boolean;
      
      protected var var_3969:Number;
      
      protected var var_3641:Number;
      
      protected var var_4583:Number;
      
      protected var var_3866:Number;
      
      protected var var_1609:Boolean;
      
      protected var _scrollWheelStartTime:Number;
      
      protected var var_659:Number;
      
      protected var var_4698:Number = 200;
      
      protected var var_2292:Number = 25;
      
      protected var var_2323:Number = 25;
      
      protected var var_1334:Number = 0;
      
      protected var var_1243:Timer;
      
      public function ItemListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_325 = param2 == 51;
         var _loc13_:IThemeManager = param5.getWindowFactory().getThemeManager();
         var_606 = int(_loc13_.getPropertyDefaults(param3).method_20("spacing").value);
         _arrangeListItems = _loc13_.getPropertyDefaults(param3).method_20("auto_arrange_items").value;
         _scaleToFitItems = _loc13_.getPropertyDefaults(param3).method_20("scale_to_fit_items").value;
         _resizeOnItemUpdate = _loc13_.getPropertyDefaults(param3).method_20("resize_on_item_update").value;
         _inverseResizeOnItemUpdate = _loc13_.getPropertyDefaults(param3).method_20("inverse_resize_on_item_update").value;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_326 = _background || !testParamFlag(16);
         _container = _context.create("_CONTAINER","",4,0,0x10 | 0 | 0,new Rectangle(0,0,width,height),null,this,0,null,"",["_INTERNAL","_EXCLUDE"]) as class_1812;
         _container.addEventListener("WE_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_REMOVED",containerEventHandler);
         _container.addEventListener("WE_CHILD_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_VISIBILITY",containerEventHandler);
         _container.addEventListener("WE_CHILD_RELOCATED",containerEventHandler);
         _container.clipping = clipping;
         resizeOnItemUpdate = _resizeOnItemUpdate;
         var _loc14_:int = 60;
         var _loc12_:int = 1000 / _loc14_;
         var _loc15_:int = var_4698 / _loc12_ + 10;
         var_1243 = new Timer(_loc12_,_loc15_);
         var_1243.addEventListener("timer",updateScrolling);
         var_1243.addEventListener("timerComplete",endScrollWheel);
      }
      
      private static function smoothInterpolation(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param3 > 1)
         {
            param3 = 1;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         return param1 + (param2 - param1) * param3;
      }
      
      public function get spacing() : int
      {
         return var_606;
      }
      
      public function set spacing(param1:int) : void
      {
         if(param1 != var_606)
         {
            var_606 = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scrollH() : Number
      {
         return var_759;
      }
      
      public function get scrollV() : Number
      {
         return var_836;
      }
      
      public function get maxScrollH() : int
      {
         return Math.max(0,_scrollAreaWidth - width);
      }
      
      public function get maxScrollV() : int
      {
         return Math.max(0,var_155 - height);
      }
      
      public function get isPartOfGridWindow() : Boolean
      {
         return var_3470;
      }
      
      public function set isPartOfGridWindow(param1:Boolean) : void
      {
         var_3470 = param1;
      }
      
      public function get enableScrollByDragging() : Boolean
      {
         return var_3685;
      }
      
      public function set enableScrollByDragging(param1:Boolean) : void
      {
         var_3685 = param1;
      }
      
      public function get scrollableWindow() : class_1741
      {
         return this;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(var_759 * maxScrollH,var_836 * maxScrollV,width,height);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _container.rectangle;
      }
      
      public function set scrollH(param1:Number) : void
      {
         setScrollH(param1,false);
      }
      
      private function setScrollH(param1:Number, param2:Boolean) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - var_759;
         if(param1 != var_759)
         {
            var_759 = param1;
            _container.x = -var_759 * maxScrollH;
            _context.invalidate(_container,visibleRegion,1);
            if(name_1)
            {
               var _loc4_:class_1758 = class_1758.allocate("WE_SCROLL",this,null);
               name_1.dispatchEvent(null);
               null.recycle();
            }
         }
         if(!param2 && isScrollingWithWheel)
         {
            var_659 += _loc3_;
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         setScrollV(param1,false);
      }
      
      private function setScrollV(param1:Number, param2:Boolean) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - var_836;
         if(param1 != var_836)
         {
            var_836 = param1;
            _container.y = -var_836 * maxScrollV;
            _context.invalidate(_container,visibleRegion,1);
            if(name_1)
            {
               var _loc4_:class_1758 = class_1758.allocate("WE_SCROLL",this,null);
               name_1.dispatchEvent(null);
               null.recycle();
            }
         }
         if(!param2 && isScrollingWithWheel)
         {
            var_659 += _loc3_;
         }
      }
      
      public function get scrollStepH() : Number
      {
         return var_2292;
      }
      
      public function get scrollStepV() : Number
      {
         return var_2323;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
         var_2292 = param1;
      }
      
      public function set scrollStepV(param1:Number) : void
      {
         var_2323 = param1;
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         if(_scaleToFitItems != param1)
         {
            _scaleToFitItems = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _scaleToFitItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _arrangeListItems = param1;
         updateScrollAreaRegion();
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _arrangeListItems;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _resizeOnItemUpdate = param1;
         if(_container)
         {
            if(var_325)
            {
               _container.setParamFlag(4194304,param1);
            }
            else
            {
               _container.setParamFlag(8388608,param1);
            }
         }
      }
      
      public function set inverseResizeOnItemUpdate(param1:Boolean) : void
      {
         if(param1 != _inverseResizeOnItemUpdate)
         {
            _inverseResizeOnItemUpdate = param1;
            if(_container)
            {
               if(var_325)
               {
                  _container.setParamFlag(8388608,param1);
               }
               else
               {
                  _container.setParamFlag(4194304,param1);
               }
            }
            updateScrollAreaRegion();
         }
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _resizeOnItemUpdate;
      }
      
      public function get inverseResizeOnItemUpdate() : Boolean
      {
         return _inverseResizeOnItemUpdate;
      }
      
      public function get iterator() : IIterator
      {
         return new ItemListIterator(this);
      }
      
      public function get firstListItem() : class_1741
      {
         return numListItems > 0 ? getListItemAt(0) : null;
      }
      
      public function get lastListItem() : class_1741
      {
         return numListItems > 0 ? getListItemAt(numListItems - 1) : null;
      }
      
      override public function set clipping(param1:Boolean) : void
      {
         super.clipping = param1;
         if(_container)
         {
            _container.clipping = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            _container.removeEventListener("WE_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_REMOVED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_VISIBILITY",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RELOCATED",containerEventHandler);
            var_1243.removeEventListener("timer",updateScrolling);
            var_1243.removeEventListener("timerComplete",endScrollWheel);
            super.dispose();
         }
      }
      
      override protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < numListItems)
         {
            IItemListWindow(param1).addListItem(getListItemAt(_loc2_).clone());
            _loc2_++;
         }
      }
      
      public function get numListItems() : int
      {
         return _container != null ? _container.numChildren : 0;
      }
      
      public function addListItem(param1:class_1741) : class_1741
      {
         var_413 = true;
         if(var_325)
         {
            param1.x = _scrollAreaWidth + (numListItems > 0 ? var_606 : 0);
            _scrollAreaWidth = param1.right;
            _container.width = _scrollAreaWidth;
         }
         else
         {
            if(autoArrangeItems)
            {
               param1.y = var_155 + (numListItems > 0 ? var_606 : 0);
               var_155 = param1.bottom;
            }
            else
            {
               var_155 = Math.max(var_155,param1.bottom);
            }
            _container.height = var_155;
         }
         param1 = _container.addChild(param1);
         var_413 = false;
         return param1;
      }
      
      public function addListItemAt(param1:class_1741, param2:uint) : class_1741
      {
         param1 = _container.addChildAt(param1,param2);
         updateScrollAreaRegion();
         return param1;
      }
      
      public function getListItemAt(param1:uint) : class_1741
      {
         return _container.getChildAt(param1);
      }
      
      public function getListItemByID(param1:uint) : class_1741
      {
         return _container.getChildByID(param1);
      }
      
      public function getListItemByName(param1:String) : class_1741
      {
         return _container.getChildByName(param1);
      }
      
      public function getListItemByTag(param1:String) : class_1741
      {
         return _container.getChildByTag(param1);
      }
      
      public function getListItemIndex(param1:class_1741) : int
      {
         return _container.getChildIndex(param1);
      }
      
      public function removeListItem(param1:class_1741) : class_1741
      {
         param1 = _container.removeChild(param1);
         if(param1)
         {
            updateScrollAreaRegion();
         }
         return param1;
      }
      
      public function removeListItemAt(param1:int) : class_1741
      {
         return _container.removeChildAt(param1);
      }
      
      public function setListItemIndex(param1:class_1741, param2:int) : void
      {
         _container.setChildIndex(param1,param2);
      }
      
      public function swapListItems(param1:class_1741, param2:class_1741) : void
      {
         _container.swapChildren(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _container.swapChildrenAt(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithID(param1,param2,param3);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function removeListItems() : void
      {
         var_413 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0);
         }
         var_413 = false;
         updateScrollAreaRegion();
      }
      
      public function destroyListItems() : void
      {
         var_413 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0).destroy();
         }
         var_413 = false;
         updateScrollAreaRegion();
      }
      
      public function arrangeListItems() : void
      {
         updateScrollAreaRegion();
      }
      
      override public function populate(param1:Array) : void
      {
         WindowController(_container).populate(param1);
         updateScrollAreaRegion();
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case "WE_RESIZE":
               var_3298 = true;
               break;
            case "WE_RESIZED":
               if(!_scaleToFitItems && !_inverseResizeOnItemUpdate)
               {
                  if(var_325)
                  {
                     _container.height = var_32;
                  }
                  else
                  {
                     _container.width = var_29;
                  }
               }
               updateScrollAreaRegion();
               var_3298 = false;
               break;
            default:
               if(param2 is class_1758)
               {
                  _loc3_ = process(param2 as class_1758);
               }
         }
         return _loc3_;
      }
      
      override public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return isInWindowBounds(param1);
      }
      
      public function process(param1:class_1758) : Boolean
      {
         var _loc5_:* = false;
         if(param1 is WindowMouseEvent)
         {
            var _loc3_:int = int(WindowMouseEvent(param1).localX);
            var _loc4_:int = int(WindowMouseEvent(param1).localY);
         }
         switch(param1.type)
         {
            case "WME_WHEEL":
               handleScrollWheelEvent(param1);
               _loc5_ = !var_3470;
               break;
            case "WME_DOWN":
               var_3969 = 0;
               var_3641 = 0;
               var_4583 = var_759 * maxScrollH;
               var_3866 = var_836 * maxScrollV;
               var_1609 = true;
               _loc5_ = true;
               break;
            case "WME_MOVE":
               if(var_1609 && !var_5035 && var_3685)
               {
                  if(var_325)
                  {
                     scrollH = (var_4583 + var_3969 - 0) / maxScrollH;
                  }
                  else
                  {
                     scrollV = (var_3866 + var_3641 - 0) / maxScrollV;
                  }
                  _loc5_ = true;
               }
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               if(var_1609)
               {
                  var_1609 = false;
                  _loc5_ = true;
               }
         }
         return _loc5_;
      }
      
      protected function get isScrollHorizontal() : Boolean
      {
         return var_325;
      }
      
      protected function updateScrolling(param1:TimerEvent) : void
      {
         var _loc2_:Number = getTimer();
         var _loc5_:Number = (_loc2_ - _scrollWheelStartTime + 16.6) / var_4698;
         var _loc3_:* = _loc2_ + 16.6 >= _scrollWheelStartTime + var_4698;
         var _loc4_:Number = smoothInterpolation(var_659,scrollWheelTargetPos,_loc5_);
         if(isScrollHorizontal)
         {
            setScrollH(_loc4_,true);
         }
         else
         {
            setScrollV(_loc4_,true);
         }
         if(_loc3_)
         {
            endScrollWheel();
         }
      }
      
      private function endScrollWheel(param1:TimerEvent = null) : void
      {
         if(!isScrollingWithWheel)
         {
            return;
         }
         _scrollWheelStartTime = 0;
         var_659 = 0;
         var_1334 = 0;
         var_1243.reset();
      }
      
      private function get isScrollingWithWheel() : Boolean
      {
         return var_1243.running;
      }
      
      private function get scrollWheelTargetPos() : Number
      {
         if(isScrollHorizontal)
         {
            return var_659 - var_1334 * scrollStepH / maxScrollH;
         }
         return var_659 - var_1334 * scrollStepV / maxScrollV;
      }
      
      public function scrollWithWheel(param1:int) : void
      {
         if(isScrollingWithWheel && (var_1334 > 0 && param1 < 0 || var_1334 < 0 && param1 > 0))
         {
            endScrollWheel();
         }
         _scrollWheelStartTime = getTimer();
         var_659 = isScrollHorizontal ? scrollH : scrollV;
         var_1334 += param1;
         var_1243.reset();
         var_1243.start();
         updateScrolling(null);
      }
      
      protected function handleScrollWheelEvent(param1:class_1758) : void
      {
         scrollWithWheel(WindowMouseEvent(param1).delta);
      }
      
      private function containerEventHandler(param1:class_1758) : void
      {
         switch(param1.type)
         {
            case "WE_CHILD_REMOVED":
               updateScrollAreaRegion();
               break;
            case "WE_CHILD_RESIZED":
               if(!var_3298)
               {
                  updateScrollAreaRegion();
               }
               break;
            case "WE_CHILD_VISIBILITY":
               updateScrollAreaRegion();
               break;
            case "WE_CHILD_RELOCATED":
               updateScrollAreaRegion();
               break;
            case "WE_RESIZED":
               if(name_1)
               {
                  var _loc2_:class_1758 = class_1758.allocate("WE_RESIZED",this,null);
                  name_1.dispatchEvent(null);
                  null.recycle();
               }
         }
      }
      
      protected function updateScrollAreaRegion() : void
      {
         if(_arrangeListItems && !var_413 && _container)
         {
            var_413 = true;
            var _loc2_:uint = uint(_container.numChildren);
            if(var_325)
            {
               _scrollAreaWidth = 0;
               var_155 = var_32;
               var _loc4_:int = 0;
               var _loc3_:uint = 0;
            }
            else
            {
               _scrollAreaWidth = var_29;
               var_155 = 0;
               _loc4_ = 0;
               _loc3_ = 0;
            }
            if(var_759 > 0)
            {
               if(_scrollAreaWidth <= var_29)
               {
                  scrollH = 0;
               }
               else
               {
                  _container.x = -(var_759 * maxScrollH);
               }
            }
            if(var_836 > 0)
            {
               if(var_155 <= var_32)
               {
                  scrollV = 0;
               }
               else
               {
                  _container.y = -(var_836 * maxScrollV);
               }
            }
            _container.height = var_155;
            _container.width = _scrollAreaWidth;
            if(_inverseResizeOnItemUpdate)
            {
               if(var_325)
               {
                  limits.minHeight = 0;
                  limits.maxHeight = 0;
                  _container.height = 0;
               }
               else
               {
                  limits.minWidth = 0;
                  limits.maxWidth = 0;
                  _container.width = 0;
               }
            }
            var_413 = false;
         }
      }
      
      private function getChildRequiredHorizontalSpace(param1:class_1741) : int
      {
         var _loc2_:uint = uint(param1.param & 0xC0);
         if(_loc2_ == 128)
         {
            var _loc4_:int = Math.max(0,param1.x);
            var _loc3_:int = Math.max(0,var_29 - param1.x - param1.width);
            return param1.limits.minWidth + 0 + 0;
         }
         if(_loc2_ == 64)
         {
            return var_29 - param1.x;
         }
         if(_loc2_ == 192)
         {
            return param1.width;
         }
         return param1.x + param1.width;
      }
      
      private function getChildRequiredVerticalSpace(param1:class_1741) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = uint(param1.param & 0x0C00);
         if(_loc4_ == 2048)
         {
            _loc2_ = param1.y;
            _loc3_ = var_32 - param1.y - param1.height;
            return param1.limits.minWidth + _loc2_ + _loc3_;
         }
         if(_loc4_ == 1024)
         {
            return var_32 - param1.y;
         }
         if(_loc4_ == 3072)
         {
            return param1.height;
         }
         return param1.y + param1.height;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",var_606));
         _loc1_.push(createProperty("auto_arrange_items",_arrangeListItems));
         _loc1_.push(createProperty("scale_to_fit_items",_scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",_resizeOnItemUpdate));
         _loc1_.push(createProperty("inverse_resize_on_item_update",_inverseResizeOnItemUpdate));
         _loc1_.push(createProperty("scroll_step_h",var_2292));
         _loc1_.push(createProperty("scroll_step_v",var_2323));
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
                  _arrangeListItems = _loc2_.value as Boolean;
                  break;
               case "scroll_step_h":
                  var_2292 = _loc2_.value as Number;
                  break;
               case "scroll_step_v":
                  var_2323 = _loc2_.value as Number;
            }
         }
         super.properties = param1;
      }
      
      public function stopDragging() : void
      {
         var_1609 = false;
      }
      
      public function set disableAutodrag(param1:Boolean) : void
      {
         var_5035 = param1;
      }
   }
}

