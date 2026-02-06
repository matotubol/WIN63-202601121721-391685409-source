package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class QuestionEventParser implements IMessageParser
   {
      
      private var var_2980:String = null;
      
      private var var_2934:int = -1;
      
      private var var_2943:int = -1;
      
      private var var_2740:int = -1;
      
      private var var_431:Dictionary = null;
      
      public function QuestionEventParser()
      {
         super();
      }
      
      public function get pollType() : String
      {
         return var_2980;
      }
      
      public function get pollId() : int
      {
         return var_2934;
      }
      
      public function get questionId() : int
      {
         return var_2943;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function get question() : Dictionary
      {
         return var_431;
      }
      
      public function flush() : Boolean
      {
         var_2980 = null;
         var_2934 = -1;
         var_2943 = -1;
         var_2740 = -1;
         var_431 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2980 = param1.readString();
         var_2934 = param1.readInteger();
         var_2943 = param1.readInteger();
         var_2740 = param1.readInteger();
         var_431 = new Dictionary();
         var_431["id"] = param1.readInteger();
         var_431["number"] = param1.readInteger();
         var_431["type"] = param1.readInteger();
         var_431["content"] = param1.readString();
         if(var_431["type"] == 1 || var_431["type"] == 2)
         {
            var_431["selection_min"] = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc4_:Array = [];
            var _loc5_:Array = [];
            var_431["selections"] = _loc4_;
            var_431["selection_values"] = _loc5_;
            var_431["selection_count"] = 0;
            var_431["selection_max"] = 0;
            var _loc3_:int = 0;
         }
         return true;
      }
   }
}

