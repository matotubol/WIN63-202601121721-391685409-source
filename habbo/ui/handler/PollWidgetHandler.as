package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.events.RoomSessionPollEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import flash.events.Event;
   
   public class PollWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function PollWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_POLL";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWPM_ANSWER","RWPM_REJECT","RWPM_START"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetPollMessage = param1 as RoomWidgetPollMessage;
         if(_loc2_ == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWPM_START":
               _container.roomSession.sendPollStartMessage(_loc2_.id);
               break;
            case "RWPM_REJECT":
               _container.roomSession.sendPollRejectMessage(_loc2_.id);
               break;
            case "RWPM_ANSWER":
               _container.roomSession.sendPollAnswerMessage(_loc2_.id,_loc2_.questionId,_loc2_.answers);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RSPE_POLL_OFFER");
         _loc1_.push("RSPE_POLL_ERROR");
         _loc1_.push("RSPE_POLL_CONTENT");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomWidgetPollUpdateEvent = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         var _loc3_:RoomSessionPollEvent = param1 as RoomSessionPollEvent;
         if(_loc3_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSPE_POLL_OFFER":
               _loc2_ = new RoomWidgetPollUpdateEvent(_loc3_.id,"RWPUW_OFFER");
               _loc2_.summary = _loc3_.summary;
               _loc2_.headline = _loc3_.headline;
               break;
            case "RSPE_POLL_ERROR":
               _loc2_ = new RoomWidgetPollUpdateEvent(_loc3_.id,"RWPUW_ERROR");
               _loc2_.summary = _loc3_.summary;
               _loc2_.headline = _loc3_.headline;
               break;
            case "RSPE_POLL_CONTENT":
               _loc2_ = new RoomWidgetPollUpdateEvent(_loc3_.id,"RWPUW_CONTENT");
               _loc2_.startMessage = _loc3_.startMessage;
               _loc2_.endMessage = _loc3_.endMessage;
               _loc2_.numQuestions = _loc3_.numQuestions;
               _loc2_.questionArray = _loc3_.questionArray;
               _loc2_.npsPoll = _loc3_.npsPoll;
         }
         if(_loc2_ == null)
         {
            return;
         }
         _container.events.dispatchEvent(_loc2_);
      }
      
      public function update() : void
      {
      }
   }
}

