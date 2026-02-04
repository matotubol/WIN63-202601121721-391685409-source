package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const RENTABLE_BOT:String = "RWRBIUE_RENTABLE_BOT";
      
      public static const DEFAULT_BOT_BADGE_ID:String = "RENTABLE_BOT";
      
      private var _name:String = "";
      
      private var var_3144:String = "";
      
      private var var_3931:int = 0;
      
      private var var_975:String = "";
      
      private var var_179:Array = [];
      
      private var var_4766:int = 0;
      
      private var var_3924:int = 0;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_2753:Boolean = false;
      
      private var var_2831:Boolean = false;
      
      private var var_3205:int = 0;
      
      private var _botSkills:Array;
      
      public function RoomWidgetRentableBotInfoUpdateEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("RWRBIUE_RENTABLE_BOT",param1,param2);
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
      
      public function set webID(param1:int) : void
      {
         var_3931 = param1;
      }
      
      public function get webID() : int
      {
         return var_3931;
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
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_1820 = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_2753 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_2753;
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
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
   }
}

