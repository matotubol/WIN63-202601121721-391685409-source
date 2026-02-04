package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.class_55;
   import package_66.class_3048;
   import package_9.class_3368;
   
   public class UserDataManager implements class_2309
   {
      
      private static const TYPE_USER:int = 1;
      
      private static const TYPE_PET:int = 2;
      
      private static const const_596:int = 3;
      
      private static const const_169:int = 4;
      
      private var var_1269:class_55;
      
      private var var_1179:class_55;
      
      private var var_1522:class_55;
      
      private var var_37:IConnection;
      
      public function UserDataManager()
      {
         super();
         var_1269 = new class_55();
         var_1179 = new class_55();
         var_1522 = new class_55();
      }
      
      public function dispose() : void
      {
         var_37 = null;
         var_1269.dispose();
         var_1269 = null;
         var_1179.dispose();
         var_1179 = null;
         var_1522.dispose();
         var_1522 = null;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_37 = param1;
      }
      
      public function getUserData(param1:int) : class_2146
      {
         return getUserDataByType(param1,1);
      }
      
      public function getUserDataByType(param1:int, param2:int) : class_2146
      {
         var _loc4_:class_55 = var_1269.getValue(param2);
         if(_loc4_ != null)
         {
            var _loc3_:class_2146 = _loc4_.getValue(param1);
         }
         return null;
      }
      
      public function getUserDataByIndex(param1:int) : class_2146
      {
         return var_1179.getValue(param1);
      }
      
      public function getUserDataByName(param1:String) : class_2146
      {
         for each(var _loc2_ in var_1179)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getUserBadges(param1:int) : Array
      {
         if(var_37 != null)
         {
            var_37.send(new class_3368(param1));
         }
         var _loc2_:Array = var_1522.getValue(param1) as Array;
         if(_loc2_ == null)
         {
            _loc2_ = [];
         }
         return _loc2_;
      }
      
      public function setUserData(param1:class_2146) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeUserDataByRoomIndex(param1.roomObjectId);
         var _loc2_:class_55 = var_1269.getValue(param1.type);
         if(_loc2_ == null)
         {
            _loc2_ = new class_55();
            var_1269.add(param1.type,_loc2_);
         }
         _loc2_.add(param1.webID,param1);
         var_1179.add(param1.roomObjectId,param1);
      }
      
      public function removeUserDataByRoomIndex(param1:int) : void
      {
         var _loc2_:class_2146 = var_1179.remove(param1);
         if(_loc2_ != null)
         {
            var _loc4_:class_55 = var_1269.getValue(_loc2_.type);
            if(_loc4_ != null)
            {
               var _loc3_:class_2146 = null.remove(_loc2_.webID);
            }
         }
      }
      
      public function setUserBadges(param1:int, param2:Array) : void
      {
         var_1522.remove(param1);
         var_1522.add(param1,param2);
      }
      
      public function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:class_2146 = getUserDataByIndex(param1);
         if(_loc6_ != null)
         {
            _loc6_.figure = param2;
            _loc6_.sex = param3;
            _loc6_.hasSaddle = param4;
            _loc6_.isRiding = param5;
         }
      }
      
      public function updatePetLevel(param1:int, param2:int) : void
      {
         var _loc3_:class_2146 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.petLevel = param2;
         }
      }
      
      public function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:class_2146 = getUserDataByIndex(param1);
         if(_loc6_ != null)
         {
            _loc6_.canBreed = param2;
            _loc6_.canHarvest = param3;
            _loc6_.canRevive = param4;
            _loc6_.hasBreedingPermission = param5;
         }
      }
      
      public function updateCustom(param1:int, param2:String) : void
      {
         var _loc3_:class_2146 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.custom = param2;
         }
      }
      
      public function updateAchievementScore(param1:int, param2:int) : void
      {
         var _loc3_:class_2146 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.achievementScore = param2;
         }
      }
      
      public function markAsBlocked(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:class_2146 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.isBlocked = param2;
         }
      }
      
      public function updateNameByIndex(param1:int, param2:String) : void
      {
         var _loc3_:class_2146 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.name = param2;
         }
      }
      
      public function getPetUserData(param1:int) : class_2146
      {
         return getUserDataByType(param1,2);
      }
      
      public function getRentableBotUserData(param1:int) : class_2146
      {
         return getUserDataByType(param1,4);
      }
      
      public function requestPetInfo(param1:int) : void
      {
         var _loc2_:class_2146 = getPetUserData(param1);
         if(_loc2_ != null && var_37 != null)
         {
            var_37.send(new class_3048(_loc2_.webID));
         }
      }
      
      public function getAllUserIds() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in var_1179)
         {
            _loc2_.push(_loc1_.webID);
         }
         return _loc2_;
      }
   }
}

