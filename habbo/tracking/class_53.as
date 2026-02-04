package com.sulake.habbo.tracking
{
   import com.sulake.core.runtime.IUnknown;
   
   public interface class_53 extends IUnknown
   {
      
      function trackGoogle(param1:String, param2:String, param3:int = -1) : void;
      
      function legacyTrackGoogle(param1:String, param2:String, param3:Array = null) : void;
      
      function logError(param1:String) : void;
      
      function chatLagDetected(param1:int) : void;
      
      function trackEventLog(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0) : void;
      
      function trackEventLogOncePerSession(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0) : void;
      
      function trackTalentTrackOpen(param1:String, param2:String) : void;
   }
}

