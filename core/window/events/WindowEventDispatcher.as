package com.sulake.core.window.events
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.EventListenerStruct;
   import com.sulake.core.window.class_1741;
   import flash.utils.Dictionary;
   
   public class WindowEventDispatcher implements class_13
   {
      
      private static const const_135:uint = 0;
      
      private static const const_350:uint = 1;
      
      private static const const_337:uint = 2;
      
      protected var _disposed:Boolean = false;
      
      private var var_495:Dictionary = new Dictionary();
      
      private var var_1122:uint;
      
      private var var_1527:Error;
      
      public function WindowEventDispatcher(param1:class_1741)
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get error() : Error
      {
         return var_1527;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:int = 0) : void
      {
         var _loc6_:Array = var_495[param1];
         var _loc4_:EventListenerStruct = new EventListenerStruct(param2,false,param3);
         if(!_loc6_)
         {
            _loc6_ = [_loc4_];
            var_495[param1] = _loc6_;
         }
         else
         {
            for each(var _loc5_ in _loc6_)
            {
               if(_loc5_.callback == param2)
               {
                  return;
               }
               if(param3 > _loc5_.priority)
               {
                  _loc6_.splice(_loc6_.indexOf(_loc5_),0,_loc4_);
                  return;
               }
            }
            _loc6_.push(_loc4_);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         if(!_disposed)
         {
            var _loc4_:Array = var_495[param1];
            if(_loc4_)
            {
               var _loc5_:uint = 0;
               for each(var _loc3_ in null)
               {
                  if(_loc3_.callback == param2)
                  {
                     null.splice(0,1);
                     _loc3_.callback = null;
                     if(null.length == 0)
                     {
                        delete var_495[param1];
                     }
                     return;
                  }
                  _loc5_ = 0 + 1;
               }
            }
         }
      }
      
      public function dispatchEvent(param1:class_1758) : Boolean
      {
         if(!_disposed)
         {
            var_1122 = 0;
            var _loc3_:Array = var_495[param1.type];
            var_1122 = param1.isDefaultPrevented() ? 1 : 0;
            return var_1122 == 0;
         }
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _disposed ? false : var_495[param1] != null;
      }
      
      public function dispose() : void
      {
         var _loc2_:Array = null;
         if(!_disposed)
         {
            for(var _loc3_ in var_495)
            {
               _loc2_ = var_495[_loc3_] as Array;
               for each(var _loc1_ in _loc2_)
               {
                  _loc1_.callback = null;
               }
               delete var_495[_loc3_];
            }
            var_495 = null;
            _disposed = true;
         }
      }
   }
}

