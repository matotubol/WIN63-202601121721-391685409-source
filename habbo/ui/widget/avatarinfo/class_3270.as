package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class class_3270
   {
      
      private var var_3084:Boolean = false;
      
      private var var_3290:Boolean = false;
      
      private var var_3037:int = 0;
      
      private var var_3356:Boolean = false;
      
      private var var_3269:Boolean = false;
      
      private var var_3287:Boolean = false;
      
      private var var_3189:Boolean = false;
      
      private var var_2753:Boolean = false;
      
      private var var_2831:Boolean = false;
      
      private var var_868:int = 0;
      
      private var var_2340:int = 0;
      
      private var var_2756:Boolean = false;
      
      private var var_3322:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_3274:int = 0;
      
      private var var_3205:int = 0;
      
      private var var_2873:int = 0;
      
      private var var_4262:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      private var var_996:Boolean = false;
      
      public function class_3270()
      {
         super();
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3084;
      }
      
      public function get canTrade() : Boolean
      {
         return var_3290;
      }
      
      public function get canTradeReason() : int
      {
         return var_3037;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_3356;
      }
      
      public function get canBeBanned() : Boolean
      {
         return var_3269;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_3189;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_2753;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_2831;
      }
      
      public function get respectLeft() : int
      {
         return var_868;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return var_2340;
      }
      
      public function get isOwnUser() : Boolean
      {
         return var_2756;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3322;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function get carryItemType() : int
      {
         return var_3274;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return var_3205;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return var_2873;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3084 = param1;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_3290 = param1;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_3037 = param1;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_3356 = param1;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         var_3269 = param1;
      }
      
      public function get canBeMuted() : Boolean
      {
         return var_3287;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         var_3287 = param1;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_3189 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_2753 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_2831 = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_868 = param1;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         var_2340 = param1;
      }
      
      public function set isOwnUser(param1:Boolean) : void
      {
         var_2756 = param1;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         var_3322 = param1;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         var_3274 = param1;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         var_3205 = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         var_2873 = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return var_4262;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function get isBlocked() : Boolean
      {
         return var_996;
      }
      
      public function populate(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var_2831 = param1.amIAnyRoomController;
         var_3205 = param1.myRoomControllerLevel;
         var_2753 = param1.amIOwner;
         var_3189 = param1.canBeAskedAsFriend;
         var_3356 = param1.canBeKicked;
         var_3269 = param1.canBeBanned;
         var_3287 = param1.canBeMuted;
         var_3290 = param1.canTrade;
         var_3037 = param1.canTradeReason;
         var_3084 = param1.isIgnored;
         var_868 = param1.respectLeft;
         var_2340 = param1.respectReplenishesLeft;
         var_2756 = param1.type == "RWUIUE_OWN_USER";
         var_3322 = param1.allowNameChange;
         _isGuildRoom = param1.isGuildRoom;
         var_2873 = param1.targetRoomControllerLevel;
         var_3274 = param1.carryItem;
         var_4262 = param1.isFriend;
         _isAmbassador = param1.amIAnAmbassador;
         var_996 = param1.isBlocked;
      }
   }
}

