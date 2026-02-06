package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceStatusMessageEventParser implements IMessageParser
   {
      
      private var var_3518:Boolean;
      
      private var var_3111:int;
      
      private var var_3089:String;
      
      private var var_5166:Boolean;
      
      private var var_3688:int;
      
      private var var_4881:int;
      
      private var var_3071:int;
      
      public function RentableSpaceStatusMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3518 = param1.readBoolean();
         var_3688 = param1.readInteger();
         var_5166 = var_3688 === 0;
         var_3111 = param1.readInteger();
         var_3089 = param1.readString();
         var_4881 = param1.readInteger();
         var_3071 = param1.readInteger();
         if(!var_3518)
         {
            var_3111 = -1;
            var_3089 = "";
         }
         return true;
      }
      
      public function get rented() : Boolean
      {
         return var_3518;
      }
      
      public function get renterId() : int
      {
         return var_3111;
      }
      
      public function get renterName() : String
      {
         return var_3089;
      }
      
      public function get canRent() : Boolean
      {
         return var_5166;
      }
      
      public function get price() : int
      {
         return var_3071;
      }
      
      public function get timeRemaining() : int
      {
         return var_4881;
      }
      
      public function get canRentErrorCode() : int
      {
         return var_3688;
      }
   }
}

