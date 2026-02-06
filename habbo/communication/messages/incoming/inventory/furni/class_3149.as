package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_3692;
   
   [SecureSWF(rename="true")]
   public class class_3149 implements class_3065
   {
      
      private static const const_1173:String = "I";
      
      private static const const_752:String = "S";
      
      private var var_2823:Boolean;
      
      private var var_2529:int;
      
      private var var_757:String;
      
      private var var_4032:int;
      
      private var var_4497:int;
      
      private var var_191:int;
      
      private var var_1966:IStuffData;
      
      private var var_3930:Boolean;
      
      private var var_4959:Boolean;
      
      private var var_5126:Boolean;
      
      private var var_4006:Boolean;
      
      private var var_2008:int;
      
      private var var_3221:int;
      
      private var _flatId:int;
      
      private var var_3022:Boolean;
      
      private var var_2587:Boolean;
      
      private var var_2626:int;
      
      private var var_2895:String = "";
      
      private var var_2766:int = -1;
      
      public function class_3149(param1:IMessageDataWrapper)
      {
         super();
         var_2529 = param1.readInteger();
         var_757 = param1.readString();
         var_4032 = param1.readInteger();
         var_4497 = param1.readInteger();
         var_191 = param1.readInteger();
         var_1966 = class_3692.parseStuffData(param1);
         var_4959 = param1.readBoolean();
         var_5126 = param1.readBoolean();
         var_3930 = param1.readBoolean();
         var_4006 = param1.readBoolean();
         var_2008 = param1.readInteger();
         var_2626 = getTimer();
         if(secondsToExpiration > -1)
         {
            var_2823 = true;
         }
         else
         {
            var_2823 = false;
            var_2008 = -1;
         }
         var_2587 = param1.readBoolean();
         _flatId = param1.readInteger();
         var_3022 = var_757 == "I";
         if(var_757 == "S")
         {
            var_2895 = param1.readString();
            var_3221 = param1.readInteger();
         }
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
      
      public function get isGroupable() : Boolean
      {
         return var_3930;
      }
      
      public function get isRecyclable() : Boolean
      {
         return var_4959;
      }
      
      public function get isTradeable() : Boolean
      {
         return var_5126;
      }
      
      public function get isSellable() : Boolean
      {
         return var_4006;
      }
      
      public function get secondsToExpiration() : int
      {
         return var_2008;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get slotId() : String
      {
         return var_2895;
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get extra() : int
      {
         return var_3221;
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
      
      public function get creationDay() : int
      {
         return 0;
      }
      
      public function get creationMonth() : int
      {
         return 0;
      }
      
      public function get creationYear() : int
      {
         return 0;
      }
      
      public function get isExternalImageFurni() : Boolean
      {
         return var_757.indexOf("external_image") != -1;
      }
   }
}

