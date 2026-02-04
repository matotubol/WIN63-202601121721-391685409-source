package com.sulake.habbo.ui.widget.furniture.stickie
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class SpamWallPostItFurniWidget extends StickieFurniWidget
   {
      
      private var var_559:String = "";
      
      public function SpamWallPostItFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null)
      {
         _windowName = "spamwall_postit_container";
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         var_315 = -1;
         var_559 = "";
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.addEventListener("RWSWPUE_OPEN_EDITOR",onEditPostItRequest);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSWPUE_OPEN_EDITOR",onEditPostItRequest);
      }
      
      override protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent) : void
      {
      }
      
      private function onEditPostItRequest(param1:RoomWidgetSpamWallPostItEditEvent) : void
      {
         hideInterface(false);
         var_315 = param1.objectId;
         var_559 = param1.location;
         var_2300 = param1.objectType;
         _text = "";
         var_628 = "FFFF33";
         var_55 = true;
         showInterface();
      }
      
      override protected function sendUpdate() : void
      {
         var _loc1_:RoomWidgetSpamWallPostItFinishEditingMessage = null;
         if(var_315 != -1)
         {
            storeTextFromField();
            class_21.log("Spamwall Post-It Widget Send Update");
            if(messageListener != null)
            {
               _loc1_ = new RoomWidgetSpamWallPostItFinishEditingMessage("RWSWPFEE_SEND_POSTIT_DATA",var_315,var_559,_text,var_628);
               messageListener.processWidgetMessage(_loc1_);
            }
            hideInterface(false);
         }
      }
      
      override protected function sendSetColor(param1:uint) : void
      {
         storeTextFromField();
         var _loc2_:String = param1.toString(16).toUpperCase();
         if(_loc2_.length > 6)
         {
            _loc2_ = _loc2_.slice(_loc2_.length - 6,_loc2_.length);
         }
         if(_loc2_ == var_628)
         {
            return;
         }
         var_628 = _loc2_;
         showInterface();
      }
      
      override protected function sendDelete() : void
      {
         hideInterface(false);
      }
   }
}

