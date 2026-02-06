package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionAttachedMessageEventParser implements IMessageParser
   {
      
      private var var_4712:Boolean;
      
      private var var_4804:int;
      
      private var var_5022:String;
      
      private var var_4372:int;
      
      public function GuideSessionAttachedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4712 = param1.readBoolean();
         var_4804 = param1.readInteger();
         var_5022 = param1.readString();
         var_4372 = param1.readInteger();
         return true;
      }
      
      public function get asGuide() : Boolean
      {
         return var_4712;
      }
      
      public function get helpRequestType() : int
      {
         return var_4804;
      }
      
      public function get helpRequestDescription() : String
      {
         return var_5022;
      }
      
      public function get roleSpecificWaitTime() : int
      {
         return var_4372;
      }
   }
}

