package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2681
   {
      
      private var _offerId:int;
      
      private var var_1275:String;
      
      private var var_3955:Boolean;
      
      private var var_1957:int;
      
      private var var_1865:int;
      
      private var var_2381:int;
      
      private var var_2971:int;
      
      private var var_3748:Boolean;
      
      private var var_4476:Boolean;
      
      private var var_375:Vector.<class_2104>;
      
      public function class_2681(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         var_1275 = param1.readString();
         var_3955 = param1.readBoolean();
         var_1957 = param1.readInteger();
         var_1865 = param1.readInteger();
         var_2381 = param1.readInteger();
         var_3748 = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         var_375 = new Vector.<class_2104>(0);
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_375.push(new class_2104(param1));
            _loc2_++;
         }
         var_2971 = param1.readInteger();
         var_4476 = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get localizationId() : String
      {
         return var_1275;
      }
      
      public function get isRent() : Boolean
      {
         return var_3955;
      }
      
      public function get priceInCredits() : int
      {
         return var_1957;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_1865;
      }
      
      public function get products() : Vector.<class_2104>
      {
         return var_375;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get giftable() : Boolean
      {
         return var_3748;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return var_4476;
      }
   }
}

