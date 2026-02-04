package com.sulake.core.window.utils
{
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.graphics.class_1770;
   
   public class EventProcessorState
   {
      
      public var renderer:class_1770;
      
      public var desktop:class_2052;
      
      public var var_2974:class_1741;
      
      public var lastClickTarget:class_1741;
      
      public var lastMouseDownTarget:class_1741;
      
      public var var_4295:class_1741;
      
      public var eventTrackers:Vector.<IInputEventTracker>;
      
      public function EventProcessorState(param1:class_1770, param2:class_2052, param3:class_1741, param4:class_1741, param5:class_1741, param6:class_1741, param7:Vector.<IInputEventTracker>)
      {
         super();
         this.renderer = param1;
         this.desktop = param2;
         this.var_2974 = param3;
         this.lastClickTarget = param4;
         this.lastMouseDownTarget = param5;
         this.var_4295 = param6;
         this.eventTrackers = param7;
      }
   }
}

