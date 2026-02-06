package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3789
   {
      
      private var var_4100:int;
      
      private var var_4850:int;
      
      private var var_150:int;
      
      private var var_4684:int;
      
      private var var_3307:class_4059;
      
      public function class_3789(param1:IMessageDataWrapper)
      {
         super();
         var_4100 = param1.readInteger();
         var_4850 = param1.readInteger();
         var_150 = param1.readInteger();
         var_4684 = param1.readInteger();
         var_3307 = new class_4059(param1);
      }
      
      public function get callId() : int
      {
         return var_4100;
      }
      
      public function get callerUserId() : int
      {
         return var_4850;
      }
      
      public function get reportedUserId() : int
      {
         return var_150;
      }
      
      public function get chatRecordId() : int
      {
         return var_4684;
      }
      
      public function get chatRecord() : class_4059
      {
         return var_3307;
      }
   }
}

