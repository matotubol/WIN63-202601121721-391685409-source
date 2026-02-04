package com.sulake.habbo.session
{
   import flash.events.IEventDispatcher;
   
   public interface IRoomHandlerListener
   {
      
      function sessionUpdate(param1:int, param2:String) : void;
      
      function sessionReinitialize(param1:int, param2:int) : void;
      
      function getSession(param1:int) : IRoomSession;
      
      function get events() : IEventDispatcher;
   }
}

