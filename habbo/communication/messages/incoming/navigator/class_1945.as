package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_1945 implements class_13
   {
      
      private const const_1029:int = 1;
      
      private const const_888:int = 2;
      
      private const const_713:int = 4;
      
      private const const_983:int = 8;
      
      private const const_299:int = 16;
      
      private const const_406:int = 32;
      
      private var _flatId:int;
      
      private var _roomName:String;
      
      private var var_4237:Boolean;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_4157:int;
      
      private var var_3244:int;
      
      private var var_3878:int;
      
      private var var_735:String;
      
      private var var_2859:int;
      
      private var var_808:int;
      
      private var var_3879:int;
      
      private var var_2851:int;
      
      private var var_5396:int;
      
      private var var_4216:int = 0;
      
      private var _groupName:String = "";
      
      private var var_5025:String = "";
      
      private var var_553:Array = [];
      
      private var var_3664:class_3354;
      
      private var var_4615:Boolean;
      
      private var var_4657:Boolean;
      
      private var var_4567:String = "";
      
      private var var_4808:String = "";
      
      private var var_4052:int = 0;
      
      private var var_4688:Boolean;
      
      private var var_4753:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_3986:String = null;
      
      public function class_1945(param1:IMessageDataWrapper)
      {
         super();
         _flatId = param1.readInteger();
         _roomName = param1.readString();
         var_1820 = param1.readInteger();
         _ownerName = param1.readString();
         var_4157 = param1.readInteger();
         var_3244 = param1.readInteger();
         var_3878 = param1.readInteger();
         var_735 = param1.readString();
         var_2859 = param1.readInteger();
         var_808 = param1.readInteger();
         var_3879 = param1.readInteger();
         var_2851 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc5_:String = param1.readString();
            var_553.push(null);
            _loc4_++;
         }
         var _loc2_:int = param1.readInteger();
         if((_loc2_ & 1) > 0)
         {
            var_3986 = param1.readString();
         }
         if((_loc2_ & 2) > 0)
         {
            var_4216 = param1.readInteger();
            _groupName = param1.readString();
            var_5025 = param1.readString();
         }
         if((_loc2_ & 4) > 0)
         {
            var_4567 = param1.readString();
            var_4808 = param1.readString();
            var_4052 = param1.readInteger();
         }
         var_4237 = (_loc2_ & 8) > 0;
         var_4615 = (_loc2_ & 0x10) > 0;
         var_4657 = (_loc2_ & 0x20) > 0;
         var_3664 = new class_3354(null);
         var_3664.setDefaults();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_553 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get showOwner() : Boolean
      {
         return var_4237;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get doorMode() : int
      {
         return var_4157;
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
      
      public function get maxUserCount() : int
      {
         return var_3878;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get tradeMode() : int
      {
         return var_2859;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get ranking() : int
      {
         return var_3879;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get habboGroupId() : int
      {
         return var_4216;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupBadgeCode() : String
      {
         return var_5025;
      }
      
      public function get tags() : Array
      {
         return var_553;
      }
      
      public function get thumbnail() : class_3354
      {
         return var_3664;
      }
      
      public function get allowPets() : Boolean
      {
         return var_4615;
      }
      
      public function get displayRoomEntryAd() : Boolean
      {
         return var_4657;
      }
      
      public function get roomAdName() : String
      {
         return var_4567;
      }
      
      public function get roomAdDescription() : String
      {
         return var_4808;
      }
      
      public function get roomAdExpiresInMin() : int
      {
         return var_4052;
      }
      
      public function get allInRoomMuted() : Boolean
      {
         return var_4688;
      }
      
      public function get officialRoomPicRef() : String
      {
         return var_3986;
      }
      
      public function set allInRoomMuted(param1:Boolean) : void
      {
         var_4688 = param1;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function get canMute() : Boolean
      {
         return var_4753;
      }
      
      public function set canMute(param1:Boolean) : void
      {
         var_4753 = param1;
      }
   }
}

