package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.friendfurni.FriendFurniConfirmLockMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniStartConfirmationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniCancelLockMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniOtherLockConfirmedMessageEvent;
   
   public class class_3437 implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:FriendFurniConfirmWidget;
      
      private var var_37:IConnection;
      
      private var var_2454:IMessageEvent = null;
      
      private var var_3609:IMessageEvent = null;
      
      private var var_3570:IMessageEvent = null;
      
      public function class_3437()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:FriendFurniConfirmWidget) : void
      {
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_37 && var_2454)
            {
               var_37.removeMessageEvent(var_2454);
               var_37.removeMessageEvent(var_3609);
               var_37.removeMessageEvent(var_3570);
               var_37 = null;
            }
            var_16 = null;
            _container = null;
            _disposed = true;
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_37 = param1;
         if(!var_2454)
         {
            var_2454 = new FriendFurniStartConfirmationMessageEvent(onStartConfirmation);
            var_3609 = new FriendFurniOtherLockConfirmedMessageEvent(onOtherLockConfirmed);
            var_3570 = new FriendFurniCancelLockMessageEvent(onCancelLock);
            var_37.addMessageEvent(var_2454);
            var_37.addMessageEvent(var_3609);
            var_37.addMessageEvent(var_3570);
         }
      }
      
      public function sendLockConfirm(param1:int, param2:Boolean) : void
      {
         var_37.send(new FriendFurniConfirmLockMessageComposer(param1,param2));
      }
      
      private function onStartConfirmation(param1:FriendFurniStartConfirmationMessageEvent) : void
      {
         var_16.open(param1.getParser().stuffId,param1.getParser().isOwner);
      }
      
      private function onOtherLockConfirmed(param1:FriendFurniOtherLockConfirmedMessageEvent) : void
      {
         var_16.otherConfirmed(param1.getParser().stuffId);
      }
      
      private function onCancelLock(param1:FriendFurniCancelLockMessageEvent) : void
      {
         var_16.close(param1.getParser().stuffId);
      }
      
      public function get type() : String
      {
         return "";
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function update() : void
      {
      }
   }
}

