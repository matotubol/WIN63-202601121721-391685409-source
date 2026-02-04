package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import flash.utils.Dictionary;
   import package_11.class_2166;
   import package_11.class_2429;
   import package_14.class_1915;
   import package_14.class_1937;
   import package_14.class_2083;
   
   public class class_3389
   {
      
      private var var_2104:Dictionary = new Dictionary();
      
      private var var_121:Array;
      
      public function class_3389()
      {
         super();
      }
      
      public function onFriendsListFragment(param1:IMessageEvent) : void
      {
         var _loc2_:class_2166 = (param1 as class_1915).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         for each(var _loc3_ in _loc2_.friendFragment)
         {
            var_2104[_loc3_.id] = _loc3_.name;
         }
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:class_2429 = (param1 as class_1937).getParser();
         for each(var _loc3_ in _loc2_.removedFriendIds)
         {
            var_2104[_loc3_] = null;
         }
         for each(var _loc4_ in _loc2_.addedFriends)
         {
            var_2104[_loc4_.id] = _loc4_.name;
         }
         var_121 = _loc2_.removedFriendIds.length > 0 || _loc2_.addedFriends.length > 0 ? null : var_121;
      }
      
      public function get list() : Array
      {
         if(var_121 == null)
         {
            var_121 = [];
            for(var _loc1_ in var_2104)
            {
               var _loc3_:int = int(_loc1_);
               var _loc2_:String = var_2104[0];
            }
            var_121.sortOn("userName",1);
         }
         return var_121;
      }
   }
}

