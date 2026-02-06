package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class NftWardrobeItem
   {
      
      private var var_197:String;
      
      private var var_111:String;
      
      private var _figureString:String;
      
      private var var_3993:String;
      
      private var _contractKey:String;
      
      public function NftWardrobeItem(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readString();
         _figureString = param1.readString();
         var_111 = param1.readString();
         var_3993 = param1.readString();
         _contractKey = param1.readString();
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get contractKey() : String
      {
         return _contractKey;
      }
      
      public function get tokenId() : String
      {
         return var_3993;
      }
   }
}

