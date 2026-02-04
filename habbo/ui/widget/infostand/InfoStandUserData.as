package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class InfoStandUserData
   {
      
      private var var_1270:int = 0;
      
      private var _userName:String = "";
      
      private var var_179:Array = [];
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var var_4214:String = "";
      
      private var var_868:int = 0;
      
      private var var_2340:int = 0;
      
      private var var_4766:int = 0;
      
      private var var_3924:int = 0;
      
      private var var_230:String;
      
      private var var_1113:int = 0;
      
      public function InfoStandUserData()
      {
         super();
      }
      
      public function set userId(param1:int) : void
      {
         var_1270 = param1;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_179 = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_4214 = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_868 = param1;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         var_2340 = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4766 = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_3924 = param1;
      }
      
      public function set type(param1:String) : void
      {
         var_230 = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         var_1113 = param1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get badges() : Array
      {
         return var_179.slice();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupBadgeId() : String
      {
         return var_4214;
      }
      
      public function get respectLeft() : int
      {
         return var_868;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return var_2340;
      }
      
      public function get carryItem() : int
      {
         return var_4766;
      }
      
      public function get userRoomId() : int
      {
         return var_3924;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1113;
      }
      
      public function isBot() : Boolean
      {
         return type == "RWUIUE_BOT";
      }
      
      public function setData(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userId = param1.webID;
         userName = param1.name;
         badges = param1.badges;
         groupId = param1.groupId;
         groupName = param1.groupName;
         groupBadgeId = param1.groupBadgeId;
         respectLeft = param1.respectLeft;
         respectReplenishesLeft = param1.respectReplenishesLeft;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         type = param1.type;
      }
   }
}

