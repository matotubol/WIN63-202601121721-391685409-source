package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
   
   public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_37:IConnection = null;
      
      private var var_3624:IMessageEvent;
      
      public function SpamWallPostItWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_SPAMWALL_POSTIT_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_3624 = new RequestSpamWallPostItMessageEvent(onSpamWallPostItRequest);
         var_37 = param1;
         var_37.addMessageEvent(var_3624);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            var_37.removeMessageEvent(var_3624);
            var_37 = null;
         }
      }
      
      private function onSpamWallPostItRequest(param1:RequestSpamWallPostItMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:RequestSpamWallPostItMessageEventParser = param1.getParser();
         var _loc2_:int = _loc5_.itemId;
         var _loc6_:String = _loc5_.location;
         if(_container.inventory != null)
         {
            var _loc4_:class_1875 = _container.inventory.getWallItemById(_loc2_);
         }
         if(_container != null)
         {
            if(_container.events != null)
            {
               _container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent("RWSWPUE_OPEN_EDITOR",_loc2_,_loc6_,"post_it"));
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWSWPUE_OPEN_EDITOR","RWSWPFEE_SEND_POSTIT_DATA"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetSpamWallPostItFinishEditingMessage = null;
         var _loc4_:* = param1.type;
         if("RWSWPFEE_SEND_POSTIT_DATA" === _loc4_)
         {
            _loc2_ = param1 as RoomWidgetSpamWallPostItFinishEditingMessage;
            if(_loc2_ != null)
            {
               if(var_37 != null)
               {
                  var _loc3_:AddSpamWallPostItMessageComposer = new AddSpamWallPostItMessageComposer(_loc2_.objectId,_loc2_.location,_loc2_.colorHex,_loc2_.text);
                  var_37.send(null);
               }
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

