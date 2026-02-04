package com.sulake.habbo.utils.air
{
   import flash.events.IEventDispatcher;
   
   public interface INativeApplicationProxy extends IEventDispatcher
   {
      
      function dispose() : void;
      
      function allowBackgroundExecution(param1:Boolean) : void;
   }
}

