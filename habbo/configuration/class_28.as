package com.sulake.habbo.configuration
{
   import com.sulake.core.runtime.class_16;
   import flash.events.IEventDispatcher;
   
   public interface class_28 extends class_16
   {
      
      function isInitialized() : Boolean;
      
      function updateEnvironmentId(param1:String) : void;
      
      function resetAll() : void;
      
      function initConfigurationDownload() : void;
      
      function get events() : IEventDispatcher;
   }
}

