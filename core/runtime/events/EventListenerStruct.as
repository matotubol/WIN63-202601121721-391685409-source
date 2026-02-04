package com.sulake.core.runtime.events
{
   import flash.utils.Dictionary;
   
   public class EventListenerStruct
   {
      
      private var var_457:Dictionary;
      
      public var useCapture:Boolean;
      
      public var priority:int;
      
      public var useWeakReference:Boolean;
      
      public function EventListenerStruct(param1:Function, param2:Boolean = false, param3:int = 0, param4:Boolean = false)
      {
         super();
         var_457 = new Dictionary(param4);
         this.callback = param1;
         this.useCapture = param2;
         this.priority = param3;
         this.useWeakReference = param4;
      }
      
      public function set callback(param1:Function) : void
      {
         for(var _loc2_ in var_457)
         {
            delete var_457[_loc2_];
         }
         var_457[param1] = null;
      }
      
      public function get callback() : Function
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = var_457;
         for(var _loc1_ in _loc2_)
         {
            return _loc1_ as Function;
         }
         return null;
      }
   }
}

