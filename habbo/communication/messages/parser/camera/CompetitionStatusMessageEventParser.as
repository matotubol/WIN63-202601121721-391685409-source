package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionStatusMessageEventParser implements IMessageParser
   {
      
      private var var_2577:Boolean = false;
      
      private var var_3347:String = null;
      
      public function CompetitionStatusMessageEventParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return var_2577;
      }
      
      public function getErrorReason() : String
      {
         return var_3347;
      }
      
      public function flush() : Boolean
      {
         var_2577 = false;
         var_3347 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2577 = param1.readBoolean();
         var_3347 = param1.readString();
         return true;
      }
   }
}

