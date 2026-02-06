package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OfferRewardDeliveredMessageEventParser implements IMessageParser
   {
      
      private var var_2763:String;
      
      private var var_1015:int;
      
      private var _name:String;
      
      private var var_735:String;
      
      public function OfferRewardDeliveredMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2763 = null;
         var_1015 = 0;
         _name = null;
         var_735 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2763 = param1.readString();
         var_1015 = param1.readInteger();
         _name = param1.readString();
         var_735 = param1.readString();
         return true;
      }
      
      public function get contentType() : String
      {
         return var_2763;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
   }
}

