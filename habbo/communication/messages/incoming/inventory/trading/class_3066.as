package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_3065;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_3692;
   
   [SecureSWF(rename="true")]
   public class class_3066 implements class_3065
   {
      
      private var var_2626:int;
      
      private var var_3022:Boolean;
      
      private var var_2529:int;
      
      private var var_757:String;
      
      private var var_4032:int;
      
      private var var_4497:int;
      
      private var var_191:int;
      
      private var var_1966:IStuffData;
      
      private var var_3221:int;
      
      private var var_2008:int;
      
      private var var_3271:int;
      
      private var _creationMonth:int;
      
      private var var_2847:int;
      
      private var var_3930:Boolean;
      
      private var var_2766:int;
      
      private var _flatId:int;
      
      private var var_2823:Boolean;
      
      private var var_2587:Boolean;
      
      public function class_3066(param1:IMessageDataWrapper)
      {
         super();
         var_2529 = param1.readInteger();
         var_757 = param1.readString().toUpperCase();
         var_4032 = param1.readInteger();
         var_4497 = param1.readInteger();
         var_191 = param1.readInteger();
         var_3930 = param1.readBoolean();
         var_1966 = class_3692.parseStuffData(param1);
         var_2008 = -1;
         var_2626 = getTimer();
         var_2587 = false;
         var_3271 = param1.readInteger();
         _creationMonth = param1.readInteger();
         var_2847 = param1.readInteger();
         var_3221 = itemType == "S" ? param1.readInteger() : -1;
         _flatId = -1;
         var_2823 = false;
         var_3022 = var_757 == "I";
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
      
      public function get roomItemId() : int
      {
         return var_4032;
      }
      
      public function get itemTypeId() : int
      {
         return var_4497;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function get extra() : int
      {
         return var_3221;
      }
      
      public function get secondsToExpiration() : int
      {
         return var_2008;
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
      
      public function get isGroupable() : Boolean
      {
         return var_3930;
      }
      
      public function get songId() : int
      {
         return var_3221;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get isRented() : Boolean
      {
         return var_2823;
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
      
      public function get isRecyclable() : Boolean
      {
         return true;
      }
      
      public function get isTradeable() : Boolean
      {
         return true;
      }
      
      public function get isSellable() : Boolean
      {
         return true;
      }
      
      public function get slotId() : String
      {
         return null;
      }
      
      public function get isExternalImageFurni() : Boolean
      {
         return var_757.indexOf("external_image") != -1;
      }
   }
}

