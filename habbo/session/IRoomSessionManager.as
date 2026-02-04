package com.sulake.habbo.session
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IRoomSessionManager extends IUnknown
   {
      
      function gotoRoom(param1:int, param2:String = "", param3:String = "", param4:Boolean = false) : Boolean;
      
      function gotoRoomNetwork(param1:int, param2:int) : Boolean;
      
      function startSession(param1:IRoomSession) : Boolean;
      
      function getSession(param1:int) : IRoomSession;
      
      function get events() : IEventDispatcher;
      
      function get sessionStarting() : Boolean;
      
      function startGameSession() : void;
      
      function disposeGameSession() : void;
      
      function disposeSession(param1:int, param2:Boolean = true) : void;
   }
}

