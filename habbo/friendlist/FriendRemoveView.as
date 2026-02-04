package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendlist.domain.Friend;
   import flash.utils.Dictionary;
   import package_28.class_1824;
   
   public class FriendRemoveView extends AlertView
   {
      
      private var _selected:Array;
      
      public function FriendRemoveView(param1:HabboFriendList)
      {
         super(param1,"friend_remove_confirm");
         _selected = param1.categories.getSelectedFriends();
      }
      
      override public function dispose() : void
      {
         _selected = null;
         super.dispose();
      }
      
      override internal function setupContent(param1:class_1812) : void
      {
         param1.findChildByName("cancel").procedure = onClose;
         param1.findChildByName("ok").procedure = onRemove;
         var _loc4_:Array = [];
         for each(var _loc2_ in _selected)
         {
            _loc4_.push(_loc2_.name);
         }
         var _loc5_:String = Util.arrayToString(_loc4_);
         var _loc3_:Dictionary = new Dictionary();
         friendList.registerParameter("friendlist.removefriendconfirm.userlist","user_names",_loc5_);
      }
      
      private function onRemove(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Remove Ok clicked");
         var _loc3_:class_1824 = new class_1824();
         for each(var _loc4_ in _selected)
         {
            _loc3_.addRemovedFriend(_loc4_.id);
         }
         friendList.send(_loc3_);
         dispose();
      }
   }
}

