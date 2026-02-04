package com.sulake.core.communication
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.class_58;
   import com.sulake.core.runtime.IUnknown;
   
   public interface class_43 extends IUnknown
   {
      
      function createConnection(param1:class_58 = null) : IConnection;
   }
}

