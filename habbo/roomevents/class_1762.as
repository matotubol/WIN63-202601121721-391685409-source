package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniSelectorEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniAddonEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniVariableEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3569;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniAddonEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniSelectorEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredRewardResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniVariableEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerEventParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredValidationErrorEventParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectEventParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   
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
         addMessageEvent(new WiredFurniSelectorEvent(onSelector));
         addMessageEvent(new WiredRewardResultMessageEvent(onRewardFailed));
         addMessageEvent(new OpenEvent(onOpen));
         addMessageEvent(new WiredFurniAddonEvent(onAddon));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         addMessageEvent(new WiredSaveSuccessEvent(onSaveSuccess));
         addMessageEvent(new WiredFurniVariableEvent(onVariable));
         addMessageEvent(new WiredFurniConditionEvent(onCondition));
         addMessageEvent(new GuildMembershipsMessageEvent(onGuildMemberships));
         addMessageEvent(new WiredFurniTriggerEvent(onTrigger));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new WiredFurniActionEvent(onAction));
         addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
         addMessageEvent(new WiredValidationErrorEvent(onValidationError));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_roomEvents.communication.addHabboConnectionMessageEvent(param1));
      }
      
      private function onOpen(param1:IMessageEvent) : void
      {
         var _loc2_:OpenEventParser = (param1 as OpenEvent).getParser();
         _roomEvents.send(new OpenMessageComposer(_loc2_.stuffId));
      }
      
      private function onTrigger(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniTriggerEventParser = (param1 as WiredFurniTriggerEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAction(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniActionEventParser = (param1 as WiredFurniActionEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onCondition(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniConditionEventParser = (param1 as WiredFurniConditionEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAddon(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniAddonEventParser = (param1 as WiredFurniAddonEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onVariable(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniVariableEventParser = (param1 as WiredFurniVariableEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onSelector(param1:IMessageEvent) : void
      {
         var _loc2_:WiredFurniSelectorEventParser = (param1 as WiredFurniSelectorEvent).getParser();
         _roomEvents.wiredCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEventParser = (param1 as UserObjectEvent).getParser();
         _roomEvents.userName = _loc2_.name;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _roomEvents.wiredCtrl.close();
      }
      
      private function onObjectRemove(param1:IMessageEvent) : void
      {
         var _loc2_:ObjectRemoveMessageEventParser = (param1 as ObjectRemoveMessageEvent).getParser();
         class_21.log("Received object remove event: " + _loc2_.id + ", " + _loc2_.isExpired);
         _roomEvents.wiredCtrl.stuffRemoved(_loc2_.id);
      }
      
      private function onRewardFailed(param1:IMessageEvent) : void
      {
         var _loc2_:WiredRewardResultMessageEventParser = WiredRewardResultMessageEvent(param1).getParser();
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
         var _loc3_:WiredValidationErrorEventParser = WiredValidationErrorEvent(param1).getParser();
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
      
      private function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
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

