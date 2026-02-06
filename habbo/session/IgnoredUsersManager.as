package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
   
   public class IgnoredUsersManager implements class_13
   {
      
      private var _sessionDataManager:SessionDataManager;
      
      private var var_2689:IMessageEvent;
      
      private var var_2824:IMessageEvent;
      
      private var var_1047:Array = [];
      
      public function IgnoredUsersManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         if(_sessionDataManager.communication)
         {
            var_2689 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
            var_2824 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoredUsersMessageEvent(onIgnoreList));
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
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_2689);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_2824);
         }
         var_2689 = null;
         var_2824 = null;
         _sessionDataManager = null;
      }
      
      public function initIgnoreList() : void
      {
         _sessionDataManager.send(new GetIgnoredUsersMessageComposer());
      }
      
      private function onIgnoreList(param1:IgnoredUsersMessageEvent) : void
      {
         var_1047 = param1.ignoredUserIds;
      }
      
      private function onIgnoreResult(param1:IgnoreResultMessageEvent) : void
      {
         var _loc2_:int = param1.userId;
         switch(param1.result)
         {
            case 1:
               addUserToIgnoreList(_loc2_);
               break;
            case 2:
               addUserToIgnoreList(_loc2_);
               var_1047.shift();
               break;
            case 3:
               removeUserFromIgnoreList(_loc2_);
         }
      }
      
      private function addUserToIgnoreList(param1:int) : void
      {
         if(var_1047.indexOf(param1) < 0)
         {
            var_1047.push(param1);
         }
      }
      
      private function removeUserFromIgnoreList(param1:int) : void
      {
         var _loc2_:int = int(var_1047.indexOf(param1));
         if(_loc2_ >= 0)
         {
            var_1047.splice(_loc2_,1);
         }
      }
      
      public function ignoreUser(param1:int) : void
      {
         _sessionDataManager.send(new IgnoreUserMessageComposer(param1));
      }
      
      public function unignoreUser(param1:int) : void
      {
         _sessionDataManager.send(new UnignoreUserMessageComposer(param1));
      }
      
      public function isIgnored(param1:int) : Boolean
      {
         return var_1047.indexOf(param1) >= 0;
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
   }
}

