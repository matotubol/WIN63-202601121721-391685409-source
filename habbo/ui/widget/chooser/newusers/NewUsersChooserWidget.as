package com.sulake.habbo.ui.widget.chooser.newusers
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.ui.widget.chooser.ChooserWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class NewUsersChooserWidget extends ChooserWidgetBase
   {
      
      private var var_1236:NewUsersView;
      
      private var _items:Array;
      
      public function NewUsersChooserWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(var_1236 != null)
         {
            var_1236.dispose();
            var_1236 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.addEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.removeEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(var_1236 == null)
         {
            var_1236 = new NewUsersView(this,"${widget.chooser.user.title}");
         }
         _items = [];
         for each(var _loc2_ in param1.items)
         {
            _items.push(_loc2_);
         }
         _items.sortOn(["lowerCaseName","id"],[null,16]);
         var_1236.onItemsChanged();
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      private function onUpdateUserChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var delayedAction:Timer;
         var event:RoomWidgetRoomObjectUpdateEvent = param1;
         if(var_1236 == null || !var_1236.isOpen())
         {
            return;
         }
         delayedAction = new Timer(100,1);
         delayedAction.addEventListener("timer",function(param1:TimerEvent):void
         {
            if(disposed)
            {
               return;
            }
            messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER"));
         });
         delayedAction.start();
      }
   }
}

