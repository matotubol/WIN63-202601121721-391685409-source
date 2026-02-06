package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenCountMessageEventParser implements IMessageParser
   {
      
      private var var_2942:int = 0;
      
      public function CollectibleMintTokenCountMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2942 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2942 = param1.readInteger();
         return true;
      }
      
      public function get totalTokens() : int
      {
         return var_2942;
      }
   }
}

