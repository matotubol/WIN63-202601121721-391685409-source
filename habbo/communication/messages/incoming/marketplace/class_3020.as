package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.habbo.room.IStuffData;
   
   [SecureSWF(rename="true")]
   public class class_3020
   {
      
      private var _offerId:int;
      
      private var var_2536:int;
      
      private var var_4744:int;
      
      private var var_4005:String;
      
      private var var_1966:IStuffData;
      
      private var var_3071:int;
      
      private var _status:int;
      
      private var var_4015:int = -1;
      
      private var var_3961:int;
      
      private var _offerCount:int;
      
      public function class_3020(param1:int, param2:int, param3:int, param4:String, param5:IStuffData, param6:int, param7:int, param8:int, param9:int, param10:int = -1)
      {
         super();
         _offerId = param1;
         var_2536 = param2;
         var_4744 = param3;
         var_4005 = param4;
         var_1966 = param5;
         var_3071 = param6;
         _status = param7;
         var_4015 = param8;
         var_3961 = param9;
         _offerCount = param10;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get furniType() : int
      {
         return var_4744;
      }
      
      public function get extraData() : String
      {
         return var_4005;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function get price() : int
      {
         return var_3071;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get timeLeftMinutes() : int
      {
         return var_4015;
      }
      
      public function get averagePrice() : int
      {
         return var_3961;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
   }
}

