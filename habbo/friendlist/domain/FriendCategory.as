package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   
   public class FriendCategory implements class_13
   {
      
      public static const PAGE_SIZE:int = 100;
      
      public static const CATID_ONLINE:int = 0;
      
      public static const CATID_OFFLINE:int = -1;
      
      private var var_197:int;
      
      private var _name:String;
      
      private var _open:Boolean;
      
      private var var_456:class_55 = new class_55();
      
      private var var_898:class_55 = null;
      
      private var var_3865:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_18:class_1812;
      
      private var var_2109:int;
      
      private var var_168:String = "";
      
      public function FriendCategory(param1:int, param2:String)
      {
         super();
         var_197 = param1;
         _name = param2;
         _open = var_197 != -1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_18 = null;
      }
      
      public function addFriend(param1:Friend) : void
      {
         removeFriend(param1.id);
         var_456.add(param1.id,param1);
         if(var_898 != null && acceptFilter(param1))
         {
            var_898.add(param1.id,param1);
         }
      }
      
      public function sort() : void
      {
         var _loc2_:Array = var_456.getValues();
         _loc2_.sortOn("name",1);
         var_456 = new class_55();
         for each(var _loc1_ in _loc2_)
         {
            var_456.add(_loc1_.id,_loc1_);
         }
         updateFilteredFriends();
      }
      
      public function getSelectedFriends(param1:Array) : void
      {
         for each(var _loc2_ in var_456.getValues())
         {
            if(_loc2_.selected)
            {
               param1.push(_loc2_);
            }
         }
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         if(!param1 && !param2)
         {
            return var_456.length;
         }
         var _loc3_:int = 0;
         for each(var _loc4_ in var_456.getValues())
         {
            if((!param1 || _loc4_.online) && (!param2 || _loc4_.followingAllowed))
            {
               _loc3_ += 1;
            }
         }
         return _loc3_;
      }
      
      public function removeFriend(param1:int) : Friend
      {
         var _loc2_:Friend = var_456.remove(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         if(var_898 != null && acceptFilter(_loc2_))
         {
            var_898.remove(param1);
         }
         return _loc2_;
      }
      
      private function checkPageIndex() : void
      {
         if(this.var_2109 >= this.getPageCount())
         {
            this.var_2109 = Math.max(0,this.getPageCount() - 1);
         }
      }
      
      public function getPageCount() : int
      {
         return Math.ceil(filteredFriends.length / 100);
      }
      
      public function getStartFriendIndex() : int
      {
         checkPageIndex();
         return this.var_2109 * 100;
      }
      
      public function getEndFriendIndex() : int
      {
         checkPageIndex();
         return Math.min((this.var_2109 + 1) * 100,filteredFriends.length);
      }
      
      public function setOpen(param1:Boolean) : void
      {
         _open = param1;
         if(!param1)
         {
            for each(var _loc2_ in var_456.getValues())
            {
               _loc2_.selected = false;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get received() : Boolean
      {
         return var_3865;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get friends() : Array
      {
         return var_456.getValues();
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function get pageIndex() : int
      {
         return var_2109;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set view(param1:class_1812) : void
      {
         var_18 = param1;
      }
      
      public function set received(param1:Boolean) : void
      {
         var_3865 = param1;
      }
      
      public function set pageIndex(param1:int) : void
      {
         var_2109 = param1;
      }
      
      public function get filter() : String
      {
         return var_168;
      }
      
      public function set filter(param1:String) : void
      {
         if(param1 != var_168)
         {
            var_168 = param1;
            updateFilteredFriends();
         }
      }
      
      private function acceptFilter(param1:Friend) : Boolean
      {
         return var_168.length == 0 || param1.name.toLowerCase().indexOf(var_168) != -1;
      }
      
      private function updateFilteredFriends() : void
      {
         if(var_456 == null)
         {
            return;
         }
         if(var_168.length == 0)
         {
            var_898 = null;
            return;
         }
         var_898 = new class_55();
         for each(var _loc1_ in var_456.getValues())
         {
            if(acceptFilter(_loc1_))
            {
               var_898.add(_loc1_.id,_loc1_);
            }
         }
      }
      
      public function get filteredFriends() : Array
      {
         return var_898 == null ? var_456.getValues() : var_898.getValues();
      }
   }
}

