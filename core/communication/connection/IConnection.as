package com.sulake.core.communication.connection
{
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageEvent;
   import flash.events.IEventDispatcher;
   
   public interface IConnection extends IEventDispatcher
   {
      
      function dispose() : void;
      
      function get disposed() : Boolean;
      
      function init(param1:String, param2:uint = 0, param3:Boolean = true) : Boolean;
      
      function set timeout(param1:int) : void;
      
      function send(param1:IMessageComposer) : Boolean;
      
      function sendUnencrypted(param1:IMessageComposer) : Boolean;
      
      function setEncryption(param1:IEncryption, param2:IEncryption) : void;
      
      function getServerToClientEncryption() : IEncryption;
      
      function registerMessageClasses(param1:IMessageConfiguration) : void;
      
      function addMessageEvent(param1:IMessageEvent) : void;
      
      function removeMessageEvent(param1:IMessageEvent) : void;
      
      function processReceivedData() : void;
      
      function get connected() : Boolean;
      
      function close() : void;
      
      function isAuthenticated() : void;
      
      function isConfigured() : void;
      
      function createSocket() : void;
      
      function addListener(param1:String, param2:Function) : void;
   }
}

