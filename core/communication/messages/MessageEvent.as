package com.sulake.core.communication.messages
{
   import com.sulake.core.communication.connection.IConnection;
   
   public class MessageEvent implements IMessageEvent
   {
      
      protected var _callback:Function;
      
      protected var var_37:IConnection;
      
      private var var_3327:Class;
      
      protected var var_15:IMessageParser;
      
      public function MessageEvent(param1:Function, param2:Class)
      {
         super();
         _callback = param1;
         var_3327 = param2;
      }
      
      public function dispose() : void
      {
         _callback = null;
         var_3327 = null;
         var_37 = null;
         var_15 = null;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_37 = param1;
      }
      
      public function get connection() : IConnection
      {
         return var_37;
      }
      
      public function get parserClass() : Class
      {
         return var_3327;
      }
      
      public function get parser() : IMessageParser
      {
         return var_15;
      }
      
      public function set parser(param1:IMessageParser) : void
      {
         var_15 = param1;
      }
   }
}

