package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.class_3969;
   
   public class class_3025
   {
      
      private var var_197:int = -1;
      
      private var var_3915:int;
      
      private var var_3084:Boolean = false;
      
      private var var_2753:Boolean = false;
      
      private var var_2831:Boolean = false;
      
      private var var_3274:int = 0;
      
      private var _botSkills:Array;
      
      private var var_1360:Array = new Array(0);
      
      private var _name:String;
      
      public function class_3025()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set roomIndex(param1:int) : void
      {
         var_3915 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3084;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_2753;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_2831;
      }
      
      public function get carryItemType() : int
      {
         return var_3274;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3084 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_2753 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_2831 = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         var_3274 = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillsWithCommands() : Array
      {
         return var_1360;
      }
      
      public function set botSkillsWithCommands(param1:Array) : void
      {
         var_1360 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function populate(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         if(param1.webID != id)
         {
            var_1360 = new Array(0);
         }
         id = param1.webID;
         roomIndex = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         carryItemType = param1.carryItem;
         botSkills = param1.botSkills;
         _name = param1.name;
      }
      
      public function cloneAndSetSkillsWithCommands(param1:Array) : void
      {
         _botSkills = [];
         for each(var _loc2_ in param1)
         {
            botSkills.push(_loc2_.id);
         }
         var_1360 = param1.concat();
      }
   }
}

