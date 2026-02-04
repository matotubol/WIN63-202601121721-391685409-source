package com.sulake.habbo.session
{
   public interface class_2309
   {
      
      function setUserData(param1:class_2146) : void;
      
      function getUserData(param1:int) : class_2146;
      
      function getUserDataByType(param1:int, param2:int) : class_2146;
      
      function getUserDataByIndex(param1:int) : class_2146;
      
      function getUserDataByName(param1:String) : class_2146;
      
      function getUserBadges(param1:int) : Array;
      
      function removeUserDataByRoomIndex(param1:int) : void;
      
      function setUserBadges(param1:int, param2:Array) : void;
      
      function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void;
      
      function updatePetLevel(param1:int, param2:int) : void;
      
      function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void;
      
      function updateCustom(param1:int, param2:String) : void;
      
      function updateAchievementScore(param1:int, param2:int) : void;
      
      function updateNameByIndex(param1:int, param2:String) : void;
      
      function markAsBlocked(param1:int, param2:Boolean = true) : void;
      
      function getPetUserData(param1:int) : class_2146;
      
      function getRentableBotUserData(param1:int) : class_2146;
      
      function requestPetInfo(param1:int) : void;
      
      function getAllUserIds() : Array;
   }
}

