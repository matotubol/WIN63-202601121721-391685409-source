package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3157;
   
   [SecureSWF(rename="true")]
   public class ItemUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_452:class_3157 = null;
      
      public function ItemUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_452 = null;
         return true;
      }
      
      public function get data() : class_3157
      {
         var _loc1_:class_3157 = var_452;
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
         var_452 = class_4043.parseItemData(param1);
         return true;
      }
   }
}

