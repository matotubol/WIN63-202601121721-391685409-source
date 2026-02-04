package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   
   public class WindowDisposeEvent extends class_1758
   {
      
      public static const const_483:String = "WINDOW_DISPOSE_EVENT";
      
      private static const const_17:Array = [];
      
      public function WindowDisposeEvent()
      {
         super();
         var_230 = "WINDOW_DISPOSE_EVENT";
      }
      
      public static function allocate(param1:class_1741) : WindowDisposeEvent
      {
         var _loc2_:WindowDisposeEvent = const_17.length > 0 ? const_17.pop() : new WindowDisposeEvent();
         _loc2_._window = param1;
         _loc2_.var_123 = false;
         _loc2_.var_1570 = const_17;
         return _loc2_;
      }
      
      override public function clone() : class_1758
      {
         return allocate(window);
      }
      
      override public function toString() : String
      {
         return "WindowDisposeEvent { type: " + var_230 + " window: " + _window + " }";
      }
   }
}

