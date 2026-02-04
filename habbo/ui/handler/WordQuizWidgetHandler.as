package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.enum.class_2814;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionWordQuizEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class WordQuizWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function WordQuizWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_WORD_QUIZZ";
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
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get roomSession() : IRoomSession
      {
         return _container ? _container.roomSession : null;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _container ? _container.roomEngine : null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWPUW_QUESTION_ANSWERED","RWPUW_QUESION_FINSIHED","RWPUW_NEW_QUESTION"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWPUW_QUESTION_ANSWERED");
         _loc1_.push("RWPUW_QUESION_FINSIHED");
         _loc1_.push("RWPUW_NEW_QUESTION");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc4_:RoomWidgetWordQuizUpdateEvent = null;
         var _loc3_:class_2146 = null;
         if(_container == null || _container.events == null || _container.roomSession == null)
         {
            return;
         }
         var _loc2_:RoomSessionWordQuizEvent = param1 as RoomSessionWordQuizEvent;
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RWPUW_QUESTION_ANSWERED":
               _loc4_ = new RoomWidgetWordQuizUpdateEvent(_loc2_.id,"RWPUW_QUESTION_ANSWERED");
               _loc4_.value = _loc2_.value;
               _loc4_.userId = _loc2_.userId;
               _loc4_.answerCounts = _loc2_.answerCounts;
               _loc3_ = _container.roomSession.userDataManager.getUserData(_loc2_.userId);
               if(!_loc3_)
               {
                  return;
               }
               if(_loc4_.value == "0")
               {
                  _container.roomEngine.updateObjectUserGesture(_container.roomSession.roomId,_loc3_.roomObjectId,class_2814.getGestureId("sad"));
                  break;
               }
               _container.roomEngine.updateObjectUserGesture(_container.roomSession.roomId,_loc3_.roomObjectId,class_2814.getGestureId("sml"));
               break;
            case "RWPUW_QUESION_FINSIHED":
               _loc4_ = new RoomWidgetWordQuizUpdateEvent(_loc2_.id,"RWPUW_QUESION_FINSIHED");
               _loc4_.pollId = _loc2_.pollId;
               _loc4_.questionId = _loc2_.questionId;
               _loc4_.answerCounts = _loc2_.answerCounts;
               break;
            case "RWPUW_NEW_QUESTION":
               _loc4_ = new RoomWidgetWordQuizUpdateEvent(_loc2_.id,"RWPUW_NEW_QUESTION");
               _loc4_.question = _loc2_.question;
               _loc4_.duration = _loc2_.duration;
               _loc4_.pollType = _loc2_.pollType;
               _loc4_.questionId = _loc2_.questionId;
               _loc4_.pollId = _loc2_.pollId;
         }
         if(_loc4_ == null)
         {
            return;
         }
         _container.events.dispatchEvent(_loc4_);
      }
      
      public function update() : void
      {
      }
   }
}

