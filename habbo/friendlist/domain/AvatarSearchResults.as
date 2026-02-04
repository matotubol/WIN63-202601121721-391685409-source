package com.sulake.habbo.friendlist.domain
{
   import flash.utils.Dictionary;
   import package_14.class_3180;
   
   public class AvatarSearchResults
   {
      
      private var var_741:class_1801;
      
      private var var_456:Array;
      
      private var _others:Array;
      
      private var var_3797:Dictionary = new Dictionary();
      
      public function AvatarSearchResults(param1:class_1801)
      {
         super();
         var_741 = param1;
      }
      
      public function getResult(param1:int) : class_3180
      {
         for each(var _loc3_ in var_456)
         {
            if(_loc3_.avatarId == param1)
            {
               return _loc3_;
            }
         }
         for each(var _loc2_ in _others)
         {
            if(_loc2_.avatarId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function searchReceived(param1:Array, param2:Array) : void
      {
         var_456 = param1;
         _others = param2;
         var_741.view.refreshList();
      }
      
      public function get friends() : Array
      {
         return var_456;
      }
      
      public function get others() : Array
      {
         return _others;
      }
      
      public function setFriendRequestSent(param1:int) : void
      {
         var_3797[param1] = "yes";
      }
      
      public function isFriendRequestSent(param1:int) : Boolean
      {
         return var_3797[param1] != null;
      }
   }
}

