package com.sulake.habbo.advertisement
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface class_56 extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function showInterstitial() : void;
      
      function loadRoomAdImage(param1:int, param2:int, param3:int, param4:String, param5:String) : void;
   }
}

