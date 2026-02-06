package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_2217;
   
   [SecureSWF(rename="true")]
   public class class_3472 implements class_2217
   {
      
      private var _name:String;
      
      private var var_4539:int;
      
      private var var_5251:int;
      
      private var var_5027:Boolean;
      
      private var var_5155:String = "";
      
      private var var_5065:String = "";
      
      public function class_3472(param1:IMessageDataWrapper)
      {
         super();
         _name = param1.readString();
         var_4539 = param1.readInteger();
         var_5251 = param1.readInteger();
         var_5027 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            var_5155 = param1.readString();
         }
         if(param1.bytesAvailable)
         {
            var_5065 = param1.readString();
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get sanctionLengthInHours() : int
      {
         return var_4539;
      }
      
      public function get avatarOnly() : Boolean
      {
         return var_5027;
      }
      
      public function get tradeLockInfo() : String
      {
         return var_5155;
      }
      
      public function get machineBanInfo() : String
      {
         return var_5065;
      }
   }
}

