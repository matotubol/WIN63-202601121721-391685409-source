package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideOnDutyStatusMessageEventParser implements IMessageParser
   {
      
      private var _onDuty:Boolean;
      
      private var var_4616:int;
      
      private var var_4318:int;
      
      private var var_3941:int;
      
      public function GuideOnDutyStatusMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _onDuty = param1.readBoolean();
         var_4616 = param1.readInteger();
         var_4318 = param1.readInteger();
         var_3941 = param1.readInteger();
         return true;
      }
      
      public function get onDuty() : Boolean
      {
         return _onDuty;
      }
      
      public function get helpersOnDuty() : int
      {
         return var_4318;
      }
      
      public function get guardiansOnDuty() : int
      {
         return var_3941;
      }
      
      public function get guidesOnDuty() : int
      {
         return var_4616;
      }
   }
}

