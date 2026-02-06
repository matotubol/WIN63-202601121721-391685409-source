package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMessageEventParser implements IMessageParser
   {
      
      private var var_2529:int = 0;
      
      private var var_2760:int = -1;
      
      public function ItemRemoveMessageEventParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
      
      public function get pickerId() : int
      {
         return var_2760;
      }
      
      public function flush() : Boolean
      {
         var_2529 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2529 = int(param1.readString());
         var_2760 = param1.readInteger();
         return true;
      }
   }
}

