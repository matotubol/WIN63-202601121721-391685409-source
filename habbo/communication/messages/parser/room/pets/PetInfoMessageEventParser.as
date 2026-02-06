package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetInfoMessageEventParser implements IMessageParser
   {
      
      private var var_2751:int;
      
      private var _name:String;
      
      private var var_2493:int;
      
      private var var_4315:int;
      
      private var var_4116:int;
      
      private var var_2380:int;
      
      private var var_3838:int;
      
      private var var_3964:int;
      
      private var var_4614:int;
      
      private var var_4543:int;
      
      private var var_4078:int;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_622:int;
      
      private var var_3980:int;
      
      private var var_4190:Boolean;
      
      private var var_4070:Boolean;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4086:int;
      
      private var var_3846:int;
      
      private var var_4624:int;
      
      private var var_3369:Array;
      
      private var var_3825:int;
      
      private var var_4033:int;
      
      private var var_4233:Boolean;
      
      public function PetInfoMessageEventParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get maxLevel() : int
      {
         return var_4315;
      }
      
      public function get experience() : int
      {
         return var_4116;
      }
      
      public function get energy() : int
      {
         return var_2380;
      }
      
      public function get nutrition() : int
      {
         return var_3838;
      }
      
      public function get experienceRequiredToLevel() : int
      {
         return var_3964;
      }
      
      public function get maxEnergy() : int
      {
         return var_4614;
      }
      
      public function get maxNutrition() : int
      {
         return var_4543;
      }
      
      public function get respect() : int
      {
         return var_4078;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
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
      
      public function get skillTresholds() : Array
      {
         return var_3369;
      }
      
      public function get accessRights() : int
      {
         return var_3825;
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function flush() : Boolean
      {
         var_2751 = -1;
         var_3369 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2751 = param1.readInteger();
         _name = param1.readString();
         var_2493 = param1.readInteger();
         var_4315 = param1.readInteger();
         var_4116 = param1.readInteger();
         var_3964 = param1.readInteger();
         var_2380 = param1.readInteger();
         var_4614 = param1.readInteger();
         var_3838 = param1.readInteger();
         var_4543 = param1.readInteger();
         var_4078 = param1.readInteger();
         var_1820 = param1.readInteger();
         var_622 = param1.readInteger();
         _ownerName = param1.readString();
         var_3980 = param1.readInteger();
         var_4190 = param1.readBoolean();
         var_4070 = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_3369.push(param1.readInteger());
            _loc2_++;
         }
         var_3369.sort(16);
         var_3825 = param1.readInteger();
         var_3982 = param1.readBoolean();
         var_4043 = param1.readBoolean();
         var_3818 = param1.readBoolean();
         var_4033 = param1.readInteger();
         var_4086 = param1.readInteger();
         var_3846 = param1.readInteger();
         var_4624 = param1.readInteger();
         var_4233 = param1.readBoolean();
         return true;
      }
   }
}

