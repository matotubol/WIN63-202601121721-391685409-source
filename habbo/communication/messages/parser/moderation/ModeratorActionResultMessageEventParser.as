package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorActionResultMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_2614:Boolean;
      
      public function ModeratorActionResultMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_2614 = param1.readBoolean();
         return true;
      }
   }
}

