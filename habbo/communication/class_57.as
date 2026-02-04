package com.sulake.habbo.communication
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.handshake.class_1986;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface class_57 extends IUnknown
   {
      
      function disconnect() : void;
      
      function get connection() : IConnection;
      
      function get mode() : int;
      
      function get suggestedLoginActions() : Array;
      
      function set suggestedLoginActions(param1:Array) : void;
      
      function set mode(param1:int) : void;
      
      function set tcpNoDelay(param1:Boolean) : void;
      
      function get port() : int;
      
      function updateHostParameters() : void;
      
      function initConnection(param1:String) : void;
      
      function renewSocket() : void;
      
      function addHabboConnectionMessageEvent(param1:IMessageEvent) : IMessageEvent;
      
      function removeHabboConnectionMessageEvent(param1:IMessageEvent) : void;
      
      function initializeEncryption() : IEncryption;
      
      function initializeKeyExchange(param1:BigInteger, param2:BigInteger) : class_1986;
      
      function setMessageQueueErrorDebugData() : void;
      
      function createHabboWebApiSession(param1:class_261, param2:String) : class_2079;
      
      function getHabboWebApiSession() : class_2079;
      
      function resetHabboWebApiSession() : void;
      
      function get events() : IEventDispatcher;
   }
}

