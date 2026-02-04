package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class VariableInfoBubbleView implements class_13, class_31
   {
      
      private static const const_160:int = 18;
      
      public static const const_92:int = 3;
      
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_AWAIT_TARGET_RECT:int = 1;
      
      private static var STATE_ACTIVE:int = 1;
      
      private var _disposed:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_61:int = STATE_IDLE;
      
      private var var_315:int;
      
      private var var_191:int;
      
      private var var_4538:Boolean;
      
      private var _window:class_1812;
      
      private var var_2383:int = 0;
      
      protected var var_2160:FixedSizeStack = new FixedSizeStack(18);
      
      public function VariableInfoBubbleView(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var _loc2_:XmlAsset = _roomEvents.assets.getAssetByName("variable_value_info_bubble_xml") as XmlAsset;
         _window = _roomEvents.windowManager.buildFromXML(_loc2_.content as XML,0) as class_1812;
         _window.ignoreMouseEvents = true;
      }
      
      public function updateValue(param1:String) : void
      {
         if(var_61 == STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
      }
      
      public function setActive(param1:String, param2:int, param3:int, param4:Boolean) : void
      {
         if(var_61 != STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
         var_315 = param2;
         var_191 = param3;
         var_4538 = param4;
         var_61 = STATE_AWAIT_TARGET_RECT;
      }
      
      public function setInactive() : void
      {
         valueText.text = "";
         var_315 = 0;
         var_191 = 0;
         var_2383 = 0;
         var_2160.reset();
         var_61 = STATE_IDLE;
         hide();
      }
      
      private function show() : void
      {
         var _loc1_:class_2052 = null;
         _window.visible = true;
         if(_window.parent == null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         else
         {
            _window.activate();
         }
      }
      
      private function hide() : void
      {
         var _loc1_:class_2052 = null;
         _window.visible = false;
         if(_window.parent != null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function get valueText() : ITextWindow
      {
         return _window.findChildByName("value") as ITextWindow;
      }
      
      public function update(param1:uint) : void
      {
         if(var_61 == STATE_IDLE)
         {
            return;
         }
         var _loc10_:IRoomEngine = _roomEvents.roomEngine;
         var _loc3_:IRoomDesktop = _roomEvents.roomDesktop;
         var _loc4_:Rectangle = _loc10_.getRoomObjectBoundingRectangle(_loc10_.activeRoomId,var_315,var_191,_loc3_.getFirstCanvasId());
         var _loc5_:Point = _loc10_.getRoomObjectScreenLocation(_loc10_.activeRoomId,var_315,var_191,_loc3_.getFirstCanvasId());
         var _loc6_:Rectangle = _loc3_.getRoomViewRect();
         if(_loc4_ && _loc5_ && _loc6_)
         {
            _loc4_.offset(_loc6_.x,_loc6_.y);
            _loc5_.offset(_loc6_.x,_loc6_.y);
         }
         if(!_loc4_ || !_loc5_)
         {
            return;
         }
         var _loc2_:int = getOffset(_loc4_);
         var _loc7_:int = _loc5_.y - _loc4_.top;
         var_2160.addValue(_loc7_);
         var _loc8_:int = var_2160.getMax();
         if(_loc8_ < var_2383 - 3)
         {
            _loc8_ = var_2383 - 3;
         }
         var _loc9_:int = _loc5_.y - _loc8_;
         var_2383 = _loc8_;
         _window.x = _loc5_.x - _window.width / 2;
         _window.y = _loc9_ + _loc2_;
         if(var_61 == STATE_AWAIT_TARGET_RECT)
         {
            var_61 = STATE_ACTIVE;
            show();
         }
      }
      
      private function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -_window.height;
         if(var_4538)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _roomEvents = null;
         var_2160 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

