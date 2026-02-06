package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3823
   {
      
      private var var_2416:String;
      
      private var var_4930:int;
      
      private var var_4131:String;
      
      private var _msg:String;
      
      private var var_5066:Boolean;
      
      public function class_3823(param1:IMessageDataWrapper)
      {
         super();
         var_2416 = param1.readString();
         var_4930 = param1.readInteger();
         var_4131 = param1.readString();
         _msg = param1.readString();
         var_5066 = param1.readBoolean();
      }
      
      public function get timeStamp() : String
      {
         return var_2416;
      }
      
      public function get chatterId() : int
      {
         return var_4930;
      }
      
      public function get chatterName() : String
      {
         return var_4131;
      }
      
      public function get msg() : String
      {
         return _msg;
      }
      
      public function get hasHighlighting() : Boolean
      {
         return var_5066;
      }
   }
}

