package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.users.BlockUserUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.BlockListMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.UnblockUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.BlockUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.BlockListInitComposer;
   
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
            var_3228 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new BlockUserUpdateMessageEvent(onBlockUpdate));
            var_3381 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new BlockListMessageEvent(onBlockList));
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
         _sessionDataManager.send(new BlockListInitComposer());
      }
      
      private function onBlockList(param1:BlockListMessageEvent) : void
      {
         var_960 = new Dictionary();
         var _loc2_:Array = param1.blockedUserIds;
         for each(var _loc3_ in _loc2_)
         {
            var_960[_loc3_] = true;
         }
      }
      
      private function onBlockUpdate(param1:BlockUserUpdateMessageEvent) : void
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
         _sessionDataManager.send(new BlockUserMessageComposer(param1));
      }
      
      public function unblockUser(param1:int) : void
      {
         _sessionDataManager.send(new UnblockUserMessageComposer(param1));
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

