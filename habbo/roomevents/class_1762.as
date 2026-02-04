package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2594;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2644;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2813;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2832;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2940;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3163;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3216;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3309;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3540;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3547;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3569;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_3282;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2367;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2371;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2488;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2532;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2805;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3056;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3201;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3573;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3654;
   import package_3.class_2022;
   import package_39.class_2407;
   import package_4.class_2005;
   import package_44.class_1913;
   import package_50.class_2719;
   import package_54.class_2039;
   
   [SecureSWF(rename="true")]
   public class class_1762 implements class_13
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function class_1762(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>(0);
         var _loc2_:class_57 = _roomEvents.communication;
         addMessageEvent(new class_2832(onSelector));
         addMessageEvent(new class_2813(onRewardFailed));
         addMessageEvent(new class_2594(onOpen));
         addMessageEvent(new class_3163(onAddon));
         addMessageEvent(new class_2039(onRoomExit));
         addMessageEvent(new class_3547(onSaveSuccess));
         addMessageEvent(new class_3309(onVariable));
         addMessageEvent(new class_3540(onCondition));
         addMessageEvent(new class_2022(onGuildMemberships));
         addMessageEvent(new class_2644(onTrigger));
         addMessageEvent(new class_2005(onUserObject));
         addMessageEvent(new class_2940(onAction));
         addMessageEvent(new class_2407(onObjectRemove));
         addMessageEvent(new class_3216(onValidationError));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_roomEvents.communication.addHabboConnectionMessageEvent(param1));
      }
      
      private function onOpen(param1:IMessageEvent) : void
      {
         var _loc2_:class_2371 = (param1 as class_2594).getParser();
         _roomEvents.send(new class_3282(_loc2_.stuffId));
      }
      
      private function onTrigger(param1:IMessageEvent) : void
      {
         var _loc2_:class_3573 = (param1 as class_2644).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAction(param1:IMessageEvent) : void
      {
         var _loc2_:class_2367 = (param1 as class_2940).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onCondition(param1:IMessageEvent) : void
      {
         var _loc2_:class_2805 = (param1 as class_3540).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAddon(param1:IMessageEvent) : void
      {
         var _loc2_:class_2488 = (param1 as class_3163).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onVariable(param1:IMessageEvent) : void
      {
         var _loc2_:class_3201 = (param1 as class_3309).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onSelector(param1:IMessageEvent) : void
      {
         var _loc2_:class_2532 = (param1 as class_2832).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1913 = (param1 as class_2005).getParser();
         _roomEvents.userName = _loc2_.name;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _roomEvents.wiredCtrl.close();
      }
      
      private function onObjectRemove(param1:IMessageEvent) : void
      {
         var _loc2_:class_2719 = (param1 as class_2407).getParser();
         class_21.log("Received object remove event: " + _loc2_.id + ", " + _loc2_.isExpired);
         _roomEvents.wiredCtrl.stuffRemoved(_loc2_.id);
      }
      
      private function onRewardFailed(param1:IMessageEvent) : void
      {
         var _loc2_:class_3056 = class_2813(param1).getParser();
         if(_loc2_.reason == 6)
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.title"),_roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.body"),0,null);
         }
         else if(_loc2_.reason == 7)
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.badgereceived.title"),_roomEvents.localization.getLocalization("wiredfurni.badgereceived.body"),0,null);
         }
         else
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardfailed.title"),_roomEvents.localization.getLocalization("wiredfurni.rewardfailed.reason." + _loc2_.reason),0,null);
         }
      }
      
      private function onValidationError(param1:IMessageEvent) : void
      {
         var _loc3_:class_3654 = class_3216(param1).getParser();
         var _loc6_:class_55 = new class_55();
         for each(var _loc5_ in _loc3_.parameters)
         {
            _loc6_.add(_loc5_.key,_loc5_.value);
         }
         var _loc2_:String = _roomEvents.localization.getLocalizationWithParamMap(_loc3_.localizationKey,_loc3_.localizationKey,_loc6_);
         var _loc4_:String = _roomEvents.localization.getLocalization("wiredfurni.error.title","Update failed");
         _roomEvents.windowManager.alert(_loc4_,_loc2_,0,null);
         _roomEvents.wiredCtrl.onSaveFailure();
      }
      
      private function onSaveSuccess(param1:IMessageEvent) : void
      {
         _roomEvents.wiredCtrl.onSaveSuccess();
      }
      
      private function onGuildMemberships(param1:class_2022) : void
      {
         _roomEvents.wiredCtrl.onGuildMemberships(param1);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var _loc2_:class_57 = _roomEvents.communication;
         if(_messageEvents != null && _loc2_ != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _loc2_.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         _roomEvents = null;
      }
      
      public function get disposed() : Boolean
      {
         return _roomEvents == null;
      }
   }
}

