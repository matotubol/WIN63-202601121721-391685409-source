package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BanInfoMessageEventParser implements IMessageParser
   {
      
      private var var_202:int;
      
      private var var_2352:String;
      
      private var var_2984:int;
      
      private var var_3366:String;
      
      public function BanInfoMessageEventParser()
      {
         super();
      }
      
      public function get target() : int
      {
         return var_202;
      }
      
      public function get reason() : String
      {
         return var_2352;
      }
      
      public function get banExpirySeconds() : Number
      {
         return var_2984;
      }
      
      public function get localizedReason() : String
      {
         return var_3366;
      }
      
      public function flush() : Boolean
      {
         var_202 = -1;
         var_2352 = "";
         var_2984 = -1;
         var_3366 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_202 = param1.readShort();
         var_2352 = param1.readString();
         var_2984 = param1.readInteger();
         var_3366 = param1.readString();
         return true;
      }
   }
}

