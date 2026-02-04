package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.session.IRoomHandlerListener;
   
   public class BaseHandler implements class_13
   {
      
      private var var_37:IConnection;
      
      private var var_254:IRoomHandlerListener;
      
      private var _disposed:Boolean = false;
      
      public var var_56:int;
      
      public function BaseHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super();
         var_37 = param1;
         var_254 = param2;
      }
      
      public function dispose() : void
      {
         var_37 = null;
         var_254 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get connection() : IConnection
      {
         return var_37;
      }
      
      public function get listener() : IRoomHandlerListener
      {
         return var_254;
      }
   }
}

