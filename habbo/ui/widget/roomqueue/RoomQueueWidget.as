package com.sulake.habbo.ui.widget.roomqueue
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class RoomQueueWidget extends RoomWidgetBase
   {
      
      private var _window:class_2250;
      
      private var _config:class_16;
      
      private var var_1353:int;
      
      private var var_5128:Boolean;
      
      private var var_3446:String;
      
      private var var_3534:Boolean;
      
      public function RoomQueueWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_16)
      {
         super(param1,param2,param3,param4);
         _config = param5;
      }
      
      override public function dispose() : void
      {
         removeWindow();
         _config = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.addEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.removeEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
      }
      
      private function removeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onQueueStatus(param1:RoomWidgetRoomQueueUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.isActive)
         {
            var_3446 = param1.type;
            var_1353 = param1.position;
         }
         var_5128 = param1.hasHabboClub;
         var_3534 = param1.isClubQueue;
         localizations.registerParameter("room.queue.position","position",var_1353.toString());
         localizations.registerParameter("room.queue.position.hc","position",var_1353.toString());
         localizations.registerParameter("room.queue.spectator.position","position",var_1353.toString());
         localizations.registerParameter("room.queue.spectator.position.hc","position",var_1353.toString());
         showInterface();
      }
      
      private function createWindow() : Boolean
      {
         if(_window != null)
         {
            return true;
         }
         var _loc2_:XmlAsset = assets.getAssetByName("room_queue") as XmlAsset;
         _window = windowManager.buildFromXML(_loc2_.content as XML) as class_2250;
         if(_window == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc1_:class_1741 = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("cancel_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("link_text");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",openLink);
         }
         _loc1_ = _window.findChildByName("change_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",changeQueue);
         }
         return true;
      }
      
      private function showInterface() : void
      {
         if(!createWindow())
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ != null)
         {
            switch(var_3446)
            {
               case "RWRQUE_VISITOR_QUEUE_STATUS":
                  _loc2_.caption = var_3534 ? "${room.queue.position.hc}" : "${room.queue.position}";
                  break;
               case "RWRQUE_SPECTATOR_QUEUE_STATUS":
                  _loc2_.caption = var_3534 ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}";
            }
         }
         var _loc1_:class_1812 = _window.findChildByName("club_container") as class_1812;
         if(_loc1_ != null)
         {
            _loc1_.visible = !var_5128;
         }
         _window.visible = true;
      }
      
      private function exitQueue(param1:WindowMouseEvent) : void
      {
         if(messageListener == null)
         {
            return;
         }
         var _loc2_:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage("RWRQM_EXIT_QUEUE");
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
      
      private function openLink(param1:WindowMouseEvent) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomQueueMessage("RWRQM_CLUB_LINK"));
      }
      
      private function changeQueue(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetRoomQueueMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(var_3446 == "RWRQUE_VISITOR_QUEUE_STATUS")
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
         }
         else
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_VISITOR_QUEUE");
         }
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
   }
}

