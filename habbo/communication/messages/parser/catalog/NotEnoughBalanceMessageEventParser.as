package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NotEnoughBalanceMessageEventParser implements IMessageParser
   {
      
      private var var_2825:Boolean = false;
      
      private var var_2781:Boolean = false;
      
      private var var_2381:int = 0;
      
      public function NotEnoughBalanceMessageEventParser()
      {
         super();
      }
      
      public function get notEnoughCredits() : Boolean
      {
         return var_2825;
      }
      
      public function get notEnoughActivityPoints() : Boolean
      {
         return var_2781;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function flush() : Boolean
      {
         var_2825 = false;
         var_2781 = false;
         var_2381 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2825 = param1.readBoolean();
         var_2781 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            var_2381 = param1.readInteger();
         }
         return true;
      }
   }
}

