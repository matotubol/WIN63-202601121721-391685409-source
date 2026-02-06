package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3647;
   
   [SecureSWF(rename="true")]
   public class ObjectUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_3647 = null;
      
      public function ObjectUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function get data() : class_3647
      {
         var _loc1_:class_3647 = var_24;
         if(_loc1_ != null)
         {
            _loc1_.setReadOnly();
         }
         return _loc1_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_24 = class_3692.parseObjectData(param1);
         return true;
      }
   }
}

