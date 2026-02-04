package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import flash.utils.Dictionary;
   import package_3.class_2558;
   import package_3.class_3349;
   import package_9.class_2516;
   import package_9.class_3092;
   import package_9.class_3430;
   
   public class BlockedUsersManager implements class_13
   {
      
      private var _sessionDataManager:SessionDataManager;
      
      private var var_3228:IMessageEvent;
      
      private var var_3381:IMessageEvent;
      
      private var var_960:Dictionary;
      
      public function BlockedUsersManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         var_960 = new Dictionary();
         if(_sessionDataManager.communication)
         {
            var_3228 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new class_2558(onBlockUpdate));
            var_3381 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new class_3349(onBlockList));
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_3228);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_3381);
         }
         var_3228 = null;
         var_3381 = null;
         _sessionDataManager = null;
         var_960 = null;
      }
      
      public function initBlockList() : void
      {
         _sessionDataManager.send(new class_3430());
      }
      
      private function onBlockList(param1:class_3349) : void
      {
         var_960 = new Dictionary();
         var _loc2_:Array = param1.blockedUserIds;
         for each(var _loc3_ in _loc2_)
         {
            var_960[_loc3_] = true;
         }
      }
      
      private function onBlockUpdate(param1:class_2558) : void
      {
         var _loc2_:int = param1.userId;
         switch(param1.result)
         {
            case 0:
               removeUserFromBlockList(_loc2_);
               _sessionDataManager.notifications.addItem("${notification.unblocked_player}","info");
               break;
            case 1:
               addUserToBlockList(_loc2_);
               _sessionDataManager.notifications.addItem("${notification.blocked_player}","info");
         }
      }
      
      private function addUserToBlockList(param1:int) : void
      {
         var_960[param1] = true;
      }
      
      private function removeUserFromBlockList(param1:int) : void
      {
         delete var_960[param1];
      }
      
      public function blockUser(param1:int) : void
      {
         _sessionDataManager.send(new class_3092(param1));
      }
      
      public function unblockUser(param1:int) : void
      {
         _sessionDataManager.send(new class_2516(param1));
      }
      
      public function isBlocked(param1:int) : Boolean
      {
         return var_960 && var_960[param1];
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
   }
}

