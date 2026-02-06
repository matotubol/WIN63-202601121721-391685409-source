package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendUserInfoEventParser implements IMessageParser
   {
      
      public static const const_308:int = 1;
      
      public static const const_367:int = 2;
      
      public static const const_192:int = 3;
      
      public static const const_921:int = 4;
      
      private var _productName:String;
      
      private var var_4245:int;
      
      private var var_4893:int;
      
      private var var_4535:int;
      
      private var var_4224:int;
      
      private var var_4273:Boolean;
      
      private var var_4740:Boolean;
      
      private var var_4545:int;
      
      private var var_4257:int;
      
      private var var_4373:int;
      
      private var var_4368:int;
      
      public function ScrSendUserInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _productName = param1.readString();
         var_4245 = param1.readInteger();
         var_4893 = param1.readInteger();
         var_4535 = param1.readInteger();
         var_4224 = param1.readInteger();
         var_4273 = param1.readBoolean();
         var_4740 = param1.readBoolean();
         var_4545 = param1.readInteger();
         var_4257 = param1.readInteger();
         var_4373 = param1.readInteger();
         if(param1.bytesAvailable)
         {
            var_4368 = param1.readInteger();
         }
         return true;
      }
      
      public function get productName() : String
      {
         return _productName;
      }
      
      public function get daysToPeriodEnd() : int
      {
         return var_4245;
      }
      
      public function get memberPeriods() : int
      {
         return var_4893;
      }
      
      public function get periodsSubscribedAhead() : int
      {
         return var_4535;
      }
      
      public function get responseType() : int
      {
         return var_4224;
      }
      
      public function get hasEverBeenMember() : Boolean
      {
         return var_4273;
      }
      
      public function get isVIP() : Boolean
      {
         return var_4740;
      }
      
      public function get pastClubDays() : int
      {
         return var_4545;
      }
      
      public function get pastVipDays() : int
      {
         return var_4257;
      }
      
      public function get minutesUntilExpiration() : int
      {
         return var_4373;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return var_4368;
      }
   }
}

