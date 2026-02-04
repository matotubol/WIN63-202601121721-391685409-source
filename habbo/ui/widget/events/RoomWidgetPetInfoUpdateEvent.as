package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_INFO:String = "RWPIUE_PET_INFO";
      
      private var var_2493:int;
      
      private var var_4265:int;
      
      private var var_4116:int;
      
      private var var_3821:int;
      
      private var var_2380:int;
      
      private var var_4023:int;
      
      private var var_3838:int;
      
      private var var_4326:int;
      
      private var var_1113:int;
      
      private var var_4332:int;
      
      private var var_622:int;
      
      private var _name:String;
      
      private var var_197:int;
      
      private var var_48:BitmapData;
      
      private var var_4522:int;
      
      private var var_4287:int;
      
      private var var_4376:Boolean;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_4158:Boolean;
      
      private var var_3915:int;
      
      private var var_3980:int;
      
      private var var_4190:Boolean;
      
      private var var_4070:Boolean;
      
      private var var_3982:Boolean;
      
      private var var_3369:Array;
      
      private var var_3825:int;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4033:int;
      
      private var var_4086:int;
      
      private var var_3846:int;
      
      private var var_4624:int;
      
      private var var_4233:Boolean;
      
      public function RoomWidgetPetInfoUpdateEvent(param1:int, param2:int, param3:String, param4:int, param5:BitmapData, param6:Boolean, param7:int, param8:String, param9:int, param10:int, param11:Boolean = false, param12:Boolean = false)
      {
         super("RWPIUE_PET_INFO",param11,param12);
         var_4522 = param1;
         var_4287 = param2;
         _name = param3;
         var_197 = param4;
         var_48 = param5;
         var_4376 = param6;
         var_1820 = param7;
         _ownerName = param8;
         var_3915 = param9;
         var_3980 = param10;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get petType() : int
      {
         return var_4522;
      }
      
      public function get petRace() : int
      {
         return var_4287;
      }
      
      public function get isOwnPet() : Boolean
      {
         return var_4376;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get canRemovePet() : Boolean
      {
         return var_4158;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get age() : int
      {
         return var_622;
      }
      
      public function get breedId() : int
      {
         return var_3980;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         return var_4190;
      }
      
      public function get isRiding() : Boolean
      {
         return var_4070;
      }
      
      public function get canBreed() : Boolean
      {
         return var_3982;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_4043;
      }
      
      public function get canRevive() : Boolean
      {
         return var_3818;
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function get skillTresholds() : Array
      {
         return var_3369;
      }
      
      public function get accessRights() : int
      {
         return var_3825;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get levelMax() : int
      {
         return var_4265;
      }
      
      public function get experience() : int
      {
         return var_4116;
      }
      
      public function get experienceMax() : int
      {
         return var_3821;
      }
      
      public function get energy() : int
      {
         return var_2380;
      }
      
      public function get energyMax() : int
      {
         return var_4023;
      }
      
      public function get nutrition() : int
      {
         return var_3838;
      }
      
      public function get nutritionMax() : int
      {
         return var_4326;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1113;
      }
      
      public function get petRespect() : int
      {
         return var_4332;
      }
      
      public function set level(param1:int) : void
      {
         var_2493 = param1;
      }
      
      public function set levelMax(param1:int) : void
      {
         var_4265 = param1;
      }
      
      public function set experience(param1:int) : void
      {
         var_4116 = param1;
      }
      
      public function set experienceMax(param1:int) : void
      {
         var_3821 = param1;
      }
      
      public function set energy(param1:int) : void
      {
         var_2380 = param1;
      }
      
      public function set energyMax(param1:int) : void
      {
         var_4023 = param1;
      }
      
      public function set nutrition(param1:int) : void
      {
         var_3838 = param1;
      }
      
      public function set nutritionMax(param1:int) : void
      {
         var_4326 = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         var_1113 = param1;
      }
      
      public function set canRemovePet(param1:Boolean) : void
      {
         var_4158 = param1;
      }
      
      public function set petRespect(param1:int) : void
      {
         var_4332 = param1;
      }
      
      public function set age(param1:int) : void
      {
         var_622 = param1;
      }
      
      public function set hasFreeSaddle(param1:Boolean) : void
      {
         var_4190 = param1;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         var_4070 = param1;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         var_3982 = param1;
      }
      
      public function set skillTresholds(param1:Array) : void
      {
         var_3369 = param1;
      }
      
      public function set accessRights(param1:int) : void
      {
         var_3825 = param1;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         var_4043 = param1;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         var_3818 = param1;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_4033 = param1;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return var_4086;
      }
      
      public function set maxWellBeingSeconds(param1:int) : void
      {
         var_4086 = param1;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return var_3846;
      }
      
      public function set remainingWellBeingSeconds(param1:int) : void
      {
         var_3846 = param1;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return var_4624;
      }
      
      public function set remainingGrowingSeconds(param1:int) : void
      {
         var_4624 = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         var_4233 = param1;
      }
   }
}

