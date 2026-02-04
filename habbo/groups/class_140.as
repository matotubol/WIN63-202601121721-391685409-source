package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface class_140 extends IUnknown
   {
      
      function showGroupBadgeInfo(param1:Boolean, param2:int) : void;
      
      function openGroupInfo(param1:int) : void;
      
      function updateVisibleExtendedProfile(param1:int) : void;
      
      function showExtendedProfile(param1:int) : void;
      
      function get events() : IEventDispatcher;
   }
}

