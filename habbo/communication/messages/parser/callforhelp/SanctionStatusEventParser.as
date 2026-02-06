package com.sulake.habbo.communication.messages.parser.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SanctionStatusEventParser implements IMessageParser
   {
      
      private var var_4883:Boolean;
      
      private var var_3880:Boolean;
      
      private var var_4762:String;
      
      private var var_4090:int;
      
      private var var_5129:String;
      
      private var var_3824:String;
      
      private var var_4708:int;
      
      private var var_4993:String;
      
      private var var_4578:int;
      
      private var var_4438:Boolean;
      
      private var var_4664:String;
      
      public function SanctionStatusEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4883 = param1.readBoolean();
         var_3880 = param1.readBoolean();
         var_4762 = param1.readString();
         var_4090 = param1.readInteger();
         param1.readInteger();
         var_5129 = param1.readString();
         var_3824 = param1.readString();
         var_4708 = param1.readInteger();
         var_4993 = param1.readString();
         var_4578 = param1.readInteger();
         param1.readInteger();
         var_4438 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            var_4664 = param1.readString();
         }
         return true;
      }
      
      public function get isSanctionNew() : Boolean
      {
         return var_4883;
      }
      
      public function get isSanctionActive() : Boolean
      {
         return var_3880;
      }
      
      public function get sanctionName() : String
      {
         return var_4762;
      }
      
      public function get sanctionLengthHours() : int
      {
         return var_4090;
      }
      
      public function get sanctionReason() : String
      {
         return var_5129;
      }
      
      public function get sanctionCreationTime() : String
      {
         return var_3824;
      }
      
      public function get probationHoursLeft() : int
      {
         return var_4708;
      }
      
      public function get nextSanctionName() : String
      {
         return var_4993;
      }
      
      public function get nextSanctionLengthHours() : int
      {
         return var_4578;
      }
      
      public function get hasCustomMute() : Boolean
      {
         return var_4438;
      }
      
      public function get tradeLockExpiryTime() : String
      {
         return var_4664;
      }
   }
}

