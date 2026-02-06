package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionWordQuizEvent;
   import com.sulake.habbo.communication.messages.incoming.poll.QuestionEvent;
   import com.sulake.habbo.communication.messages.incoming.poll.QuestionFinishedEvent;
   import com.sulake.habbo.communication.messages.incoming.poll.QuestionAnsweredEvent;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionFinishedEventParser;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionAnsweredEventParser;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionEventParser;
   
   public class WordQuizHandler extends BaseHandler
   {
      
      public function WordQuizHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(!param1)
         {
            return;
         }
         param1.addMessageEvent(new QuestionEvent(onQuestionStatus));
         param1.addMessageEvent(new QuestionAnsweredEvent(onQuestionAnsweredEvent));
         param1.addMessageEvent(new QuestionFinishedEvent(onQuestionFinishedEvent));
      }
      
      private function onQuestionStatus(param1:QuestionEvent) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:QuestionEventParser = param1.getParser();
         _loc4_ = new RoomSessionWordQuizEvent("RWPUW_NEW_QUESTION",_loc3_,_loc2_.pollId);
         _loc4_.question = _loc2_.question;
         _loc4_.duration = _loc2_.duration;
         _loc4_.pollType = _loc2_.pollType;
         _loc4_.questionId = _loc2_.questionId;
         _loc4_.pollId = _loc2_.pollId;
         listener.events.dispatchEvent(_loc4_);
      }
      
      private function onQuestionAnsweredEvent(param1:QuestionAnsweredEvent) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:QuestionAnsweredEventParser = param1.getParser();
         _loc4_ = new RoomSessionWordQuizEvent("RWPUW_QUESTION_ANSWERED",_loc3_,_loc2_.userId);
         _loc4_.value = _loc2_.value;
         _loc4_.userId = _loc2_.userId;
         _loc4_.answerCounts = _loc2_.answerCounts;
         listener.events.dispatchEvent(_loc4_);
      }
      
      private function onQuestionFinishedEvent(param1:QuestionFinishedEvent) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:QuestionFinishedEventParser = param1.getParser();
         _loc4_ = new RoomSessionWordQuizEvent("RWPUW_QUESION_FINSIHED",_loc3_);
         _loc4_.questionId = _loc2_.questionId;
         _loc4_.answerCounts = _loc2_.answerCounts;
         listener.events.dispatchEvent(_loc4_);
      }
   }
}

