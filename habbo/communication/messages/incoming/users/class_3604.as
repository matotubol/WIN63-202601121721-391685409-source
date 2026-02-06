package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3604
   {
      
      private var var_4623:int;
      
      private var var_4441:int;
      
      private var var_4924:int;
      
      private var var_5075:String;
      
      private var var_4670:String;
      
      public function class_3604(param1:IMessageDataWrapper)
      {
         super();
         var_4623 = param1.readInteger();
         var_4441 = param1.readInteger();
         var_4924 = param1.readInteger();
         var_5075 = param1.readString();
         var_4670 = param1.readString();
      }
      
      public function get relationshipStatusType() : int
      {
         return var_4623;
      }
      
      public function get friendCount() : int
      {
         return var_4441;
      }
      
      public function get randomFriendId() : int
      {
         return var_4924;
      }
      
      public function get randomFriendName() : String
      {
         return var_5075;
      }
      
      public function get randomFriendFigure() : String
      {
         return var_4670;
      }
   }
}

