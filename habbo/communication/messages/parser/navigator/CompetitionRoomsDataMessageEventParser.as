package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1904;
   
   [SecureSWF(rename="true")]
   public class CompetitionRoomsDataMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_1904;
      
      public function CompetitionRoomsDataMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_1904(param1);
         return true;
      }
      
      public function get data() : class_1904
      {
         return var_24;
      }
   }
}

