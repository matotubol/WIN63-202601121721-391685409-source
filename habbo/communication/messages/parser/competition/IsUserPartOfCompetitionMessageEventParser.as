package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsUserPartOfCompetitionMessageEventParser implements IMessageParser
   {
      
      private var var_3594:Boolean;
      
      private var var_4433:int;
      
      public function IsUserPartOfCompetitionMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3594 = param1.readBoolean();
         var_4433 = param1.readInteger();
         return true;
      }
      
      public function get isPartOf() : Boolean
      {
         return var_3594;
      }
      
      public function get targetId() : int
      {
         return var_4433;
      }
   }
}

