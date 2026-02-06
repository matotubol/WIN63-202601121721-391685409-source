package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemStateUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_197:int = 0;
      
      private var var_1859:String;
      
      private var var_61:int;
      
      public function ItemStateUpdateMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get itemData() : String
      {
         return var_1859;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function flush() : Boolean
      {
         var_197 = 0;
         var_1859 = "";
         var_61 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_197 = param1.readInteger();
         var_1859 = param1.readString();
         var_61 = 0;
         var _loc2_:Number = parseFloat(var_1859);
         if(!isNaN(_loc2_))
         {
            var_61 = int(var_1859);
         }
         return true;
      }
   }
}

