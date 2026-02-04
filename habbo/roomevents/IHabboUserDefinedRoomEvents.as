package com.sulake.habbo.roomevents
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboUserDefinedRoomEvents extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function stuffSelected(param1:int) : void;
      
      function userSelected(param1:int) : void;
      
      function showInspectButton() : Boolean;
      
      function showToolbarMenuButton() : Boolean;
      
      function get wiredWhisperDisabled() : Boolean;
      
      function set wiredWhisperDisabled(param1:Boolean) : void;
      
      function hasClickUserWired() : Boolean;
      
      function switchPlayTestMode() : void;
      
      function resetCache() : void;
   }
}

