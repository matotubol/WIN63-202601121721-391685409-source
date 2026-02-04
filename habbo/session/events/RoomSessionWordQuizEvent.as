package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.session.IRoomSession;
   import flash.utils.Dictionary;
   
   public class RoomSessionWordQuizEvent extends RoomSessionEvent
   {
      
      public static const const_99:String = "RWPUW_NEW_QUESTION";
      
      public static const FINISHED:String = "RWPUW_QUESION_FINSIHED";
      
      public static const const_114:String = "RWPUW_QUESTION_ANSWERED";
      
      private var var_197:int = -1;
      
      private var var_2980:String = null;
      
      private var var_2934:int = -1;
      
      private var var_2943:int = -1;
      
      private var var_2740:int = -1;
      
      private var var_431:Dictionary = null;
      
      private var var_1270:int = -1;
      
      private var _value:String;
      
      private var var_2463:class_55;
      
      public function RoomSessionWordQuizEvent(param1:String, param2:IRoomSession, param3:int = -1)
      {
         var_197 = param3;
         super(param1,param2);
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get pollType() : String
      {
         return var_2980;
      }
      
      public function set pollType(param1:String) : void
      {
         var_2980 = param1;
      }
      
      public function get pollId() : int
      {
         return var_2934;
      }
      
      public function set pollId(param1:int) : void
      {
         var_2934 = param1;
      }
      
      public function get questionId() : int
      {
         return var_2943;
      }
      
      public function set questionId(param1:int) : void
      {
         var_2943 = param1;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function set duration(param1:int) : void
      {
         var_2740 = param1;
      }
      
      public function get question() : Dictionary
      {
         return var_431;
      }
      
      public function set question(param1:Dictionary) : void
      {
         var_431 = param1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function set userId(param1:int) : void
      {
         var_1270 = param1;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         _value = param1;
      }
      
      public function get answerCounts() : class_55
      {
         return var_2463;
      }
      
      public function set answerCounts(param1:class_55) : void
      {
         var_2463 = param1;
      }
   }
}

