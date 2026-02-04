package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CollectibleItemClaim
   {
      
      public static var var_5260:int = 0;
      
      public static var var_5398:int = 1;
      
      private var var_3872:String;
      
      private var var_2748:int;
      
      private var var_4367:int;
      
      private var _status:int;
      
      public function CollectibleItemClaim(param1:IMessageDataWrapper)
      {
         super();
         var_3872 = param1.readString();
         var_2748 = param1.readInteger();
         var_4367 = param1.readInteger();
         _status = param1.readShort();
      }
      
      public function get claimId() : String
      {
         return var_3872;
      }
      
      public function get claimedAmount() : int
      {
         return var_2748;
      }
      
      public function set claimedAmount(param1:int) : void
      {
         var_2748 = param1;
      }
      
      public function get claimLimit() : int
      {
         return var_4367;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}

