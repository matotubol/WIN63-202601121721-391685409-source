package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class MarketPlaceOfferData implements IMarketPlaceOfferData
   {
      
      public static const const_75:int = 1;
      
      public static const const_84:int = 2;
      
      private var _offerId:int;
      
      private var var_2536:int;
      
      private var var_4744:int;
      
      private var var_4005:String;
      
      private var var_1966:IStuffData;
      
      private var var_3071:int;
      
      private var var_3961:int;
      
      private var _imageCallback:int;
      
      private var _status:int;
      
      private var var_4015:int = -1;
      
      private var _offerCount:int;
      
      private var var_48:BitmapData;
      
      public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:IStuffData, param6:int, param7:int, param8:int, param9:int = -1)
      {
         super();
         _offerId = param1;
         var_2536 = param2;
         var_4744 = param3;
         var_4005 = param4;
         var_1966 = param5;
         var_3071 = param6;
         _status = param7;
         var_3961 = param8;
         _offerCount = param9;
      }
      
      public function dispose() : void
      {
         if(var_48)
         {
            var_48.dispose();
            var_48 = null;
         }
         if(var_1966)
         {
            var_1966 = null;
         }
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
      
      public function get averagePrice() : int
      {
         return var_3961;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function set image(param1:BitmapData) : void
      {
         if(var_48 != null)
         {
            var_48.dispose();
         }
         var_48 = param1;
      }
      
      public function set imageCallback(param1:int) : void
      {
         _imageCallback = param1;
      }
      
      public function get imageCallback() : int
      {
         return _imageCallback;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get timeLeftMinutes() : int
      {
         return var_4015;
      }
      
      public function set timeLeftMinutes(param1:int) : void
      {
         var_4015 = param1;
      }
      
      public function set price(param1:int) : void
      {
         var_3071 = param1;
      }
      
      public function set offerId(param1:int) : void
      {
         _offerId = param1;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
      
      public function set offerCount(param1:int) : void
      {
         _offerCount = param1;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return stuffData != null && stuffData.uniqueSerialNumber > 0;
      }
   }
}

