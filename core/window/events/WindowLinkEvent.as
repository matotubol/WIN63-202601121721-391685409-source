package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   
   public class WindowLinkEvent extends class_1758
   {
      
      public static const const_1047:String = "WE_LINK";
      
      private static const const_17:Array = [];
      
      private var var_777:String;
      
      public function WindowLinkEvent()
      {
         super();
         var_230 = "WE_LINK";
      }
      
      public static function allocate(param1:String, param2:class_1741, param3:class_1741) : class_1758
      {
         var _loc4_:WindowLinkEvent = const_17.length > 0 ? const_17.pop() : new WindowLinkEvent();
         _loc4_.var_777 = param1;
         _loc4_._window = param2;
         _loc4_.var_1436 = param3;
         _loc4_.var_123 = false;
         _loc4_.var_1570 = const_17;
         return _loc4_;
      }
      
      public function get link() : String
      {
         return var_777;
      }
      
      override public function clone() : class_1758
      {
         return allocate(var_777,window,related);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + var_230 + " link: " + link + " cancelable: " + var_943 + " window: " + _window + " }";
      }
   }
}

