package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   
   public class WindowTouchEvent extends class_1758
   {
      
      public static const WINDOW_EVENT_TOUCH_BEGIN:String = "WTE_BEGIN";
      
      public static const const_726:String = "WTE_END";
      
      public static const WINDOW_EVENT_TOUCH_MOVE:String = "WTE_MOVE";
      
      public static const const_351:String = "WTE_OUT";
      
      public static const WINDOW_EVENT_TOUCH_OVER:String = "WTE_OVER";
      
      public static const const_773:String = "WTE_ROLL_OUT";
      
      public static const WINDOW_EVENT_TOUCH_ROLL_OVER:String = "WTE_ROLL_OVER";
      
      public static const const_359:String = "WTE_TAP";
      
      private static const const_17:Array = [];
      
      public var localX:Number;
      
      public var localY:Number;
      
      public var stageX:Number;
      
      public var stageY:Number;
      
      public var altKey:Boolean;
      
      public var ctrlKey:Boolean;
      
      public var shiftKey:Boolean;
      
      public var var_5271:Number;
      
      public var sizeX:Number;
      
      public var sizeY:Number;
      
      public function WindowTouchEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:class_1741, param3:class_1741, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Boolean, param13:Boolean) : WindowTouchEvent
      {
         var _loc14_:WindowTouchEvent = const_17.length > 0 ? const_17.pop() : new WindowTouchEvent();
         _loc14_.var_230 = param1;
         _loc14_._window = param2;
         _loc14_.var_1436 = param3;
         _loc14_.var_123 = false;
         _loc14_.var_1570 = const_17;
         _loc14_.sizeX = param6;
         _loc14_.sizeY = param7;
         _loc14_.localX = param4;
         _loc14_.localY = param5;
         _loc14_.stageX = param8;
         _loc14_.stageY = param9;
         _loc14_.var_5271 = param10;
         _loc14_.altKey = param11;
         _loc14_.ctrlKey = param12;
         _loc14_.shiftKey = param13;
         return _loc14_;
      }
      
      override public function clone() : class_1758
      {
         return allocate(var_230,window,related,localX,localY,sizeX,sizeY,stageX,stageY,var_5271,altKey,ctrlKey,shiftKey);
      }
      
      override public function toString() : String
      {
         return "WindowTouchEvent { type: " + var_230 + " cancelable: " + var_943 + " window: " + _window + " localX: " + localX + " localY: " + localY + " }";
      }
   }
}

