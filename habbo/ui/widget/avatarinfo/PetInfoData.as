package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   
   public class PetInfoData
   {
      
      public var age:int = 0;
      
      public var breedId:int = 0;
      
      public var canRemovePet:Boolean = false;
      
      public var energy:int = 0;
      
      public var energyMax:int = 0;
      
      public var experience:int = 0;
      
      public var experienceMax:int = 0;
      
      public var id:int = 0;
      
      public var isOwnPet:Boolean = false;
      
      public var level:int = 0;
      
      public var levelMax:int = 0;
      
      public var name:String = "";
      
      public var nutrition:int = 0;
      
      public var nutritionMax:int = 0;
      
      public var ownerId:int = 0;
      
      public var ownerName:String = "";
      
      public var petRace:int = 0;
      
      public var petRespect:int = 0;
      
      public var petRespectLeft:int = 0;
      
      public var petType:int = 0;
      
      public var hasFreeSaddle:Boolean = false;
      
      public var isRiding:Boolean = false;
      
      public var canBreed:Boolean = false;
      
      public var canHarvest:Boolean = false;
      
      public var canRevive:Boolean = false;
      
      public var skillTresholds:Array = [];
      
      public var accessRights:int = 0;
      
      public var maxWellBeingSeconds:int = 0;
      
      public var remainingWellBeingSeconds:int = 0;
      
      public var remainingGrowingSeconds:int = 0;
      
      public var hasBreedingPermission:Boolean = false;
      
      public function PetInfoData()
      {
         super();
      }
      
      public function populate(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         age = param1.age;
         breedId = param1.breedId;
         canRemovePet = param1.canRemovePet;
         energy = param1.energy;
         energyMax = param1.energyMax;
         experience = param1.experience;
         experienceMax = param1.experienceMax;
         id = param1.id;
         isOwnPet = param1.isOwnPet;
         level = param1.level;
         levelMax = param1.levelMax;
         name = param1.name;
         nutrition = param1.nutrition;
         nutritionMax = param1.nutritionMax;
         ownerId = param1.ownerId;
         ownerName = param1.ownerName;
         petRace = param1.petRace;
         petRespect = param1.petRespect;
         petRespectLeft = param1.petRespectLeft;
         petType = param1.petType;
         hasFreeSaddle = param1.hasFreeSaddle;
         isRiding = param1.isRiding;
         canBreed = param1.canBreed;
         canRevive = param1.canRevive;
         canHarvest = param1.canHarvest;
         skillTresholds = param1.skillTresholds;
         accessRights = param1.accessRights;
         maxWellBeingSeconds = param1.maxWellBeingSeconds;
         remainingWellBeingSeconds = param1.remainingWellBeingSeconds;
         remainingGrowingSeconds = param1.remainingGrowingSeconds;
         hasBreedingPermission = param1.hasBreedingPermission;
      }
   }
}

