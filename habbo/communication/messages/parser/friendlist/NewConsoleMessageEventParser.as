package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NewConsoleMessageEventParser implements IMessageParser
   {
      
      private var var_4642:int;
      
      private var var_940:String;
      
      private var var_3850:int;
      
      private var var_2915:String;
      
      private var var_5178:int;
      
      private var var_1229:int;
      
      private var _senderName:String;
      
      private var var_2792:String;
      
      public function NewConsoleMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_4642 = param1.readInteger();
         this.var_940 = param1.readString();
         this.var_3850 = param1.readInteger();
         this.var_2915 = param1.readString();
         this.var_5178 = param1.readInteger();
         this.var_1229 = param1.readInteger();
         this._senderName = param1.readString();
         this.var_2792 = param1.readString();
         return true;
      }
      
      public function get chatId() : int
      {
         return this.var_4642;
      }
      
      public function get messageText() : String
      {
         return this.var_940;
      }
      
      public function get secondsSinceSent() : int
      {
         return var_3850;
      }
      
      public function get messageId() : String
      {
         return var_2915;
      }
      
      public function get confirmationId() : int
      {
         return var_5178;
      }
      
      public function get senderId() : int
      {
         return var_1229;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get senderFigure() : String
      {
         return var_2792;
      }
   }
}

