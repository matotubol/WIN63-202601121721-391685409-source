package com.sulake.habbo.advertisement.events
{
   import flash.events.Event;
   
   public class InterstitialEvent extends Event
   {
      
      public static const INTERSTITIAL_SHOW:String = "AE_INTERSTITIAL_SHOW";
      
      public static const INTERSTITIAL_NOT_SHOWN:String = "AE_INTERSTITIAL_NOT_SHOWN";
      
      public static const INTERSTITIAL_COMPLETE:String = "AE_INTERSTITIAL_COMPLETE";
      
      private var _status:String;
      
      public function InterstitialEvent(param1:String, param2:String = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _status = param2;
      }
      
      public function get status() : String
      {
         return _status;
      }
   }
}

