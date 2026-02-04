package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   
   public class InfoStandRentableBotData
   {
      
      private var var_1270:int = 0;
      
      private var _name:String = "";
      
      private var var_179:Array = [];
      
      private var var_4766:int = 0;
      
      private var var_3924:int = 0;
      
      private var var_2753:Boolean;
      
      private var var_2831:Boolean;
      
      private var _botSkills:Array;
      
      public function InfoStandRentableBotData()
      {
         super();
      }
      
      public function set userId(param1:int) : void
      {
         var_1270 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_179 = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4766 = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_3924 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_2753 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_2831 = param1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get badges() : Array
      {
         return var_179.slice();
      }
      
      public function get carryItem() : int
      {
         return var_4766;
      }
      
      public function get userRoomId() : int
      {
         return var_3924;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_2753;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_2831;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function setData(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         userId = param1.webID;
         name = param1.name;
         badges = param1.badges;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         botSkills = param1.botSkills;
      }
   }
}

