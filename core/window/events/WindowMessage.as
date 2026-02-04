package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   
   public class WindowMessage extends class_1758
   {
      
      private static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
      
      private static const const_17:Array = [];
      
      public var message:String;
      
      public function WindowMessage()
      {
         super();
         var_230 = "WE_MESSAGE";
      }
      
      public static function allocate(param1:String, param2:class_1741, param3:class_1741, param4:Boolean = false) : class_1758
      {
         var _loc5_:WindowMessage = const_17.length > 0 ? const_17.pop() : new WindowMessage();
         _loc5_.message = param1;
         _loc5_._window = param2;
         _loc5_.var_1436 = param3;
         _loc5_.var_943 = param4;
         _loc5_.var_123 = false;
         _loc5_.var_1570 = const_17;
         return _loc5_;
      }
      
      override public function clone() : class_1758
      {
         return allocate(message,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + var_230 + " message: " + message + " cancelable: " + var_943 + " window: " + _window + " }";
      }
   }
}

