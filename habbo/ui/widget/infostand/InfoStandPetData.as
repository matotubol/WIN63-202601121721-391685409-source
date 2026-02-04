package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandPetData
   {
      
      private var var_2493:int;
      
      private var var_4265:int;
      
      private var var_4116:int;
      
      private var var_3821:int;
      
      private var var_2380:int;
      
      private var var_4023:int;
      
      private var var_3838:int;
      
      private var var_4326:int;
      
      private var var_4332:int;
      
      private var _name:String = "";
      
      private var var_2751:int = -1;
      
      private var var_230:int;
      
      private var var_4507:int;
      
      private var var_48:BitmapData;
      
      private var var_4376:Boolean;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_4158:Boolean;
      
      private var var_3915:int;
      
      private var var_622:int;
      
      private var var_3980:int;
      
      private var var_3369:Array;
      
      private var var_3825:int;
      
      private var var_4033:int;
      
      private var var_4233:Boolean;
      
      private var var_4086:int;
      
      private var var_3846:int;
      
      private var var_4624:int;
      
      public function InfoStandPetData()
      {
         super();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return var_2751;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get race() : int
      {
         return var_4507;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
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
      
      public function get age() : int
      {
         return var_622;
      }
      
      public function get breedId() : int
      {
         return var_3980;
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
      
      public function get petRespect() : int
      {
         return var_4332;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return var_4086;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return var_3846;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return var_4624;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function setData(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         _name = param1.name;
         var_2751 = param1.id;
         var_230 = param1.petType;
         var_4507 = param1.petRace;
         var_48 = param1.image;
         var_4376 = param1.isOwnPet;
         var_1820 = param1.ownerId;
         _ownerName = param1.ownerName;
         var_4158 = param1.canRemovePet;
         var_2493 = param1.level;
         var_4265 = param1.levelMax;
         var_4116 = param1.experience;
         var_3821 = param1.experienceMax;
         var_2380 = param1.energy;
         var_4023 = param1.energyMax;
         var_3838 = param1.nutrition;
         var_4326 = param1.nutritionMax;
         var_4332 = param1.petRespect;
         var_3915 = param1.roomIndex;
         var_622 = param1.age;
         var_3980 = param1.breedId;
         var_3369 = param1.skillTresholds;
         var_3825 = param1.accessRights;
         var_4086 = param1.maxWellBeingSeconds;
         var_3846 = param1.remainingWellBeingSeconds;
         var_4624 = param1.remainingGrowingSeconds;
         var_4033 = param1.rarityLevel;
         var_4233 = param1.hasBreedingPermission;
      }
   }
}

