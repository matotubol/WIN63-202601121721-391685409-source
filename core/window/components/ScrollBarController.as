package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowTouchEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class ScrollBarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow
   {
      
      private static const SCROLL_BUTTON_INCREMENT:String = "increment";
      
      private static const SCROLL_BUTTON_DECREMENT:String = "decrement";
      
      private static const SCROLL_SLIDER_TRACK:String = "slider_track";
      
      private static const SCROLL_SLIDER_BAR:String = "slider_bar";
      
      protected var _offset:Number = 0;
      
      protected var var_1769:Number = 0.1;
      
      protected var var_38:IScrollableWindow;
      
      private var var_325:Boolean;
      
      private var _targetName:String;
      
      private var var_1479:Boolean = false;
      
      public function ScrollBarController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0, param12:IScrollableWindow = null)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_326 = false;
         var_38 = param12;
         var_325 = param2 == 130;
         var _loc13_:Array = [];
         groupChildrenWithTag("_INTERNAL",_loc13_,-1);
         for each(var _loc14_ in _loc13_)
         {
            _loc14_.procedure = scrollButtonEventProc;
         }
         updateLiftSizeAndPosition();
      }
      
      public function get scrollH() : Number
      {
         return var_325 ? _offset : 0;
      }
      
      public function get scrollV() : Number
      {
         return var_325 ? 0 : _offset;
      }
      
      public function get scrollable() : IScrollableWindow
      {
         return var_38;
      }
      
      public function set scrollH(param1:Number) : void
      {
         if(var_325)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(!var_325)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollable(param1:IScrollableWindow) : void
      {
         if(var_38 != null && !var_38.disposed)
         {
            var_38.removeEventListener("WE_RESIZED",onScrollableResized);
            var_38.removeEventListener("WE_SCROLL",onScrollableScrolled);
         }
         var_38 = param1;
         if(var_38 != null && !var_38.disposed)
         {
            var_38.addEventListener("WE_RESIZED",onScrollableResized);
            var_38.addEventListener("WE_SCROLL",onScrollableScrolled);
            updateLiftSizeAndPosition();
         }
      }
      
      public function get horizontal() : Boolean
      {
         return var_325;
      }
      
      public function get vertical() : Boolean
      {
         return !var_325;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         var _loc2_:String = null;
         if(var_38 is class_1741)
         {
            _loc2_ = class_1741(var_38).name;
         }
         else if(_targetName != null)
         {
            _loc2_ = _targetName;
         }
         if(_loc2_ == null)
         {
            _loc1_.push(getDefaultProperty("scrollable"));
         }
         else
         {
            _loc1_.push(createProperty("scrollable",_loc2_));
         }
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("scrollable" === _loc3_)
            {
               _targetName = _loc2_.value as String;
               var_38 = null;
            }
         }
         super.properties = param1;
      }
      
      protected function get track() : WindowController
      {
         return findChildByName("slider_track") as WindowController;
      }
      
      protected function get lift() : WindowController
      {
         return track.findChildByName("slider_bar") as WindowController;
      }
      
      override public function dispose() : void
      {
         scrollable = null;
         super.dispose();
      }
      
      override public function enable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.enable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               class_1741(_loc1_[_loc2_]).enable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      override public function disable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.disable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               class_1741(_loc1_[_loc2_]).disable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      protected function setScrollPosition(param1:Number, param2:Boolean) : Boolean
      {
         if(var_38 == null || Boolean(var_38.disposed))
         {
            if(!resolveScrollTarget())
            {
               return false;
            }
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         _offset = param1;
         if(param2)
         {
            if(var_325)
            {
               var _loc3_:* = var_38.scrollH != _offset;
            }
            else
            {
               _loc3_ = var_38.scrollV != _offset;
            }
         }
         return false;
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc5_:* = param1.name;
         if("slider_bar" === _loc5_)
         {
            if(param2.type == "WE_CHILD_RELOCATED")
            {
               if(!var_1479)
               {
                  var _loc3_:ScrollBarLiftController = ScrollBarLiftController(param1);
                  if(var_325)
                  {
                     setScrollPosition(null.scrollbarOffsetX,true);
                  }
                  else
                  {
                     setScrollPosition(null.scrollbarOffsetY,true);
                  }
               }
            }
         }
         var _loc4_:Boolean = super.update(param1,param2);
         if(param2.type == "WE_PARENT_ADDED")
         {
            if(var_38 == null)
            {
               resolveScrollTarget();
            }
         }
         if(param1 == this)
         {
            if(param2.type == "WE_RESIZED")
            {
               updateLiftSizeAndPosition();
            }
            else if(param2.type == "WME_WHEEL")
            {
               if(WindowMouseEvent(param2).delta > 0)
               {
                  if(var_325)
                  {
                     scrollH -= var_1769;
                  }
                  else
                  {
                     scrollV -= var_1769;
                  }
               }
               else if(var_325)
               {
                  scrollH += var_1769;
               }
               else
               {
                  scrollV += var_1769;
               }
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      private function updateLiftSizeAndPosition() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(var_38 == null || Boolean(var_38.disposed))
         {
            if(_disposed || !resolveScrollTarget())
            {
               return;
            }
         }
         var _loc2_:WindowController = track;
         var _loc1_:WindowController = lift;
         if(_loc1_ != null)
         {
            if(var_325)
            {
               _loc4_ = var_38.visibleRegion.width / var_38.scrollableRegion.width;
               if(_loc4_ > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.width;
               _loc1_.width = _loc3_;
               _loc1_.x = Math.round(var_38.scrollH * (_loc2_.width - _loc3_));
            }
            else
            {
               _loc4_ = var_38.visibleRegion.height / var_38.scrollableRegion.height;
               if(_loc4_ > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.height;
               _loc1_.height = _loc3_;
               _loc1_.y = Math.round(var_38.scrollV * (_loc2_.height - _loc1_.height));
            }
         }
         if(_loc4_ == 1)
         {
            disable();
         }
         else
         {
            enable();
         }
      }
      
      private function nullEventProc(param1:class_1758, param2:class_1741) : void
      {
      }
      
      private function scrollButtonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:class_1741 = null;
         var _loc6_:Boolean = false;
         if(param1.type == "WME_DOWN" || param1.type == "WTE_TAP")
         {
            if(param2.name == "increment")
            {
               if(var_38)
               {
                  var_1479 = true;
                  if(var_325)
                  {
                     scrollH += var_38.scrollStepH / var_38.maxScrollH;
                  }
                  else
                  {
                     scrollV += var_38.scrollStepV / var_38.maxScrollV;
                  }
                  var_1479 = false;
               }
            }
            else if(param2.name == "decrement")
            {
               if(var_38)
               {
                  var_1479 = true;
                  if(var_325)
                  {
                     scrollH -= var_38.scrollStepH / var_38.maxScrollH;
                  }
                  else
                  {
                     scrollV -= var_38.scrollStepV / var_38.maxScrollV;
                  }
                  var_1479 = false;
               }
            }
            else if(param2.name == "slider_track")
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc5_ = int(WindowMouseEvent(param1).localX);
                  _loc4_ = int(WindowMouseEvent(param1).localY);
               }
               else if(param1 is WindowTouchEvent)
               {
                  _loc5_ = int(WindowTouchEvent(param1).localX);
                  _loc4_ = int(WindowTouchEvent(param1).localY);
               }
               _loc3_ = WindowController(param2).getChildByName("slider_bar");
               if(var_325)
               {
                  if(_loc5_ < _loc3_.x)
                  {
                     scrollH -= (var_38.visibleRegion.width - var_38.scrollStepH) / var_38.maxScrollH;
                  }
                  else if(_loc5_ > _loc3_.right)
                  {
                     scrollH += (var_38.visibleRegion.width - var_38.scrollStepH) / var_38.maxScrollH;
                  }
               }
               else if(_loc4_ < _loc3_.y)
               {
                  scrollV -= (var_38.visibleRegion.height - var_38.scrollStepV) / var_38.maxScrollV;
               }
               else if(_loc4_ > _loc3_.bottom)
               {
                  scrollV += (var_38.visibleRegion.height - var_38.scrollStepV) / var_38.maxScrollV;
               }
               _loc6_ = true;
            }
         }
         if(param1.type == "WME_WHEEL")
         {
            if(WindowMouseEvent(param1).delta > 0)
            {
               if(var_325)
               {
                  scrollH -= var_1769;
               }
               else
               {
                  scrollV -= var_1769;
               }
            }
            else if(var_325)
            {
               scrollH += var_1769;
            }
            else
            {
               scrollV += var_1769;
            }
            _loc6_ = true;
         }
         if(_loc6_)
         {
            updateLiftSizeAndPosition();
         }
      }
      
      private function resolveScrollTarget() : Boolean
      {
         var _loc1_:IScrollableWindow = null;
         var _loc4_:IScrollableWindow = null;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(var_38 != null)
         {
            if(!var_38.disposed)
            {
               return true;
            }
         }
         if(_targetName != null)
         {
            _loc1_ = findParentByName(_targetName) as IScrollableWindow;
            if(_loc1_ == null && _parent is class_1812 && !(_parent is class_2052))
            {
               _loc1_ = class_1812(_parent).findChildByName(_targetName) as IScrollableWindow;
               if(_loc1_)
               {
                  scrollable = _loc1_;
                  return true;
               }
            }
         }
         if(_parent is IScrollableWindow)
         {
            scrollable = IScrollableWindow(_parent);
            return true;
         }
         if(_parent is class_1812 && !(_parent is class_2052))
         {
            _loc2_ = uint(class_1812(_parent).numChildren);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = class_1812(_parent).getChildAt(_loc3_) as IScrollableWindow;
               if(_loc4_)
               {
                  scrollable = _loc4_;
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function onScrollableResized(param1:class_1758) : void
      {
         updateLiftSizeAndPosition();
         setScrollPosition(_offset,false);
      }
      
      private function onScrollableScrolled(param1:class_1758) : void
      {
         updateLiftSizeAndPosition();
      }
   }
}

