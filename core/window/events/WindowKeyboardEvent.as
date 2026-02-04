package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class WindowKeyboardEvent extends class_1758
   {
      
      public static const const_1008:String = "WKE_KEY_UP";
      
      public static const const_1253:String = "WKE_KEY_DOWN";
      
      private static const const_17:Array = [];
      
      private var var_1657:KeyboardEvent;
      
      public function WindowKeyboardEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:Event, param3:class_1741, param4:class_1741, param5:Boolean = false) : WindowKeyboardEvent
      {
         var _loc6_:WindowKeyboardEvent = const_17.length > 0 ? const_17.pop() : new WindowKeyboardEvent();
         _loc6_.var_230 = param1;
         _loc6_.var_1657 = param2 as KeyboardEvent;
         _loc6_._window = param3;
         _loc6_.var_1436 = param4;
         _loc6_.var_123 = false;
         _loc6_.var_943 = param5;
         _loc6_.var_1570 = const_17;
         return _loc6_;
      }
      
      public function get charCode() : uint
      {
         return var_1657.charCode;
      }
      
      public function get keyCode() : uint
      {
         return var_1657.keyCode;
      }
      
      public function get keyLocation() : uint
      {
         return var_1657.keyLocation;
      }
      
      public function get altKey() : Boolean
      {
         return var_1657.altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_1657.shiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_1657.ctrlKey;
      }
      
      override public function clone() : class_1758
      {
         return allocate(var_230,var_1657,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowKeyboardEvent { type: " + var_230 + " cancelable: " + var_943 + " window: " + _window + " charCode: " + charCode + " }";
      }
   }
}

