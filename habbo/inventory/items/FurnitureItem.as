package com.sulake.habbo.inventory.items
{
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_3065;
   
   public class FurnitureItem implements class_1875
   {
      
      private var var_2626:int;
      
      private var var_3022:Boolean;
      
      private var var_2766:int;
      
      private var var_1613:Boolean;
      
      private var var_197:int;
      
      private var var_2856:int;
      
      private var var_191:int;
      
      private var var_230:int;
      
      private var var_1966:IStuffData;
      
      private var var_3221:Number;
      
      private var var_3352:Boolean;
      
      private var var_3092:Boolean;
      
      private var var_2881:Boolean;
      
      private var var_3034:Boolean;
      
      private var var_2008:int;
      
      private var var_2587:Boolean;
      
      private var var_3271:int;
      
      private var _creationMonth:int;
      
      private var var_2847:int;
      
      private var var_2895:String;
      
      private var var_2823:Boolean;
      
      private var _flatId:int;
      
      public function FurnitureItem(param1:class_3065)
      {
         super();
         var_197 = param1.itemId;
         var_230 = param1.itemTypeId;
         var_2856 = param1.roomItemId;
         var_191 = param1.category;
         var_2881 = param1.isGroupable && !param1.isRented;
         var_3092 = param1.isTradeable;
         var_3352 = param1.isRecyclable;
         var_3034 = param1.isSellable;
         var_1966 = param1.stuffData;
         var_3221 = param1.extra;
         var_2008 = param1.secondsToExpiration;
         var_2626 = param1.expirationTimeStamp;
         var_2587 = param1.hasRentPeriodStarted;
         var_3271 = param1.creationDay;
         _creationMonth = param1.creationMonth;
         var_2847 = param1.creationYear;
         var_2895 = param1.slotId;
         var_2766 = param1.songId;
         _flatId = param1.flatId;
         var_2823 = param1.isRented;
         var_3022 = param1.isWallItem;
      }
      
      public function get isRented() : Boolean
      {
         return var_2823;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get ref() : int
      {
         return var_2856;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1966 = param1;
      }
      
      public function get extra() : Number
      {
         return var_3221;
      }
      
      public function get recyclable() : Boolean
      {
         return var_3352;
      }
      
      public function get tradeable() : Boolean
      {
         return var_3092;
      }
      
      public function get groupable() : Boolean
      {
         return var_2881;
      }
      
      public function get sellable() : Boolean
      {
         return var_3034;
      }
      
      public function get secondsToExpiration() : int
      {
         if(var_2008 == -1)
         {
            return -1;
         }
         var _loc1_:int = -1;
         if(var_2587)
         {
            _loc1_ = var_2008 - (getTimer() - var_2626) / 1000;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
         }
         else
         {
            _loc1_ = var_2008;
         }
         return _loc1_;
      }
      
      public function get creationDay() : int
      {
         return var_3271;
      }
      
      public function get creationMonth() : int
      {
         return _creationMonth;
      }
      
      public function get creationYear() : int
      {
         return var_2847;
      }
      
      public function get slotId() : String
      {
         return var_2895;
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get locked() : Boolean
      {
         return var_1613;
      }
      
      public function set locked(param1:Boolean) : void
      {
         var_1613 = param1;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_3022;
      }
      
      public function get hasRentPeriodStarted() : Boolean
      {
         return var_2587;
      }
      
      public function get expirationTimeStamp() : int
      {
         return var_2626;
      }
      
      public function update(param1:class_3065) : void
      {
         var_230 = param1.itemTypeId;
         var_2856 = param1.roomItemId;
         var_191 = param1.category;
         var_2881 = param1.isGroupable && !param1.isRented;
         var_3092 = param1.isTradeable;
         var_3352 = param1.isRecyclable;
         var_3034 = param1.isSellable;
         var_1966 = param1.stuffData;
         var_3221 = param1.extra;
         var_2008 = param1.secondsToExpiration;
         var_2626 = param1.expirationTimeStamp;
         var_2587 = param1.hasRentPeriodStarted;
         var_3271 = param1.creationDay;
         _creationMonth = param1.creationMonth;
         var_2847 = param1.creationYear;
         var_2895 = param1.slotId;
         var_2766 = param1.songId;
         _flatId = param1.flatId;
         var_2823 = param1.isRented;
         var_3022 = param1.isWallItem;
      }
   }
}

