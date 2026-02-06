package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftBonusItemClaimResultMessageEventParser implements IMessageParser
   {
      
      private var var_3844:String;
      
      private var var_4102:String;
      
      private var var_2614:Boolean;
      
      public function NftBonusItemClaimResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3844 = param1.readString();
         var_4102 = param1.readString();
         var_2614 = param1.readBoolean();
         return true;
      }
      
      public function get collectionId() : String
      {
         return var_3844;
      }
      
      public function get walletAddress() : String
      {
         return var_4102;
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
   }
}

