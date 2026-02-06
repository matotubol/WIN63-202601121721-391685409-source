package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStyleChangedMessageEventParser implements IMessageParser
   {
      
      private var var_3226:Boolean;
      
      private var var_3109:int;
      
      public function UserPurchasableChatStyleChangedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3226 = false;
         var_3109 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3226 = param1.readBoolean();
         var_3109 = param1.readInteger();
         return true;
      }
      
      public function get added() : Boolean
      {
         return var_3226;
      }
      
      public function get styleId() : int
      {
         return var_3109;
      }
   }
}

