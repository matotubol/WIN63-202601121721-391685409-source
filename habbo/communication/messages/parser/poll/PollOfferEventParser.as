package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PollOfferEventParser implements IMessageParser
   {
      
      private var var_197:int = -1;
      
      private var var_230:String = "";
      
      private var _headline:String = "";
      
      private var var_2854:String = "";
      
      public function PollOfferEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get headline() : String
      {
         return _headline;
      }
      
      public function get summary() : String
      {
         return var_2854;
      }
      
      public function flush() : Boolean
      {
         var_197 = -1;
         var_230 = "";
         var_2854 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_197 = param1.readInteger();
         var_230 = param1.readString();
         _headline = param1.readString();
         var_2854 = param1.readString();
         return true;
      }
   }
}

