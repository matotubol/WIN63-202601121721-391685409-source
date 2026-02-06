package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3449
   {
      
      private var var_1229:int;
      
      private var _senderName:String;
      
      private var var_2792:String;
      
      private var var_986:String;
      
      private var var_3850:int;
      
      private var var_2915:String;
      
      public function class_3449(param1:IMessageDataWrapper)
      {
         super();
         var_1229 = param1.readInteger();
         _senderName = param1.readString();
         var_2792 = param1.readString();
         var_986 = param1.readString();
         var_3850 = param1.readInteger();
         var_2915 = param1.readString();
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
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get secondsSinceSent() : int
      {
         return var_3850;
      }
      
      public function get messageId() : String
      {
         return var_2915;
      }
   }
}

