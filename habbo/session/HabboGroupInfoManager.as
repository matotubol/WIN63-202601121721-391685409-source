package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import package_3.class_2981;
   import package_54.class_2169;
   import package_9.class_2925;
   
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
            var_4410 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new class_2169(onRoomReady));
            var_1600 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new class_2981(onHabboGroupBadges));
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
         _sessionDataManager.send(new class_2925());
      }
      
      private function onHabboGroupBadges(param1:class_2981) : void
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

