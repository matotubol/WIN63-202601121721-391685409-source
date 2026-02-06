package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BonusRareInfoMessageEventParser implements IMessageParser
   {
      
      private var var_576:String;
      
      private var var_3320:int;
      
      private var _totalCoinsForBonus:int;
      
      private var var_3048:int;
      
      public function BonusRareInfoMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _totalCoinsForBonus = -1;
         var_3048 = -1;
         var_576 = "";
         var_3320 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_576 = param1.readString();
         var_3320 = param1.readInteger();
         _totalCoinsForBonus = param1.readInteger();
         var_3048 = param1.readInteger();
         return true;
      }
      
      public function get totalCoinsForBonus() : int
      {
         return _totalCoinsForBonus;
      }
      
      public function get coinsStillRequiredToBuy() : int
      {
         return var_3048;
      }
      
      public function get productType() : String
      {
         return var_576;
      }
      
      public function get productClassId() : int
      {
         return var_3320;
      }
   }
}

