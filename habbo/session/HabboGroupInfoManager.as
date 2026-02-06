package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
   
   public class HabboGroupInfoManager implements class_13
   {
      
      private var _sessionDataManager:SessionDataManager;
      
      private var var_179:class_55;
      
      private var var_4410:IMessageEvent;
      
      private var var_1600:IMessageEvent;
      
      public function HabboGroupInfoManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         var_179 = new class_55();
         if(_sessionDataManager.communication)
         {
            var_4410 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            var_1600 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(onHabboGroupBadges));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_4410);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_1600);
         }
         var_179 = null;
         _sessionDataManager = null;
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         _sessionDataManager.send(new GetHabboGroupBadgesMessageComposer());
      }
      
      private function onHabboGroupBadges(param1:HabboGroupBadgesMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:class_55 = param1.badges;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_.getKey(_loc4_);
            var_179.remove(_loc3_);
            var_179.add(_loc3_,_loc2_.getWithIndex(_loc4_));
            _loc4_++;
         }
      }
      
      public function getBadgeId(param1:int) : String
      {
         return var_179.getValue(param1);
      }
   }
}

