package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeSelectionMessageEventParser implements IMessageParser
   {
      
      private var var_2045:String;
      
      private var var_3257:String;
      
      private var var_3001:String;
      
      public function UserNftWardrobeSelectionMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3257 = "";
         var_3001 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2045 = param1.readString();
         var_3257 = param1.readString();
         var_3001 = param1.readString();
         return true;
      }
      
      public function get currentTokenId() : String
      {
         return var_2045;
      }
      
      public function get fallbackFigureString() : String
      {
         return var_3257;
      }
      
      public function get fallbackFigureGender() : String
      {
         return var_3001;
      }
   }
}

