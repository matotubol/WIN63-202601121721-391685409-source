package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.perk.class_2995;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   
   public class PerkManager implements class_13
   {
      
      private var var_1668:Boolean = false;
      
      private var _sessionDataManager:SessionDataManager;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      private var var_1035:Dictionary = new Dictionary();
      
      public function PerkManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         if(_sessionDataManager.communication)
         {
            _perkAllowancesMessageEvent = _sessionDataManager.communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
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
         if(var_1035)
         {
            for(var _loc1_ in var_1035)
            {
               delete var_1035[_loc1_];
            }
            var_1035 = null;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
         }
         _perkAllowancesMessageEvent = null;
         _sessionDataManager = null;
      }
      
      public function get isReady() : Boolean
      {
         return var_1668;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return param1 in var_1035 && var_1035[param1].isAllowed;
      }
      
      public function getPerkErrorMessage(param1:String) : String
      {
         var _loc2_:class_2995 = var_1035[param1];
         return _loc2_ != null ? _loc2_.errorMessage : "";
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         for each(var _loc2_ in param1.getParser().getPerks())
         {
            var_1035[_loc2_.code] = _loc2_;
         }
         var_1668 = true;
         _sessionDataManager.events.dispatchEvent(new PerksUpdatedEvent());
      }
   }
}

