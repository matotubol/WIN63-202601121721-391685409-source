package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2138;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2368;
   
   [SecureSWF(rename="true")]
   public class ClubGiftInfoEventParser implements IMessageParser
   {
      
      private var var_3863:int;
      
      private var var_2402:int;
      
      private var _offers:Array;
      
      private var var_1628:class_55;
      
      public function ClubGiftInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_1628)
         {
            var_1628.dispose();
            var_1628 = null;
         }
         _offers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3863 = param1.readInteger();
         var_2402 = param1.readInteger();
         _offers = [];
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            _offers.push(new class_2138(param1));
            _loc4_++;
         }
         var_1628 = new class_55();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(0 < _loc3_)
         {
            var _loc2_:class_2368 = new class_2368(param1);
            var_1628.add(null.offerId,null);
            _loc4_++;
         }
         return true;
      }
      
      public function get daysUntilNextGift() : int
      {
         return var_3863;
      }
      
      public function get giftsAvailable() : int
      {
         return var_2402;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get giftData() : class_55
      {
         return var_1628;
      }
   }
}

