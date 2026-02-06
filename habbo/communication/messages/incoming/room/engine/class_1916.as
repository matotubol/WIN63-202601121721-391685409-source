package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class class_1916
   {
      
      public static const const_1005:String = "M";
      
      public static const const_303:String = "F";
      
      private var var_3915:int = 0;
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_176:Number = 0;
      
      private var var_772:int = 0;
      
      private var _name:String = "";
      
      private var var_3359:int = 0;
      
      private var var_1309:String = "";
      
      private var var_975:String = "";
      
      private var var_4073:String = "";
      
      private var _achievementScore:int;
      
      private var var_3931:int = 0;
      
      private var var_4243:String = "";
      
      private var _groupStatus:int = 0;
      
      private var _groupName:String = "";
      
      private var var_3316:String = "";
      
      private var var_1820:int = 0;
      
      private var _ownerName:String;
      
      private var var_4033:int;
      
      private var var_4085:Boolean;
      
      private var var_4070:Boolean;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4233:Boolean;
      
      private var var_4388:int = 0;
      
      private var var_4561:String = "";
      
      private var _botSkills:Array;
      
      private var var_4071:Boolean;
      
      private var var_136:Boolean = false;
      
      public function class_1916(param1:int)
      {
         super();
         var_3915 = param1;
      }
      
      public function setReadOnly() : void
      {
         var_136 = true;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function set x(param1:Number) : void
      {
         if(!var_136)
         {
            var_25 = param1;
         }
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_136)
         {
            var_26 = param1;
         }
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_136)
         {
            var_176 = param1;
         }
      }
      
      public function get dir() : int
      {
         return var_772;
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_136)
         {
            var_772 = param1;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         if(!var_136)
         {
            _name = param1;
         }
      }
      
      public function get userType() : int
      {
         return var_3359;
      }
      
      public function set userType(param1:int) : void
      {
         if(!var_136)
         {
            var_3359 = param1;
         }
      }
      
      public function get sex() : String
      {
         return var_1309;
      }
      
      public function set sex(param1:String) : void
      {
         if(!var_136)
         {
            var_1309 = param1;
         }
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function set figure(param1:String) : void
      {
         if(!var_136)
         {
            var_975 = param1;
         }
      }
      
      public function get custom() : String
      {
         return var_4073;
      }
      
      public function set custom(param1:String) : void
      {
         if(!var_136)
         {
            var_4073 = param1;
         }
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!var_136)
         {
            _achievementScore = param1;
         }
      }
      
      public function get webID() : int
      {
         return var_3931;
      }
      
      public function set webID(param1:int) : void
      {
         if(!var_136)
         {
            var_3931 = param1;
         }
      }
      
      public function get groupID() : String
      {
         return var_4243;
      }
      
      public function set groupID(param1:String) : void
      {
         if(!var_136)
         {
            var_4243 = param1;
         }
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         if(!var_136)
         {
            _groupName = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return _groupStatus;
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!var_136)
         {
            _groupStatus = param1;
         }
      }
      
      public function get subType() : String
      {
         return var_3316;
      }
      
      public function set subType(param1:String) : void
      {
         if(!var_136)
         {
            var_3316 = param1;
         }
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function set ownerId(param1:int) : void
      {
         if(!var_136)
         {
            var_1820 = param1;
         }
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         if(!var_136)
         {
            _ownerName = param1;
         }
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         if(!var_136)
         {
            var_4033 = param1;
         }
      }
      
      public function get hasSaddle() : Boolean
      {
         return var_4085;
      }
      
      public function set hasSaddle(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_4085 = param1;
         }
      }
      
      public function get isRiding() : Boolean
      {
         return var_4070;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_4070 = param1;
         }
      }
      
      public function get canBreed() : Boolean
      {
         return var_3982;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_3982 = param1;
         }
      }
      
      public function get canHarvest() : Boolean
      {
         return var_4043;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_4043 = param1;
         }
      }
      
      public function get canRevive() : Boolean
      {
         return var_3818;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_3818 = param1;
         }
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_4233 = param1;
         }
      }
      
      public function get petLevel() : int
      {
         return var_4388;
      }
      
      public function set petLevel(param1:int) : void
      {
         if(!var_136)
         {
            var_4388 = param1;
         }
      }
      
      public function get petPosture() : String
      {
         return var_4561;
      }
      
      public function set petPosture(param1:String) : void
      {
         if(!var_136)
         {
            var_4561 = param1;
         }
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return var_4071;
      }
      
      public function set isModerator(param1:Boolean) : void
      {
         if(!var_136)
         {
            var_4071 = param1;
         }
      }
   }
}

