package com.sulake.habbo.communication.messages.parser.advertisement
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InterstitialMessageEventParser implements IMessageParser
   {
      
      private var var_3225:Boolean;
      
      public function InterstitialMessageEventParser()
      {
         super();
      }
      
      public function get canShowInterstitial() : Boolean
      {
         return var_3225;
      }
      
      public function flush() : Boolean
      {
         var_3225 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3225 = param1.readBoolean();
         return true;
      }
   }
}

