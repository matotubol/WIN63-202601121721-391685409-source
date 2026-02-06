package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemDataUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_197:int = 0;
      
      private var var_1859:String;
      
      public function ItemDataUpdateMessageEventParser()
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
      
      public function flush() : Boolean
      {
         var_197 = 0;
         var_1859 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = param1.readString();
         var_197 = int(_loc2_);
         var_1859 = param1.readString();
         return true;
      }
   }
}

