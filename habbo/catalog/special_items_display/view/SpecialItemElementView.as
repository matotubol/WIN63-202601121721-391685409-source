package com.sulake.habbo.catalog.special_items_display.view
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsView;
   import com.sulake.habbo.catalog.special_items_display.model.class_2451;
   import com.sulake.habbo.window.widgets.class_1902;
   
   public class SpecialItemElementView implements class_13
   {
      
      private static const BLEND_BUFFERING:Number = 0.05;
      
      private var var_18:SpecialItemsView;
      
      private var _window:class_2010;
      
      private var var_452:class_2451;
      
      private var var_3282:Number;
      
      private var _point:Object;
      
      private var _disposed:* = false;
      
      public function SpecialItemElementView(param1:SpecialItemsView, param2:class_2451)
      {
         super();
         var_452 = param2;
         var_18 = param1;
         _window = param1.productDisplayTemplate.clone() as class_2010;
         var _loc3_:class_1902 = _window.widget as class_1902;
         _loc3_.productInfo = param2;
         _loc3_.pivot = 7;
      }
      
      public function updateRotation(param1:Number) : void
      {
         updatePointAndFocus(param1);
         var _loc5_:int = _point.x * 216 - 80 + 42;
         var _loc4_:int = _point.y * 73 - 113;
         _window.x = _loc5_;
         _window.y = _loc4_;
         var _loc2_:class_1902 = _window.widget as class_1902;
         var _loc3_:Number = Number(_point.y);
         if(var_18.totalElements <= 4)
         {
            _loc3_ = Math.max(0.25,_loc3_);
         }
         else if(_loc3_ < 0.05)
         {
            _loc3_ = 0;
         }
         _loc3_ = Math.min(_loc3_,1);
         var _loc6_:Boolean = Math.abs(_loc2_.blend - _loc3_) > 0.05 || _loc3_ == 0 && _loc2_.blend != 0 || _loc3_ == 1 && _loc2_.blend != 1;
         if(_loc6_)
         {
            _loc2_.blend = _loc3_;
         }
      }
      
      private function updatePointAndFocus(param1:Number) : void
      {
         var _loc4_:Number = var_452.index - param1;
         var _loc7_:Number = _loc4_ + var_18.totalElements;
         var _loc2_:Number = _loc4_ - var_18.totalElements;
         if(Math.abs(_loc7_) < Math.abs(_loc4_))
         {
            _loc4_ = _loc7_;
         }
         else if(Math.abs(_loc2_) < Math.abs(_loc4_))
         {
            _loc4_ = _loc2_;
         }
         var_3282 = 0;
         if(Math.abs(_loc4_) < 0.5)
         {
            var_3282 = 1 - Math.abs(_loc4_) * 2;
         }
         var _loc8_:Number = 180 + 90 * _loc4_;
         _loc8_ = Math.min(Math.max(_loc8_,0),360);
         var _loc6_:Number = _loc8_ * 3.141592653589793 / 180;
         var _loc3_:Number = 0.5 - 0.5 * Math.sin(_loc6_);
         var _loc5_:Number = 0.5 - 0.5 * Math.cos(_loc6_);
         _point = {
            "x":_loc3_,
            "y":_loc5_
         };
      }
      
      public function get focusValue() : Number
      {
         return var_3282;
      }
      
      public function get item() : class_2451
      {
         return var_452;
      }
      
      public function get window() : class_2010
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window.dispose();
         _window = null;
         var_18 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

