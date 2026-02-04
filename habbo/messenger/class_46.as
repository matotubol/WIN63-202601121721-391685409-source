package com.sulake.habbo.messenger
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface class_46 extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function isOpen() : Boolean;
      
      function toggleMessenger() : void;
      
      function startConversation(param1:int) : void;
      
      function closeConversation(param1:int) : void;
      
      function setFollowingAllowed(param1:int, param2:Boolean) : void;
      
      function setOnlineStatus(param1:int, param2:Boolean) : void;
      
      function getUnseenMiniMailMessageCount() : int;
      
      function getRoomInvitesIgnored() : Boolean;
      
      function setRoomInvitesIgnored(param1:Boolean) : void;
      
      function set followingToGroupRoom(param1:Boolean) : void;
   }
}

