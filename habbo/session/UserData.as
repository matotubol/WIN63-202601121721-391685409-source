package com.sulake.habbo.session
{
   public class UserData implements class_2146
   {
      
      private var var_3910:int = -1;
      
      private var _name:String = "";
      
      private var var_230:int = 0;
      
      private var var_1309:String = "";
      
      private var var_975:String = "";
      
      private var var_4073:String = "";
      
      private var _achievementScore:int;
      
      private var var_3931:int = 0;
      
      private var var_4243:String = "";
      
      private var _groupStatus:int = 0;
      
      private var _groupName:String = "";
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4388:int = 0;
      
      private var var_4033:int = 0;
      
      private var var_4085:Boolean;
      
      private var var_4070:Boolean;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4233:Boolean;
      
      private var _botSkills:Array;
      
      private var var_4625:Array;
      
      private var var_4071:Boolean;
      
      private var var_996:Boolean = false;
      
      public function UserData(param1:int)
      {
         super();
         var_3910 = param1;
      }
      
      public function get roomObjectId() : int
      {
         return var_3910;
      }
      
      public function get achievementScore() : int
      {
         return var_996 ? 0 : _achievementScore;
      }
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get name() : String
      {
         return var_996 ? "" : _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function set type(param1:int) : void
      {
         var_230 = param1;
      }
      
      public function get sex() : String
      {
         return var_996 ? "M" : var_1309;
      }
      
      public function set sex(param1:String) : void
      {
         var_1309 = param1;
      }
      
      public function get figure() : String
      {
         return var_996 ? "" : var_975;
      }
      
      public function set figure(param1:String) : void
      {
         var_975 = param1;
      }
      
      public function get custom() : String
      {
         return var_996 ? "" : var_4073;
      }
      
      public function set custom(param1:String) : void
      {
         var_4073 = param1;
      }
      
      public function get webID() : int
      {
         return var_3931;
      }
      
      public function set webID(param1:int) : void
      {
         var_3931 = param1;
      }
      
      public function get groupID() : String
      {
         return var_996 ? "" : var_4243;
      }
      
      public function set groupID(param1:String) : void
      {
         var_4243 = param1;
      }
      
      public function get groupName() : String
      {
         return var_996 ? "" : _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupStatus() : int
      {
         return var_996 ? 0 : _groupStatus;
      }
      
      public function set groupStatus(param1:int) : void
      {
         _groupStatus = param1;
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
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_4033 = param1;
      }
      
      public function get hasSaddle() : Boolean
      {
         return var_4085;
      }
      
      public function set hasSaddle(param1:Boolean) : void
      {
         var_4085 = param1;
      }
      
      public function get isRiding() : Boolean
      {
         return var_4070;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         var_4070 = param1;
      }
      
      public function get canBreed() : Boolean
      {
         return var_3982;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         var_3982 = param1;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_4043;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         var_4043 = param1;
      }
      
      public function get canRevive() : Boolean
      {
         return var_3818;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         var_3818 = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         var_4233 = param1;
      }
      
      public function get petLevel() : int
      {
         return var_4388;
      }
      
      public function set petLevel(param1:int) : void
      {
         var_4388 = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillData() : Array
      {
         return var_4625;
      }
      
      public function set botSkillData(param1:Array) : void
      {
         var_4625 = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return var_4071;
      }
      
      public function set isModerator(param1:Boolean) : void
      {
         var_4071 = param1;
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

