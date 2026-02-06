package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   
   public class CitizenshipPopupController implements class_13
   {
      
      private var _habboTalent:HabboTalent;
      
      private var var_393:IModalDialog;
      
      private var _disposed:Boolean;
      
      private var var_2607:RoomEntryInfoMessageEvent;
      
      private var var_4143:Boolean;
      
      public function CitizenshipPopupController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
         var_2607 = new RoomEntryInfoMessageEvent(onRoomEnter);
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(var_2607);
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:Timer = null;
         if(_habboTalent.newIdentity && !var_4143 && _habboTalent.getBoolean("new.user.citizenship.popup.enabled"))
         {
            _loc2_ = new Timer(10000,1);
            _loc2_.addEventListener("timer",onCitizenshipPopup);
            _loc2_.start();
         }
      }
      
      private function onCitizenshipPopup(param1:TimerEvent) : void
      {
         removeRoomEnterListener();
         show();
         var_4143 = true;
      }
      
      private function removeRoomEnterListener() : void
      {
         if(_habboTalent != null && !_habboTalent.disposed)
         {
            _habboTalent.communicationManager.removeHabboConnectionMessageEvent(var_2607);
         }
         var_2607 = null;
      }
      
      public function show() : void
      {
         hide();
         var_393 = _habboTalent.getModalXmlWindow("citizenship_welcome");
         var_393.rootWindow.procedure = onWindowEvent;
         class_1812(var_393.rootWindow).findChildByName("header_button_close").visible = false;
      }
      
      private function hide() : void
      {
         if(var_393 != null && !var_393.disposed)
         {
            var_393.dispose();
            var_393 = null;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            hide();
            removeRoomEnterListener();
            _habboTalent = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(var_393 == null || Boolean(var_393.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "postpone_citizenship":
               hide();
               break;
            case "show_citizenship":
               hide();
               _habboTalent.tracking.trackTalentTrackOpen("citizenship","citizenshippopup");
               _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
         }
      }
   }
}

