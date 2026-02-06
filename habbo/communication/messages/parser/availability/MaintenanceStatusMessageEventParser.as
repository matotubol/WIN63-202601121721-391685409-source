package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MaintenanceStatusMessageEventParser implements IMessageParser
   {
      
      private var var_4226:Boolean;
      
      private var var_4763:int;
      
      private var var_2740:int = 15;
      
      public function MaintenanceStatusMessageEventParser()
      {
         super();
      }
      
      public function get isInMaintenance() : Boolean
      {
         return var_4226;
      }
      
      public function get minutesUntilMaintenance() : int
      {
         return var_4763;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4226 = param1.readBoolean();
         var_4763 = param1.readInteger();
         if(param1.bytesAvailable)
         {
            var_2740 = param1.readInteger();
         }
         return true;
      }
   }
}

