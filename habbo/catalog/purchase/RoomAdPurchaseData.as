package com.sulake.habbo.catalog.purchase
{
   public class RoomAdPurchaseData
   {
      
      private var _name:String;
      
      private var var_735:String = "";
      
      private var _flatId:int;
      
      private var _offerId:int;
      
      private var _extended:Boolean;
      
      private var var_2945:int;
      
      private var _roomName:String;
      
      private var _expirationTime:Date;
      
      private var var_2851:int = -1;
      
      public function RoomAdPurchaseData()
      {
         super();
      }
      
      public function clear() : void
      {
         _name = null;
         var_735 = "";
         _flatId = 0;
         _extended = false;
         _roomName = null;
         var_2945 = -1;
         var_2851 = -1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function set flatId(param1:int) : void
      {
         _flatId = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function set offerId(param1:int) : void
      {
         _offerId = param1;
      }
      
      public function get extended() : Boolean
      {
         return _extended;
      }
      
      public function get extendedFlatId() : int
      {
         return var_2945;
      }
      
      public function set extendedFlatId(param1:int) : void
      {
         var_2945 = param1;
      }
      
      public function set extended(param1:Boolean) : void
      {
         _extended = param1;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function get expirationTime() : Date
      {
         return _expirationTime;
      }
      
      public function set expirationTime(param1:Date) : void
      {
         _expirationTime = param1;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_2851 = param1;
      }
   }
}

