package com.sulake.habbo.friendbar
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboFriendBar extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function set visible(param1:Boolean) : void;
   }
}

