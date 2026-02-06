package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LimitedOfferAppearingNextMessageEventParser implements IMessageParser
   {
      
      private var var_3006:int;
      
      private var var_2228:int;
      
      private var _offerId:int;
      
      private var var_576:String;
      
      public function LimitedOfferAppearingNextMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3006 = -1;
         var_2228 = -1;
         _offerId = -1;
         var_576 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3006 = param1.readInteger();
         var_2228 = param1.readInteger();
         _offerId = param1.readInteger();
         var_576 = param1.readString();
         return true;
      }
      
      public function get appearsInSeconds() : int
      {
         return var_3006;
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productType() : String
      {
         return var_576;
      }
   }
}

