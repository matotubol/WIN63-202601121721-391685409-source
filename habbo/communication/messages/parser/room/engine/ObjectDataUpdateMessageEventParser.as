package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.class_2108;
   
   [SecureSWF(rename="true")]
   public class ObjectDataUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_197:int = 0;
      
      private var var_61:int = 0;
      
      private var var_24:IStuffData;
      
      public function ObjectDataUpdateMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get data() : IStuffData
      {
         return var_24;
      }
      
      public function flush() : Boolean
      {
         var_61 = 0;
         var_24 = new class_2108() as IStuffData;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:String = param1.readString();
         var_197 = int(_loc3_);
         var_24 = class_3692.parseStuffData(param1);
         var _loc2_:Number = parseFloat(var_24.getLegacyString());
         if(!isNaN(_loc2_))
         {
            var_61 = int(var_24.getLegacyString());
         }
         return true;
      }
   }
}

