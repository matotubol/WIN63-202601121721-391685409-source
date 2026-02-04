package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   
   public class FriendOnlineImageListener implements class_259
   {
      
      private var var_146:Friend;
      
      private var var_1970:FriendCategories;
      
      private var _disposed:Boolean;
      
      public function FriendOnlineImageListener(param1:Friend, param2:FriendCategories)
      {
         super();
         var_146 = param1;
         var_1970 = param2;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:class_1827 = null;
         if(var_1970 != null)
         {
            _loc2_ = var_1970.deps.avatarManager.createAvatarImage(var_146.figure,"h",null,null);
            if(_loc2_ && !_loc2_.isPlaceholder())
            {
               var_1970.notifyFriendOnline(var_146,_loc2_);
            }
            else if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function dispose() : void
      {
         var_146 = null;
         var_1970 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

