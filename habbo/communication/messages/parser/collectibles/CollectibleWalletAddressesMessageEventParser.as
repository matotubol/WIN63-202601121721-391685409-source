package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleWalletAddressesMessageEventParser implements IMessageParser
   {
      
      private var var_2068:String;
      
      private var var_667:Array;
      
      public function CollectibleWalletAddressesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2068 = null;
         var_667 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2068 = param1.readString();
         var_667 = [];
         if(var_2068 != "")
         {
            var_667.push(var_2068);
         }
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_667.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get walletAddresses() : Array
      {
         return var_667;
      }
      
      public function get stardustWalletAddress() : String
      {
         return var_2068;
      }
   }
}

