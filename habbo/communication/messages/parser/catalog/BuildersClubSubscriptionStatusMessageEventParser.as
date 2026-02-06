package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubSubscriptionStatusMessageEventParser implements IMessageParser
   {
      
      private var var_3145:int;
      
      private var var_4130:int;
      
      private var var_3899:int;
      
      private var var_2746:int;
      
      public function BuildersClubSubscriptionStatusMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3145 = param1.readInteger();
         var_4130 = param1.readInteger();
         var_3899 = param1.readInteger();
         if(param1.bytesAvailable)
         {
            var_2746 = param1.readInteger();
         }
         else
         {
            var_2746 = var_3145;
         }
         return true;
      }
      
      public function get secondsLeft() : int
      {
         return var_3145;
      }
      
      public function get furniLimit() : int
      {
         return var_4130;
      }
      
      public function get maxFurniLimit() : int
      {
         return var_3899;
      }
      
      public function get secondsLeftWithGrace() : int
      {
         return var_2746;
      }
   }
}

