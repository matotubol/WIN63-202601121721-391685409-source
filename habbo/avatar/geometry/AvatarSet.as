package com.sulake.habbo.avatar.geometry
{
   import flash.utils.Dictionary;
   
   public class AvatarSet
   {
      
      private var var_197:String;
      
      private var var_2325:Dictionary;
      
      private var var_3462:Array;
      
      private var var_4420:Array;
      
      private var _isMain:Boolean;
      
      public function AvatarSet(param1:XML)
      {
         super();
         var_197 = String(param1.@id);
         var _loc3_:String = String(param1.@main);
         _isMain = _loc3_ == null ? false : Boolean(parseInt(_loc3_));
         var_2325 = new Dictionary();
         var_3462 = [];
         for each(var _loc6_ in param1.avatarset)
         {
            var _loc4_:AvatarSet = new AvatarSet(_loc6_);
            var_2325[String(_loc6_.@id)] = null;
         }
         for each(var _loc2_ in param1.bodypart)
         {
            var_3462.push(String(_loc2_.@id));
         }
         var _loc5_:Array = var_3462.concat();
         for each(_loc4_ in var_2325)
         {
            _loc5_ = _loc5_.concat(null.getBodyParts());
         }
         var_4420 = _loc5_;
      }
      
      public function findAvatarSet(param1:String) : AvatarSet
      {
         if(param1 == var_197)
         {
            return this;
         }
         for each(var _loc2_ in var_2325)
         {
            if(_loc2_.findAvatarSet(param1) != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBodyParts() : Array
      {
         return var_4420.concat();
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get isMain() : Boolean
      {
         if(_isMain)
         {
            return true;
         }
         for each(var _loc1_ in var_2325)
         {
            if(_loc1_.isMain)
            {
               return true;
            }
         }
         return false;
      }
   }
}

