package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const OWN_USER:String = "RWUIUE_OWN_USER";
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const PEER:String = "RWUIUE_PEER";
      
      public static const TRADE_REASON_OK:int = 0;
      
      public static const TRADE_REASON_SHUTDOWN:int = 2;
      
      public static const TRADE_REASON_NO_TRADINGROOM:int = 3;
      
      public static const DEFAULT_BOT_BADGE_ID:String = "BOT";
      
      private var _name:String = "";
      
      private var var_3144:String = "";
      
      private var _achievementScore:int;
      
      private var var_3931:int = 0;
      
      private var var_4369:int = 0;
      
      private var var_3359:int;
      
      private var var_975:String = "";
      
      private var var_179:Array = [];
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var var_4214:String = "";
      
      private var var_4766:int = 0;
      
      private var var_3924:int = 0;
      
      private var var_2810:Boolean = false;
      
      private var _realName:String = "";
      
      private var var_3322:Boolean = false;
      
      private var var_2753:Boolean = false;
      
      private var var_2831:Boolean = false;
      
      private var var_3205:int = 0;
      
      private var var_3189:Boolean = false;
      
      private var var_3356:Boolean = false;
      
      private var var_3269:Boolean = false;
      
      private var var_3287:Boolean = false;
      
      private var var_868:int = 0;
      
      private var var_2340:int = 0;
      
      private var var_3084:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_3290:Boolean = false;
      
      private var var_3037:int = 0;
      
      private var var_2873:int = 0;
      
      private var var_4262:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      private var var_996:Boolean;
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set motto(param1:String) : void
      {
         var_3144 = param1;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set webID(param1:int) : void
      {
         var_3931 = param1;
      }
      
      public function get webID() : int
      {
         return var_3931;
      }
      
      public function set xp(param1:int) : void
      {
         var_4369 = param1;
      }
      
      public function get xp() : int
      {
         return var_4369;
      }
      
      public function set userType(param1:int) : void
      {
         var_3359 = param1;
      }
      
      public function get userType() : int
      {
         return var_3359;
      }
      
      public function set figure(param1:String) : void
      {
         var_975 = param1;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function set badges(param1:Array) : void
      {
         var_179 = param1;
      }
      
      public function get badges() : Array
      {
         return var_179;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_4214 = param1;
      }
      
      public function get groupBadgeId() : String
      {
         return var_4214;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_3189 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_3189;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_868 = param1;
      }
      
      public function get respectLeft() : int
      {
         return var_868;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return var_2340;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         var_2340 = param1;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3084 = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3084;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_2753 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_2753;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         var_3205 = param1;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return var_3205;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_2831 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_2831;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_3290 = param1;
      }
      
      public function get canTrade() : Boolean
      {
         return var_3290;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_3037 = param1;
      }
      
      public function get canTradeReason() : int
      {
         return var_3037;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_3356 = param1;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_3356;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         var_3269 = param1;
      }
      
      public function get canBeBanned() : Boolean
      {
         return var_3269;
      }
      
      public function get canBeMuted() : Boolean
      {
         return var_3287;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         var_3287 = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         var_2873 = param1;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return var_2873;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4766 = param1;
      }
      
      public function get carryItem() : int
      {
         return var_4766;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_3924 = param1;
      }
      
      public function get userRoomId() : int
      {
         return var_3924;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_2810 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_2810;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         var_3322 = param1;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3322;
      }
      
      public function get isFriend() : Boolean
      {
         return var_4262;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         var_4262 = param1;
      }
      
      public function get amIAnAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function set amIAnAmbassador(param1:Boolean) : void
      {
         _isAmbassador = param1;
      }
      
      public function get isBlocked() : Boolean
      {
         return var_996;
      }
      
      public function set isBlocked(param1:Boolean) : void
      {
         var_996 = param1;
      }
   }
}

